Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Oct 2004 23:05:09 +0100 (BST)
Received: from mailout02.sul.t-online.com ([IPv6:::ffff:194.25.134.17]:29355
	"EHLO mailout02.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225313AbUJPWFD>; Sat, 16 Oct 2004 23:05:03 +0100
Received: from fwd05.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1CIwfJ-00028r-00; Sun, 17 Oct 2004 00:04:41 +0200
Received: from denx.de (ZG94bMZYrea3YSWBYOMJWpZHPgeR4DB51yC2TicG0PsNEcVpqKz-0e@[84.128.39.178]) by fmrl05.sul.t-online.com
	with esmtp id 1CIwf5-1MEBnc0; Sun, 17 Oct 2004 00:04:27 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id CB35742A82; Sun, 17 Oct 2004 00:04:22 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id A046DC1430; Sun, 17 Oct 2004 00:04:09 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 9D49013D6DB; Sun, 17 Oct 2004 00:04:09 +0200 (MEST)
To: "???" <Mickey@turtle.ee.ncku.edu.tw>
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Is there any means to use Cramfs and JFFS2 images as root disks? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Sun, 17 Oct 2004 01:41:33 +0800."
             <004b01c4b3a7$6193e810$7101a8c0@dinosaur> 
Date: Sun, 17 Oct 2004 00:04:04 +0200
Message-Id: <20041016220409.A046DC1430@atlas.denx.de>
X-ID: ZG94bMZYrea3YSWBYOMJWpZHPgeR4DB51yC2TicG0PsNEcVpqKz-0e@t-dialin.net
X-TOI-MSGID: 09f30a99-a816-41ca-8e82-ac668db277f3
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <004b01c4b3a7$6193e810$7101a8c0@dinosaur> you wrote:
> 
> My question still exists: YAMON doesn't know where /dev/mtdblock3 is...
> How do I put JFFS2 image by YAMON onto the right location in Flash... :-)

You set up the MTD partitions, so you should know exactly where  this
partition  starts  and ends in your physical address space. Just pass
these addresses to YAMON.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The nice thing about  standards  is that there are  so many to choose
from.                                           - Andrew S. Tanenbaum
