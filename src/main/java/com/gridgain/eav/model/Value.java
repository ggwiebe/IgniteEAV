package com.gridgain.eav.model;

import java.io.Serializable;

/**
 * Value definition.
 * 
 * This file was generated by Ignite Web Console (08/27/2020, 13:47)
 **/
public class Value implements Serializable {
    /** */
    private static final long serialVersionUID = 0L;

    /** Value for val. */
    private String val;

    /** Empty constructor. **/
    public Value() {
        // No-op.
    }

    /** Full constructor. **/
    public Value(String val) {
        this.val = val;
    }

    /**
     * Gets val
     * 
     * @return Value for val.
     **/
    public String getVal() {
        return val;
    }

    /**
     * Sets val
     * 
     * @param val New value for val.
     **/
    public void setVal(String val) {
        this.val = val;
    }

    /** {@inheritDoc} **/
    @Override public boolean equals(Object o) {
        if (this == o)
            return true;
        
        if (!(o instanceof Value))
            return false;
        
        Value that = (Value)o;

        if (val != null ? !val.equals(that.val) : that.val != null)
            return false;
        
        return true;
    }

    /** {@inheritDoc} **/
    @Override public int hashCode() {
        int res = val != null ? val.hashCode() : 0;

        return res;
    }

    /** {@inheritDoc} **/
    @Override public String toString() {
        return "Value [" + 
            "val=" + val +
        "]";
    }
}