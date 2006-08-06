Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Aug 2006 09:37:52 +0100 (BST)
Received: from mail-out.m-online.net ([212.18.0.10]:38890 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S20037584AbWHFIhw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 6 Aug 2006 09:37:52 +0100
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 286A79810D;
	Sun,  6 Aug 2006 10:37:44 +0200 (CEST)
X-Auth-Info: dOJ8DNbzTRAVi3WyA6GoX3MWqItYLNPPITbHp18/h90=
X-Auth-Info: dOJ8DNbzTRAVi3WyA6GoX3MWqItYLNPPITbHp18/h90=
Received: from mail.denx.de (p5496514A.dip.t-dialin.net [84.150.81.74])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 1425792436;
	Sun,  6 Aug 2006 10:37:44 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id A5B9A6D008A;
	Sun,  6 Aug 2006 10:37:43 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 8348D352625;
	Sun,  6 Aug 2006 10:37:43 +0200 (MEST)
To:	Kiah Tang <wct_tang@yahoo.co.uk>
cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: EXT2-fs error 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Sun, 06 Aug 2006 04:03:29 -0000."
             <20060806040329.51416.qmail@web27003.mail.ukl.yahoo.com> 
Date:	Sun, 06 Aug 2006 10:37:43 +0200
Message-Id: <20060806083743.8348D352625@atlas.denx.de>
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20060806040329.51416.qmail@web27003.mail.ukl.yahoo.com> you wrote:

> I built Linux kernel (V2.4) as follows: 
> - Created EXT2 ramdisk.gz as documented in Documentation/ramdisk.txt 
> - The ramdisk contains the content of buildroot/build_mipsel/root/, which contains bin, etc, lib, linuxrc, sbin (sh.. etc), usr. I also created under /dev console null, tty*.... 
> - Copied ramdisk.gz to /linux/arc/mips/ramdisk/ 
...
> Tracing down the codes, I noticed I got EXT2-fs error. 

Your ramdisk is probably much bigger than the kernel's default of 4 MB.

Please see the FAQ at
http://www.denx.de/wiki/view/DULG/RamdiskGreaterThan4MBCausesProblems

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
My play was a complete success.  The audience was a failure.
