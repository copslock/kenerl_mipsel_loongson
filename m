Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2005 00:37:22 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:48133 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225397AbVAYAhH>; Tue, 25 Jan 2005 00:37:07 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6FB54F5971; Tue, 25 Jan 2005 01:36:59 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06650-02; Tue, 25 Jan 2005 01:36:59 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 3B758E1CBE; Tue, 25 Jan 2005 01:36:59 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j0P0b1qJ014431;
	Tue, 25 Jan 2005 01:37:05 +0100
Date:	Tue, 25 Jan 2005 00:37:01 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Brad Larson <Brad_Larson@pmc-sierra.com>
Cc:	Manish Lachwani <mlachwani@mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: RE: [PATCH] TX4927 processor can support different speeds
In-Reply-To: <04781D450CFF604A9628C8107A62FCCF013DDBC4@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
Message-ID: <Pine.LNX.4.61L.0501250032160.7948@blysk.ds.pg.gda.pl>
References: <04781D450CFF604A9628C8107A62FCCF013DDBC4@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/661/Tue Jan 11 02:44:13 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 24 Jan 2005, Brad Larson wrote:

> I've seen more boards with slightly, sometimes dramatically, modified 
> cpu clock source for performance and production reliability reasons than 
> not having an external RTC.  External RTC present and one kernel can 
> accurately enough report the cpu frequency for Toshiba "stock" values 
> and others as well.

 And you don't need a full-blown RTC even -- any reasonably accessible 
reference clock with a known frequency will do.

  Maciej
