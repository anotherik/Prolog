sentenca(sentenca(FN,FV))--> frase_nom(FN), frase_verb(FV).
sentenca(sentenca(FNP,FVP)) --> frase_nom_p(FNP), frase_verb_p(FVP).

frase_nom(frase_nom(AF,SF)) --> art_fem(AF), subs_fem(SF).
frase_nom(frase_nom(AM,SM)) --> art_masc(AM), subs_masc(SM).
frase_nom(frase_nom(SF)) --> subs_fem(SF).
frase_nom(frase_nom(SM)) --> subs_masc(SM).

frase_nom_p(frase_nom_p(APF,SPF)) --> art_plur_fem(APF), subs_plur_fem(SPF).
frase_nom_p(frase_nom_p(APM,SPM)) --> art_plur_masc(APM), subs_plur_masc(SPM).
frase_nom_p(frase_nom_p(SPF)) --> subs_plur_fem(SPF).
frase_nom_p(frase_nom_p(SPM)) --> subs_plur_masc(SPM).

%verbo Singular
frase_verb(frase_verbal(V)) --> verb(V).

%Verbo_Masculino
frase_verb(frase_verb_masc(V,P,SM)) --> verb(V), prepo(P), subs_masc(SM).
frase_verb(frase_verb_masc(V,AM,SM)) --> verb(V), art_masc(AM), subs_masc(SM).
frase_verb(frase_verb_masc(V,AMP,SMP)) --> verb(V), art_plur_masc(AMP), subs_masc_plur(SMP).
frase_verb(frase_verb_masc(V,P,AM,SM)) --> verb(V), prepo(P),art_masc(AM), subs_masc(SM).
frase_verb(frase_verb_masc(V,P,AMP,SMP)) --> verb(V), prepo(P),art_plur_masc(AMP), subs_plur_masc(SMP).

%Verbo_Feminino
frase_verb(frase_verb_fem(V,P,SF)) --> verb(V), prepo(P), subs_fem(SF).
frase_verb(frase_verb_fem(V,AF,SF)) --> verb(V), art_fem(AF), subs_fem(SF).
frase_verb(frase_verb_fem(V,AFP,SFP)) --> verb(V), art_plur_fem(AFP), subs_fem_plur(SFP).
frase_verb(frase_verb_fem(V,P,AF,SF)) --> verb(V), prepo(P),art_fem(AF), subs_fem(SF).
frase_verb(frase_verb_fem(V,P,AFP,SFP)) --> verb(V), prepo(P),art_plur_fem(AFP), subs_plur_fem(SFP).

%Verbo_Plural_Simples
frase_verb_plur(frase_verb_plur(V)) --> verb(V).

%Verbo_Plural_Masculino
frase_verb_plur(frase_verb_plur_masc(VP,P,SM)) --> verb(VP), prepo(P), subs_masc(SM).
frase_verb_plur(frase_verb_plur_masc(VP,AM,SM)) --> verb(VP), art_masc(AM), subs_masc(SM).
frase_verb_plur(frase_verb_plur_masc(VP,AMP,SMP)) --> verb(VP), art_plur_masc(AMP), subs_masc_plur(SMP).
frase_verb_plur(frase_verb_plur_masc(VP,P,AM,SM)) --> verb(VP), prepo(P),art_masc(AM), subs_masc(SM).
frase_verb_plur(frase_verb_plur_masc(VP,P,AMP,SMP)) --> verb(VP), prepo(P),art_plur_masc(AMP), subs_plur_masc(SMP).

%Verbo_Plural_Feminino
frase_verb_plur(frase_verb_plur_fem(VP,P,SF)) --> verb(VP), prepo(P), subs_fem(SF).
frase_verb_plur(frase_verb_plur_fem(VP,AF,SF)) --> verb(VP), art_fem(AF), subs_fem(SF).
frase_verb_plur(frase_verb_plur_fem(VP,AFP,SFP)) --> verb(VP), art_plur_fem(AFP), subs_fem_plur(SFP).
frase_verb_plur(frase_verb_plur_fem(VP,P,AF,SF)) --> verb(VP), prepo(P),art_fem(AF), subs_fem(SF).

%Artigos_Femininos
art_fem(artigo('A')) --> ['A'].
art_fem(artigo(a)) --> [a].
art_plur_fem(artigo('As'))--> ['As'].
art_plur_fem(artigo(as)) --> [as].

%Artigos_Masculinos
art_masc(artigo('O')) --> ['O'].
art_masc(artigo(o)) --> [o].
art_plur_masc(artigo('Os')) --> ['Os'].
art_plur_masc(artigo(os)) --> [os].

%Substantivos_Masculinos
subs_masc(substantivo(sino)) --> [sino].
subs_masc(substantivo(tempo)) --> [tempo].
subs_masc(substantivo(cacador)) --> [cacador].
subs_masc(substantivo(rio)) --> [rio].
subs_masc(substantivo(vento)) --> [vento].
subs_masc(substantivo(martelo)) --> [martelo].
subs_masc(substantivo(rosto)) --> [rosto].
subs_masc(substantivo(mar)) --> [mar].
subs_masc(substantivo(cachorro)) --> [cachorro].
subs_masc(substantivo(tambor)) --> [tambor].
subs_plur_masc(substantivo(tambores))-->[tambores].
subs_plur_masc(substantivo(lobos))-->[lobos].

%Substantivos_Femininos
subs_fem(substantivo(menina)) --> [menina].
subs_fem(substantivo(floresta)) --> [floresta].
subs_fem(substantivo(mae)) --> [mae].
subs_fem(substantivo(vida)) --> [vida].
subs_fem(substantivo(cidade)) --> [cidade].
subs_fem(substantivo(noticia)) --> [noticia].
subs_fem(substantivo(porta)) --> [porta].
subs_plur_fem(substantivo(lagrimas)) --> [lagrimas].

%Verbo
verb(verbo(corre))--> [corre].
verb(verbo(correu))--> [correu].
verb(verbo(bateu))--> [bateu].
verb_plur(verbo(corriam))--> [corriam].
verb_plur(verbo(bateram))--> [bateram].

%Preposicoes
prepo(preposicao(para))--> [para].
prepo(preposicao(com))--> [com].
prepo(preposicao(pelo))--> [pelo].
prepo(preposicao(pela))--> [pela].
prepo(preposicao(no))--> [no].
prepo(preposicao(na))--> [na].