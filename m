Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 21:28:22 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:64306
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225484AbSLSV2V>; Thu, 19 Dec 2002 21:28:21 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18P8DJ-000OX7-00; Thu, 19 Dec 2002 22:28:17 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18P8DJ-0006dN-00; Thu, 19 Dec 2002 22:28:17 +0100
Date: Thu, 19 Dec 2002 22:28:17 +0100
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: for poor sools with old I2 & 64 bits kernel
Message-ID: <20021219212817.GL449@rembrandt.csv.ica.uni-stuttgart.de>
References: <m2el8dixmr.fsf@demo.mitica> <20021219210103.GJ449@rembrandt.csv.ica.uni-stuttgart.de> <m2wum5hfy2.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2wum5hfy2.fsf@demo.mitica>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Juan Quintela wrote:
> >>>>> "thiemo" == Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> writes:
> 
> thiemo> Juan Quintela wrote:
> >> 
> >> Hi
> >> this small patch made possible to compile a 64bit kernel for
> >> people that have old proms that only accept ecoff.  As usual
> >> stolen from the 32 bits version.
> >> 
> >> The easiest way is creating the file in arch/mips/boot,
> >> otherwise we need to copy elf2ecoff.c to mips64.
> 
> thiemo> Sorry, but I plainly doubt you have tested this.
> 
> thiemo> I tried such a method today, and elf2ecoff failed to work on ELF64 files.
> thiemo> Maybe a recent enough objcopy is the better choice for this purpose.
> 
> I tested it and it works :)

How is this possible, given that elf2ecoff uses Elf32_* variables to
process the ELF file? elf2ecoff might be bad enough at error checking
to produce some binary garbage.

> Notice that I am using egcs for MIPS64 as I am not able to compile the
> kernel with gcc-3.2 :(

I don't think this is compiler dependent. :-)


Thiemo
