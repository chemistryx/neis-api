module NeisHelper
    def get_identifier(schoolCode)
        # Use hashrockets to get values with string
        regionIdentifier = {
            'B' => "sen",
            'C' => "pen",
            'D' => "dge",
            'E' => "ice",
            'F' => "gen",
            'G' => "dje",
            'H' => "use",
            'I' => "sje",
            'J' => "goe",
            'K' => "kwe",
            'M' => "cbe",
            'N' => "cne",
            'P' => "jbe",
            'Q' => "jne",
            'R' => "gbe",
            'S' => "gne",
            'T' => "jje",
        }

        return regionIdentifier[schoolCode[0, 1]]
    end
end
