Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 22:22:38 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:9267
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225492AbSLSWWh>; Thu, 19 Dec 2002 22:22:37 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18P93r-000PA2-00; Thu, 19 Dec 2002 23:22:35 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18P93r-0002Zd-00; Thu, 19 Dec 2002 23:22:35 +0100
Date: Thu, 19 Dec 2002 23:22:35 +0100
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: for poor sools with old I2 & 64 bits kernel
Message-ID: <20021219222235.GO449@rembrandt.csv.ica.uni-stuttgart.de>
References: <m2el8dixmr.fsf@demo.mitica> <20021219210103.GJ449@rembrandt.csv.ica.uni-stuttgart.de> <m2wum5hfy2.fsf@demo.mitica> <20021219212817.GL449@rembrandt.csv.ica.uni-stuttgart.de> <m2r8cdhel4.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2r8cdhel4.fsf@demo.mitica>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Juan Quintela wrote:
[snip]
> >> Notice that I am using egcs for MIPS64 as I am not able to compile the
> >> kernel with gcc-3.2 :(
> 
> thiemo> I don't think this is compiler dependent. :-)
> 
> from  arch/mips64/Makefile:
> 
> #
> # Some machines like the Indy need 32-bit ELF binaries for booting purposes.
> # Other need ECOFF, so we build a 32-bit ELF binary for them which we then
> # convert to ECOFF using elf2ecoff.

Argh, this hack again! Sorry for the confusion, I'm just used to think
64bit == ELF64.


Thiemo
