Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 21:01:07 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:59186
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225484AbSLSVBG>; Thu, 19 Dec 2002 21:01:06 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18P7mx-000P3A-00; Thu, 19 Dec 2002 22:01:03 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18P7mx-0006aP-00; Thu, 19 Dec 2002 22:01:03 +0100
Date: Thu, 19 Dec 2002 22:01:03 +0100
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: for poor sools with old I2 & 64 bits kernel
Message-ID: <20021219210103.GJ449@rembrandt.csv.ica.uni-stuttgart.de>
References: <m2el8dixmr.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2el8dixmr.fsf@demo.mitica>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Juan Quintela wrote:
> 
> Hi
>         this small patch made possible to compile a 64bit kernel for
>         people that have old proms that only accept ecoff.  As usual
>         stolen from the 32 bits version.
>
>         The easiest way is creating the file in arch/mips/boot,
>         otherwise we need to copy elf2ecoff.c to mips64.

Sorry, but I plainly doubt you have tested this.

I tried such a method today, and elf2ecoff failed to work on ELF64 files.
Maybe a recent enough objcopy is the better choice for this purpose.


Thiemo
