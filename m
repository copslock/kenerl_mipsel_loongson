Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 13:21:29 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:48562 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225591AbSLWNV2>; Mon, 23 Dec 2002 13:21:28 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA08098;
	Mon, 23 Dec 2002 14:21:39 +0100 (MET)
Date: Mon, 23 Dec 2002 14:21:39 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Julian Scheel <jscheel@activevb.de>
cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: Problems compiling MIPS64 kernel
In-Reply-To: <200212231313.54593.jscheel@activevb.de>
Message-ID: <Pine.GSO.3.96.1021223141611.7980A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 23 Dec 2002, Julian Scheel wrote:

> after I got the mips-patched 2.4.20 kernel-sources now, I made a new try to 
> compile my mips64-kernel.
> As compiler I am using the SDE-GCC (www.algor.co.uk). make menuconfig works 
> well, but when I do "make vmlinux" I get following errors:
[...]
> /home/jscheel/Programmieren/cmms/mips-kernel/linux/include/linux/mm.h:335: 
> `_MIPS_SZLONG' undeclared (first use in this function)
> make: *** [init/main.o] Error 1
> -----------
> 
> especially the line "#error Use a Linux compiler or give up" surprised me?!
> Can someone help me a bit?

 The configuration of your compiler is broken.  Gcc is supposed to always
define the _MIPS_SZLONG macro appropriately (in its specs file -- run
`sde-gcc -print-file-name=specs' to find the file's location), but yours
fails to.  The remaining errors result from the lack of a _MIPS_SZLONG
definition. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
