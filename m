Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 03:08:28 +0100 (BST)
Received: from smtp.gentoo.org ([140.211.166.183]:52942 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S20041962AbYHFCIV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Aug 2008 03:08:21 +0100
Received: by smtp.gentoo.org (Postfix, from userid 2204)
	id CBD9966184; Wed,  6 Aug 2008 02:08:18 +0000 (UTC)
Date:	Wed, 6 Aug 2008 02:08:18 +0000
From:	Ricardo Mendoza <ricmm@gentoo.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] vr41xx: fix problem with vr41xx_cpu_wait
Message-ID: <20080806020818.GA10184@woodpecker.gentoo.org>
References: <20080805104314.GB4628@woodpecker.gentoo.org> <200808060147.m761l4Is022564@po-mbox303.hop.2iij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200808060147.m761l4Is022564@po-mbox303.hop.2iij.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <ricmm@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@gentoo.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 06, 2008 at 10:49:01AM +0900, Yoichi Yuasa wrote:
 
> In VR4100 series User's Manual, it's being written
> "IE bit of the Status register in the CP0 is also set to 1".
> 
> Do you have any problem on your board?

Hello Yoichi,

Just now I got my hands on the manual, I can see that the standby
instruction sets IE bit to 1 but only on Vr4131 and Vr4181A cores, all
others (such as my Vr4121) need to have interrupts enabled before going
into standby.

The patch will make it work on all Vr4100 derivates, or we could also
add code to build the function depending on CPU type. What do you think?


     Ricardo
