select
    id,
    genero,
    fumador,
    bebedor,
    proc_quirurgico_traumatismo,
    inmovilidad_m_inferiores,
    viaje_prolongado,
    tep_tvp_previo,
    malignidad,
    disnea,
    dolor_toracico,
    tos,
    hemoptisis,
    sintomas_disautonomicos,
    edema_m_inferiores,
    crepitaciones,
    sibilancias,
    soplos,
    derrame,
    fiebre,
    
    {% set edad_int = [(0,20,0),(20,41,1),(41,61,2),(61,81,3)] %}
    {{ discretize_values("edad", edad_int, upper_value = 4) }} as edad,

    {% set frec_res_int = [(15,20,1),(20,25,2),(25,30,3),(30,35,4),(35,40,5),(40,45,6),(45,50,7),(50,55,8),(55,60,9)] %}
    {{ discretize_values("frecuencia_respiratoria", frec_res_int, 15, 10, 11) }} as frecuencia_respiratoria,

    {% set wbc_int = [(2000,4000,1),(4000,10000,2),(10000,15000,3),(15000,20000,4),(20000,30000,5),(30000,35000,6)] %}
    {{ discretize_values("wbc", wbc_int, 2000, 7, 8) }} as wbc,

    {% set saturacion_int = [(50,55,1),(55,60,2),(60,65,3),(65,70,4),(70,75,5),(75,80,6),(80,85,7),(85,90,8),(90,95,9),(95,100,10)] %}
    {{ discretize_values("saturacion_sangre", saturacion_int, 50, 11, 12) }} as saturacion_sangre,

    {% set frec_card_int = [(50,70,1),(70,90,2),(90,110,3),(110,130,4),(130,150,5),(150,170,6),(170,190,7),(190,210,8)] %}
    {{ discretize_values("frecuencia_cardiaca", frec_card_int, 50, 9, 10) }} as frecuencia_cardiaca,

    {% set sist_int = [(50,70,1),(70,90,2),(90,110,3),(110,130,4),(130,150,5),(150,170,6),(170,190,7),(190,210,8)] %}
    {{ discretize_values("presion_sistolica", sist_int, 50, 9, 10) }} as presion_sistolica,

    {% set diast_int = [(40,50,1),(50,60,2),(60,70,3),(70,80,4),(80,90,5),(90,100,6),(100,110,7),(110,120,8)] %}
    {{ discretize_values("presion_diastolica", diast_int, 40, 9, 10) }} as presion_diastolica,

    {% set hb_int = [(6,8,1),(8,10,2),(10,12,3),(12,14,4),(14,16,5),(16,18,6),(18,20,7),(20,22,8)] %}
    {{ discretize_values("hb", hb_int, 6, 9, 10) }} as hb,

    {% set plt_int = [(10000,50000,1),(50000,100000,2),(100000,150000,3),(150000,400000,4),(400000,500000,5),(500000,600000,6),(600000,700000,7)] %}
    {{ discretize_values("plt", plt_int, 10000, 8, 9) }} as plt,

    otra_enfermedad,
    enfermedad_hematologica,
    enfermedad_cardiaca,
    enfermedad_endocrina,
    enfermedad_gastrointestinal,
    enfermedad_hepatopatia_cronica,
    enfermedad_neurologica,
    enfermedad_pulmonar,
    enfermedad_renal,
    enfermedad_trombofilia,
    enfermedad_urologica,
    enfermedad_vascular,
    enfermedad_vih,
    enfermedad_diabetes_mellitus,
    enfermedad_coronaria,
    enfermedad_hipertension_arterial,
    tep

from {{ ref("gold_ml_without_na") }}