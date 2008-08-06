Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 18:15:53 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:406
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28576284AbYHFRPr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Aug 2008 18:15:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m76HFYHo005907;
	Wed, 6 Aug 2008 18:15:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m76HFV87005905;
	Wed, 6 Aug 2008 18:15:31 +0100
Date:	Wed, 6 Aug 2008 18:15:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ricmm@gentoo.org, yoichi_yuasa@tripeaks.co.jp,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] vr41xx: fix problem with vr41xx_cpu_wait
Message-ID: <20080806171531.GA5848@linux-mips.org>
References: <200808060440.m764eF9I021783@po-mbox303.hop.2iij.net> <20080806.223033.128619389.anemo@mba.ocn.ne.jp> <20080806161710.GA22957@woodpecker.gentoo.org> <20080807.021057.59650770.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080807.021057.59650770.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 07, 2008 at 02:10:57AM +0900, Atsushi Nemoto wrote:

> http://www.linux-mips.org/archives/linux-mips/2007-11/msg00123.html
> 
> To support vr41's standby instruction in same way, we might have to
> synthesise rollback_handle_int, etc. or r4k_wait at runtime...

The infrastructure for that is now there :-)  Another question of course
is if that stuff really deserve this ultimate degree of optimization.

  Ralf
