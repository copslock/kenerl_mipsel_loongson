Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2007 16:11:31 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:4299 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20021900AbXD1PLa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2007 16:11:30 +0100
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HhoX5-00054J-PG; Sat, 28 Apr 2007 15:08:20 +0000
Message-ID: <46336363.4030609@garzik.org>
Date:	Sat, 28 Apr 2007 11:08:19 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH 2/3] ne: MIPS: Use platform_driver for ne on RBTX49XX
References: <20070425.015549.108742168.anemo@mba.ocn.ne.jp> <20070425.020355.70477311.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070425.020355.70477311.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 25 Apr 2007 01:55:49 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>> This patch lets RBTX49XX boards use generic platform_driver interface
>> for the ne driver.
> 
> This patch obsolates a patch I send on 1 Mar.
> 
>> Subject: [PATCH] Fix broken RBTX4927 support in ne.c
>> Message-Id: <20070301.012223.129448787.anemo@mba.ocn.ne.jp>
>> Date: 	Thu, 01 Mar 2007 01:22:23 +0900 (JST)
> 
> I revoke this old patch if new patch was acceptable.

I do not see the old patch in my queue (my apologies!), so all is well.

	Jeff
