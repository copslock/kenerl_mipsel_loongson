Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 14:59:20 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:46748 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28578858AbYFLN7R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 14:59:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5CDwbDL031021;
	Thu, 12 Jun 2008 14:58:38 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5CDwZ5K031008;
	Thu, 12 Jun 2008 14:58:35 +0100
Date:	Thu, 12 Jun 2008 14:58:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: pending mips build fixes
Message-ID: <20080612135835.GB20015@linux-mips.org>
References: <20080612134539.GA20487@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080612134539.GA20487@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2008 at 04:45:40PM +0300, Adrian Bunk wrote:
> From: Adrian Bunk <bunk@kernel.org>
> Date: Thu, 12 Jun 2008 16:45:40 +0300
> To: ralf@linux-mips.org
> Cc: linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>,
> 	Aurelien Jarno <aurelien@aurel32.net>,
> 	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Subject: pending mips build fixes
> Content-Type: text/plain; charset=utf-8
> 
> Hi Ralf,
> 
> I hope I'm not too annoying on this, but I like it when as many 
> defconfigs as possible compile.
> 
> Please review and push the following patches for 2.6.26:
> 
>   BCM47xx: Add platform specific PCI code
>   http://marc.info/?l=linux-kernel&amp;m=120876451216558&amp;w=2
> 
>   MIPS: Fix CONF_CM_DEFAULT build error
>   http://lkml.org/lkml/2008/6/1/125

That won't fly.  CONF_CM_DEFAULT is being dereferenced before
_page_cachable_default has been initialized.

Can't comment at the BCM47xx patch yet.

  Ralf
