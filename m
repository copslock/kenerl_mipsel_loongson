Received:  by oss.sgi.com id <S553746AbRAHXlA>;
	Mon, 8 Jan 2001 15:41:00 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:50440 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553715AbRAHXka>;
	Mon, 8 Jan 2001 15:40:30 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id AA3757FE; Tue,  9 Jan 2001 00:40:27 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id AD476F44C; Tue,  9 Jan 2001 00:41:01 +0100 (CET)
Date:   Tue, 9 Jan 2001 00:41:01 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: MIPS32 patches breaking DecStation
Message-ID: <20010109004101.B27674@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,
i found this snippet from arch/mips/kernel/head.S breaking DecStations:

@@ -68,9 +76,9 @@
        mtc0    k0, CP0_ENTRYLO0                # load it
        srl     k1, k1, 6                       # convert to entrylo1
        mtc0    k1, CP0_ENTRYLO1                # load it
-       b       1f
-        tlbwr                                  # write random tlb entry
-1:     
+       nop                                     # Need 2 cycles between mtc0
+       nop                                     #  and tlbwr (CP0 hazard).
+       tlbwr                                   # write random tlb entry
        nop
        eret                                    # return from trap
        END(except_vec0_r4000)


>From the Documentation and how i understand it this is perfectly
valid as the mtc0 instruction causes a cp0 hazard within the next 2 instruction
thought the delay of 2 cycles would be ok.

This is probably related to the Decstations having REALLY old R4000 silicion
revisions - Probably one should look through the erratas for these

flo@repeat:~$ cat /proc/cpuinfo 
cpu			: MIPS
cpu model		: R4000SC V3.0
system type		: Digital DECstation 5000/1xx

OK - I just had a look at the errata - This IS a workaround to a 
Mips R4000SC 2.0, 3.0 errata - I restored the original code back.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
