Received:  by oss.sgi.com id <S305157AbQCPOr1>;
	Thu, 16 Mar 2000 06:47:27 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:48217 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCPOrN>; Thu, 16 Mar 2000 06:47:13 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA09105; Thu, 16 Mar 2000 06:50:37 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA65407
	for linux-list;
	Thu, 16 Mar 2000 06:30:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA20672
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Mar 2000 06:30:16 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from ig-1-108.sp.dial.psinet.com.br (ig-1-108.sp.dial.psinet.com.br [200.188.86.108]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA04689
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Mar 2000 06:30:12 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407911AbQCPO3L>;
	Thu, 16 Mar 2000 11:29:11 -0300
Date:   Thu, 16 Mar 2000 11:29:10 -0300
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Error: Branch out of range
Message-ID: <20000316112910.A842@uni-koblenz.de>
References: <Pine.GSO.4.10.10003151603070.20855-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.4.10.10003151603070.20855-100000@dandelion.sonytel.be>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Mar 15, 2000 at 04:08:08PM +0100, Geert Uytterhoeven wrote:

> I'm trying to compile lmbench on Linux/MIPS(EL). Gcc (egcs-2.90.27 980315
> (egcs-1.0.2 release)) complains about

No, as from binutils (all versions) coplains.

> ../bin/linux/lat_ctx.s: Assembler messages:
> ../bin/linux/lat_ctx.s:4293: Error: Branch out of range
> ../bin/linux/lat_ctx.s:40459: Error: Branch out of range
> 
> At line 4293 it jumps to line 40460 using `j', which is obviously further then
> 32K instructions apart (and incompatible with -KPIC, which is always[*] used).
> 
> How can I fix this?

 - Fix the assembler.  Enjoy ...  lmbench is faik the only real world
   program which triggers this problem so I've never been very motivated to
   fix this ...
 - Get a newer version of lmbench which does no longer rely on such insane
   large loops.

> [*] Why is MIPS code always compiled PIC?

The calling convention for PIC code is to always have the address of the
callee in $25.  This implies that mixing PIC and non-PIC code is not
possible, therefore everything is PIC.

  Ralf
