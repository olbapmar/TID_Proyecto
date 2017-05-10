import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.classifiers.trees.RandomTree;
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
		      
		 RandomTree tree = new RandomTree();     
		 
		 tree.buildClassifier(data);
		 
		 Evaluation eval = new Evaluation(data);
		 eval.crossValidateModel(tree, data, 10, new Random(1));
		 
		 Instance toClassify = new DenseInstance(data.numAttributes());
		 toClassify.setDataset(data);
		 
		 Scanner reader = new Scanner(System.in);
		 
		 
		 for(int i = 0; i < data.numAttributes() - 1; i++) {
			 if(data.attribute(i).isNominal()) {
				 
				 String value = args[i];
				 toClassify.setValue(i, value);
			 }
			 else {
				 String value = args[i];
				 toClassify.setValue(i, Integer.parseInt(value));
			 }
		 }
		 
		 reader.close();
		 
		 double result = tree.classifyInstance(toClassify);
		 toClassify.setClassValue(result);
		 System.out.println("La prevision es tráfico: " + toClassify.stringValue(toClassify.classIndex()));
	}
}
