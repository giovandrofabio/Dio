package com.github.giovandro.citesAPI.countries.repositories;

import com.github.giovandro.citesAPI.countries.Country;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CountryRepository extends JpaRepository<Country, Long> {

}
