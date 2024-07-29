package models;


import models.enums.Qualification;

public class Physician {
    private final String identifier;
    private final Qualification qualification;

    public Physician(String identifier, Qualification qualification) {
        this.identifier = identifier;
        this.qualification = qualification;
    }

    public String getIdentifier() {
        return identifier;
    }

    public Qualification getQualification() {
        return qualification;
    }
}
