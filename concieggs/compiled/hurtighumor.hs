module Main (main) where

import System.Environment (getArgs)
import Control.Monad
import Control.Applicative
import Concieggs.Monad
import Concieggs.Random


tilfældigTing :: Random String
tilfældigTing =
  choice
  [ "concieggs"
  , "skinke"
  , "katte"
  , "Starbucks"
  , "Pizza Hut"
  , "fastpladelageret"
  , "Klodsmajor-spillet"
  , "Barbiedukken"
  , "portrættet af Stig Møller"
  , "hotdogs"
  , "Kapitalisme"
  , "rygeheroin"
  , "Offentlighedsloven"
  , "McDonald's"
  , "Lady Gaga"
  , "charterrejser"
  , "apostroffet i \"Jensen's Bøfhus\"?"
  , "utf-8-katastrofen"
  , "sennepen"
  , "inflationen"
  , "skønhedsidealerne"
  , "første sæson af Mad Men"
  , "Netflix"
  , "Medielicensen"
  , "miljøet"
  , "Anders Fucking Rasmussen"
  , "den allersidste kage"
  , "mindstenævneren"
  ]

tilfældigFørsteperson :: Random String
tilfældigFørsteperson =
  choiceM
  [ pure "destrueres"
  , pure "æder " <++> tilfældigTing
  , pure "sluger " <++> tilfældigTing
  , pure "gnasker " <++> tilfældigTing
  , pure "griner"
  , pure "griner over " <++> tilfældigTing
  , pure "bestemmer det hele"
  , pure "lugter"
  , pure "lugter til " <++> tilfældigTing
  , pure "spilder på gulvet"
  , pure "gør nar ad Dronningen"
  , pure "pletter på lagnet"
  , pure "fiser højlydt"
  , pure "galloperer deruda'"
  , pure "siger nej"
  , pure "har slået  noget"
  , pure "arbejder for Illuminaten"
  , pure "spiller høj musik efter midnat"
  , pure "har tabt sig"
  , pure "snyder i brætspil"
  , pure "kaster PlayStation controllers ad h til"
  , pure "er til grin"
  , pure "er noget pis"
  , pure "er det bedste produkt i verden"
  , pure "er den helt store revolution"
  , pure "smager af sylte"
  ]

tilfældigTyper :: Random String
tilfældigTyper =
  choice
  [ "typerne"
  , "mønttællerne"
  , "bureaukraterne"
  , "bankdirektørerne"
  , "de studerende"
  , "algoritmikerne"
  , "bum-hovederne"
  , "nasserøvene"
  , "miljø-forkæmperne"
  , "feministerne"
  , "blærerøvene"
  , "drukkenboltene"
  , "smedene"
  , "fagforeningsbosserne"
  , "pamperne"
  , "skrankepaverne"
  , "bohemerne"
  , "Safri Duo-medlemmerne"
  , "i Tivolis Pigegarde"
  , "cirkusartisterne"
  , "revytterne"
  , "de fattige"
  , "\"de folkevalgte\""
  , "de adelige"
  , "\"kunstnerne\""
  , "De Radikales vælgere"
  , "tobakssælgerne"
  , "opportunisterne"
  ]

tilfældigtOplæg :: Random String
tilfældigtOplæg =
  choice
  [ "Hvad er oppe med"
  , "Øøøh, hallo"
  , "Og hvad sker der lige for"
  , "Overvej lige"
  , "Hvad sker der for"
  , "Hvad er der lige med"
  , "Er den ik' også helt gal med"
  , "Og HVAD sker der lige for"
  , "Kender I"
  , "Hvor mange her kender"
  , "Er det virkelig kun mig, som har tænkt over"
  , "Helt ærligt,"
  , "Nu er jeg jo ikke racist, men"
  , "Nu er jeg jo ikke feminist, men"
  , "Nu er jeg jo ikke venstreekstremist, men"
  , "Nu er jeg jo ikke jyde, men"
  , "Jeg ved godt jeg ikke er bedre end alle andre, men"
  , "Og helt ærligt,"
  , "Ikke for at være \"se mig, se mig!\", men"
  , "Apropos, "
  ]

tilfældigMådeform :: Random String
tilfældigMådeform =
  choice
  [ "trampe"
  , "bande og svovle"
  , "hoppe og hisse"
  , "maltraktere"
  , "forandre"
  , "vrisse"
  , "brokke sig"
  , "skamme sig"
  , "vrøvle"
  , "\"trille ærten\""
  , "rumle-skide helt vildt!"
  , "stjæle fra kontoret"
  , "lytte til den nye med Scooter"
  , "spille sygt dumme"
  , "spille sygt smarte"
  , "være flabet"
  , "bryde ophavsretten"
  , "skrive læserbreve"
  , "henvende sig til ministeren"
  , "opføre sig fuldstændig tåbeligt"
  , "lade sig overraske"
  , "føre sig frem"
  , "ignorere Janteloven"
  , "kode grimt Erlang"
  ]

tilfældigKommentar :: String -> String -> Random (ConcieggsM String)
tilfældigKommentar person0 person1 =
  choice
  [ (\s -> "Di" ++ s ++ "! ;-)") <$> getOut (run "tøj")
  , getOut (run "tærteKommentar")
  , getOut (run "sayNo")
  , getOut $ do
       dummeBavianer <- getOut (run "dummeBavianer")
       hjuleneDrejer <- getOut (run "hjuleneDrejer")
       echo ("Det er jo de " ++ dummeBavianer ++ " der gør at "
             ++ hjuleneDrejer ++ "!")
  ]

main :: IO ()
main = runConcieggsM $ join $ liftRand $ weightedChoice
       [ (hvadErOppe, 3)
       , (ogSåSagde, 2)
       , (menDetVar, 1)
       ]
  where hvadErOppe :: ConcieggsM ()
        hvadErOppe = do
          spørgsmål <- liftRand tilfældigtOplæg
          ting <- liftRand tilfældigTing
          førsteperson <- liftRand tilfældigFørsteperson
          typer <- liftRand tilfældigTyper
          mådeform <- liftRand tilfældigMådeform
          echo (spørgsmål ++ " " ++ ting
                  ++ "?  Det er jo ikke fordi " ++ ting
                  ++ " " ++ førsteperson ++ ", men alligevel kan alle "
                  ++ typer ++ " ikke lade være med at " ++ mådeform ++ "!")

        ogSåSagde :: ConcieggsM ()
        ogSåSagde = do
          brugere <- lines <$> getOut (run "recentlyActive")
          let findPerson = if null brugere
                           then return "concieggs" -- concieggs er der altid.
                           else liftRand $ choice brugere
          person0 <- findPerson
          person1 <- findPerson
          kommentar <- join $ liftRand $ tilfældigKommentar person0 person1
          echo ("Og SÅ sagde " ++ person0 ++ " til " ++ person1 ++ ": \"" ++ kommentar ++ "\"!!!")

        menDetVar :: ConcieggsM ()
        menDetVar = do
          ting <- liftRand tilfældigTing
          echo ("Men det var slet ikke " ++ ting ++ "!  HAHAHAHA!")
