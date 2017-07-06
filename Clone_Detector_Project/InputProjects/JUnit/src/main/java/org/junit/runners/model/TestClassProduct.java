package org.junit.runners.model;


import java.util.Map;

import org.junit.rules.TestRule;

import java.lang.annotation.Annotation;
import java.util.List;
import java.util.Collections;
import java.util.ArrayList;

public class TestClassProduct<T> {
	private final Map<Class<? extends Annotation>, List<FrameworkMethod>> methodsForAnnotations;

	public TestClassProduct(Map<Class<? extends Annotation>, List<FrameworkMethod>> methodsForAnnotations) {
		this.methodsForAnnotations = makeDeeplyUnmodifiable(methodsForAnnotations);
	}

	private Map<Class<? extends Annotation>, List<FrameworkMethod>> makeDeeplyUnmodifiable(
            Map<Class<? extends Annotation>, List<FrameworkMethod>> methodsForAnnotations2) {
        // TODO Auto-generated method stub
        return null;
    }

    /**
	* Returns, efficiently, all the non-overridden methods in this class and its superclasses that are annotated with  {@code  annotationClass} .
	*/
	public List<Object> getAnnotatedMethods(Class<? extends Annotation> annotationClass) {
		return Collections.unmodifiableList(getAnnotatedMethodValues(methodsForAnnotations, annotationClass, false));
	}

	/**
	* Returns, efficiently, all the non-overridden methods in this class and its superclasses that are annotated}.
	* @since  4.12
	*/
	public List<FrameworkMethod> getAnnotatedMethods() {
		List<FrameworkMethod> methods = collectValues(methodsForAnnotations);
		Collections.sort(methods, TestClass.METHOD_COMPARATOR);
		return methods;
	}

	private List<FrameworkMethod> collectValues(
            Map<Class<? extends Annotation>, List<FrameworkMethod>> methodsForAnnotations2) {
        // TODO Auto-generated method stub
        return null;
    }

    public <T> List<T> getAnnotatedMethodValues(Object test, Class<? extends Annotation> annotationClass,
			boolean b) {
		/*List<T> results = new ArrayList<T>();
		for (Object each : getAnnotatedMethods(annotationClass)) {
			try {
				if (b.isAssignableFrom(((FrameworkMethod) each).getReturnType())) {
					Object fieldValue = ((Object) each).invokeExplosively(test);
					results.add((T) b.cast(fieldValue));
				}
			} catch (Throwable e) {
				throw new RuntimeException("Exception in " + ((Class<? extends Annotation>) each).getName(), e);
			}
		}*/
		//return results;
        return null;
	}

    public List<T> getAnnotatedMethodValues(Object test,
            Class<? extends Annotation> annotationClass, Class<T> valueClass) {
        // TODO Auto-generated method stub
        return null;
    }
}