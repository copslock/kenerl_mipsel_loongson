Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Dec 2004 22:11:47 +0000 (GMT)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:22525 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225273AbUL0WLl>; Mon, 27 Dec 2004 22:11:41 +0000
Received: (qmail 9089 invoked by uid 101); 27 Dec 2004 22:11:22 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by mother.pmc-sierra.com with SMTP; 27 Dec 2004 22:11:22 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id iBRMBGJv029866;
	Mon, 27 Dec 2004 14:11:21 -0800
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <YS6FFDQ9>; Mon, 27 Dec 2004 14:11:15 -0800
Message-ID: <04781D450CFF604A9628C8107A62FCCF013DDAE4@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
From: Brad Larson <Brad_Larson@pmc-sierra.com>
To: "'Thomas Petazzoni'" <thomas.petazzoni@enix.org>,
	linux-mips@linux-mips.org
Subject: RE: Some cache questions
Date: Mon, 27 Dec 2004 14:11:15 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Brad_Larson@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Brad_Larson@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

You haven't mentioned which board.  If its Yosemite then you may have one of the few not upgraded to 1.2 silicon.  If so it won't work with the changes committed by Ralf which requires the shared state for SMP boot.  For further discussion contact the apps@pmc-sierra.com

--Brad

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Thomas Petazzoni
Sent: Monday, December 27, 2004 8:35 AM
To: linux-mips@linux-mips.org
Subject: Some cache questions


Hello,

I'm using an RM9000 dual-core processor, buggy revisions (the one that 
doesn't support the "Shared" cache state if I understood correctly).

When going through the CVS logs, I saw that Ralf quite recently changed 
the cache mode from 4 to 5 in pgtable-bits.h. Is that change involved in 
the use of the "Shared" cache state with newer RM9000 revisions that 
don't have the bug ?

Currently, the KSEG0 cache coherency mode (2 lower bits of the CONFIG 
register) is set to 3 during PMON (start.S file). When I write something 
to the memory through KSEG0 with the first core, it doesn't appear to be 
read by the second core. This indicates, in my opinion, that the cache 
line of the first core hasn't been written to memory so that the second 
core could use it. Am I right ?

If I want to correctly use both cores using KSEG0, should I set the mode 
in the CONFIG register to 4 (so that I can work with buggy processors) ?

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: thomas.petazzoni@jabber.dk
http://kos.enix.org, http://sos.enix.org
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7
