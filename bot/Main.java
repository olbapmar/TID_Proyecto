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


		 double result = tree.classifyInstance(toClassify);
		 toClassify.setClassValue(result);
		 if (toClassify.stringValue(toClassify.classIndex()) == "muy_alto"){
			 System.out.println("muy alto");
		 }
		 else{
		 	System.out.println(toClassify.stringValue(toClassify.classIndex()));
	 	}
	}
}
