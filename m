Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 10:33:25 +0000 (GMT)
Received: from smtp-102.nerim.net ([IPv6:::ffff:62.4.16.102]:6163 "EHLO
	kraid.nerim.net") by linux-mips.org with ESMTP id <S8225196AbTBJKdY>;
	Mon, 10 Feb 2003 10:33:24 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by kraid.nerim.net (Postfix) with ESMTP
	id 880B640EF3; Mon, 10 Feb 2003 11:33:22 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18iBFr-0000J0-00; Mon, 10 Feb 2003 11:33:39 +0100
Date: Mon, 10 Feb 2003 11:33:39 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>,
	Guido Guenther <agx@sigxcpu.org>
Subject: Re: porting arcboot
In-Reply-To: <20030210034549.GA8408@pureza.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0302101120390.1117-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

> I'm planning to try porting arcboot to ip27 (mips64).

I'm actually doing the same for ip32 (SGI O2). I've added support for
64-bit ELF while sticking to 32-bit arcboot to avoid the issues you
mention with 64-bit userland. The code is still a bit ugly and I've
hardcoded a different load address for the O2 (this should be a
'configure' option at least), but you might be interested to have a look.
The same trick used for the kernel could probably be used to relocate the
32-bit arcboot to 64-bit address space using objcopy, for the ip27 PROM
which only supports 64-bit ELF (according to Ralf).

An early patch is there:
http://www.linux-mips.org/~glaurung/arcboot-0.3.5-o2.diff

The idea is to load segments with the KSEG0 version of the physical
address, which can be done with 32-bit code (but limits kernel load
address to <512Mb). We then jump to the 64-bit entry point with a small
bit of mips4 assembly. 

Comments welcome.

Vivien.
