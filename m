Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2007 16:11:55 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:5323 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20021903AbXD1PLo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2007 16:11:44 +0100
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HhoaN-000553-2Z; Sat, 28 Apr 2007 15:11:43 +0000
Message-ID: <4633642E.8060909@garzik.org>
Date:	Sat, 28 Apr 2007 11:11:42 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, akpm@linux-foundation.org
Subject: Re: [PATCH 3/3] MIPS: Drop unnecessary CONFIG_ISA from RBTX49XX
References: <20070425.015625.96686329.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070425.015625.96686329.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Those boards do not need CONFIG_ISA if the ne driver could be
> selectable without it.  Disable it and update a defconfig.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  arch/mips/Kconfig                     |    2 --
>  arch/mips/configs/rbhma4500_defconfig |   31 -------------------------------
>  2 files changed, 0 insertions(+), 33 deletions(-)

Ditto akpm's comment:  this patch is certainly fine.  I will drop it for 
now, and await the update and resend of this patchset.
