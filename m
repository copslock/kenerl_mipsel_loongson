Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2002 12:13:18 +0200 (CEST)
Received: from dvmwest.gt.owl.de ([62.52.24.140]:21767 "EHLO dvmwest.gt.owl.de")
	by linux-mips.org with ESMTP id <S1122959AbSHWKNS>;
	Fri, 23 Aug 2002 12:13:18 +0200
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 2877F13363; Fri, 23 Aug 2002 12:13:11 +0200 (CEST)
Date: Fri, 23 Aug 2002 12:13:10 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20020823101310.GN12007@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <200208230950.g7N9o0fq016617@oss.sgi.com>
Mime-Version: 1.0
Content-type: text/plain
Content-Disposition: inline
In-Reply-To: <200208230950.g7N9o0fq016617@oss.sgi.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
Content-Transfer-Encoding: 8bit
X-archive-position: 2
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips

On Fri, 2002-08-23 02:50:00 -0700, Maciej W. Rozycki <macro@oss.sgi.com>
wrote in message <200208230950.g7N9o0fq016617@oss.sgi.com>:
> CVSROOT:	/oss/CVS/cvs
> Module name:	linux
> Changes by:	macro@oss.sgi.com	02/08/23 02:50:00
> 
> Modified files:
> 	drivers/scsi   : Tag: linux_2_4 dec_esp.c 
> 	include/asm-mips: Tag: linux_2_4 scatterlist.h 
> 	include/asm-mips64: Tag: linux_2_4 scatterlist.h 
> 
> Log message:
> 	More mmu_sglist and dec_esp.c fixes, sigh...

Cool. Fixed now. I had send a similar patch around about a week or two
ago on whitch Karsten and I had worked on. Nobody responded, nobody
checked it in... Not to talk about the R4600 issues...

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

-- Attached file included as plaintext by Ecartis --

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Zgq2Hb1edYOZ4bsRAhoEAKCRs8dxZSlradXTi2RPodBabHr9ewCgi/7Q
7N6mgModfQ78u+ljaRk52Bs=
=JA+S
-----END PGP SIGNATURE-----
