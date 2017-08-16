
public class FactoryMethodPattern {
	public static void test() {
		LoggerFactory factory;
		Logger logger;
		factory = new FileLoggerFactory();
		logger = factory.createLogger();
		logger.writeLog();
	}
}

// abstract product
interface Logger {
	public void writeLog();
}

// concrete product
class DatabaseLogger implements Logger {
	public void writeLog() {
		System.out.println("数据库日志记录");
	}
}

class FileLogger implements Logger {
	public void writeLog() {
		System.out.println("文件日志记录");
	}
}

// abstract factory
interface LoggerFactory {
	public Logger createLogger();
}
// concrete factory
class DtabaseLoggerFactory implements LoggerFactory {
	public Logger createLogger() {
		Logger logger = new DatabaseLogger();
		return logger;
	}
}
class FileLoggerFactory implements LoggerFactory {
	public Logger createLogger() {
		Logger logger = new FileLogger();
		return logger;
	}
}
