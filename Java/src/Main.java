import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.classifiers.trees.J48;
import weka.classifiers.Evaluation;
import java.util.Random;
import java.util.Scanner;

public class Main {
	public static void main(String args[]) throws Exception {
		 DataSource source = new DataSource("datos.arff");
		 Instances data = source.getDataSet();
		 
		 if (data.classIndex() == -1) {
			 data.setClassIndex(data.numAttributes() - 1);
		 }
		      
		 String[] options = new String[1];	 
 		 options[0] = "-U";
 		 J48 tree = new J48();
		 tree.setOptions(options);    
		 
		 tree.buildClassifier(data);
		 
		 Evaluation eval = new Evaluation(data);
		 eval.crossValidateModel(tree, data, 10, new Random(1));
		 
		 Instance toClassify = new DenseInstance(data.numAttributes());
		 toClassify.setDataset(data);
		 
		 Scanner reader = new Scanner(System.in);
		 
		 System.out.println(tree.toString());
		 
		 for(int i = 0; i < data.numAttributes() - 1; i++) {
			 System.out.print("Introduzca el valor para el atributo " + data.attribute(i).name() + ": ");
			 if(data.attribute(i).isNominal()) {
				 String value = reader.nextLine();
				 toClassify.setValue(i, value);
				 System.out.println(toClassify.toString());
			 }
			 else {
				 String value = reader.nextLine();
				 toClassify.setValue(i, Integer.parseInt(value));
				 System.out.println(toClassify.toString());
			 }
		 }
		 
		 reader.close();
		 
		 double result = tree.classifyInstance(toClassify);
		 toClassify.setClassValue(result);
		 System.out.println("La prevision es tráfico: " + toClassify.stringValue(toClassify.classIndex()));
	}
}
