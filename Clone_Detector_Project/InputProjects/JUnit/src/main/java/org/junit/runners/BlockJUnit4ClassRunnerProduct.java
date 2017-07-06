package org.junit.runners;


import org.junit.runners.model.Statement;
import org.junit.runners.model.FrameworkMethod;
import org.junit.Test;
import org.junit.internal.runners.statements.ExpectException;
import org.junit.internal.runners.statements.FailOnTimeout;
import java.util.concurrent.TimeUnit;

public class BlockJUnit4ClassRunnerProduct {
	/**
	* Returns a  {@link Statement} : if  {@code  method} 's  {@code  @Test}  annotation has the  {@code  expecting}  attribute, return normally only if  {@code  next} throws an exception of the correct type, and throw an exception otherwise.
	*/
	public Statement possiblyExpectingExceptions(FrameworkMethod method, Object test, Statement next) {
		Test annotation = method.getAnnotation(Test.class);
		return expectsException(annotation) ? new ExpectException(next, getExpectedException(annotation)) : next;
	}

	public boolean expectsException(Test annotation) {
		return getExpectedException(annotation) != null;
	}

	public Class<? extends Throwable> getExpectedException(Test annotation) {
		if (annotation == null) {
			return null;
		} else {
			return annotation.expected();
		}
	}

	/**
	* Returns a  {@link Statement} : if  {@code  method} 's  {@code  @Test}  annotation has the  {@code  timeout}  attribute, throw an exception if  {@code  next} takes more than the specified number of milliseconds.
	* @deprecated
	*/
	@Deprecated
	public Statement withPotentialTimeout(FrameworkMethod method, Object test, Statement next) {
		long timeout = getTimeout(method.getAnnotation(Test.class));
		if (timeout <= 0) {
			return next;
		}
		return FailOnTimeout.builder().withTimeout(timeout, TimeUnit.MILLISECONDS).build(next);
	}

	public long getTimeout(Test annotation) {
		if (annotation == null) {
			return 0;
		}
		return annotation.timeout();
	}
}