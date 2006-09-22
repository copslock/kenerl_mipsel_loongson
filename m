Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2006 06:47:45 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:30004 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037709AbWIVFrn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Sep 2006 06:47:43 +0100
Received: by mo.po.2iij.net (mo31) id k8M5lfDO002714; Fri, 22 Sep 2006 14:47:41 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id k8M5lYm0049911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Sep 2006 14:47:34 +0900 (JST)
Date:	Fri, 22 Sep 2006 14:47:34 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] fixed mtc0_tlbw_hazard
Message-Id: <20060922144734.18773f05.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060922.141634.07643963.nemoto@toshiba-tops.co.jp>
References: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp>
	<20060922.141634.07643963.nemoto@toshiba-tops.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Nemoto-san,

On Fri, 22 Sep 2006 14:16:34 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Fri, 22 Sep 2006 01:07:13 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > Some mtc0_tlbw_hazard() were broken by "[MIPS] Cleanup hazard handling" patch.
> ...
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > 
> > diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/hazards.h mips/include/asm-mips/hazards.h
> > --- mips-orig/include/asm-mips/hazards.h	2006-09-21 18:21:11.793973750 +0900
> > +++ mips/include/asm-mips/hazards.h	2006-09-21 18:55:07.569201750 +0900
> > @@ -138,7 +138,7 @@ ASMMACRO(back_to_back_c0_hazard,
> >   * Mostly like R4000 for historic reasons
> >   */
> >  ASMMACRO(mtc0_tlbw_hazard,
> > -	 b	. + 8
> > +	 nop; nop; nop; nop; nop; nop
> >  	)
> >  ASMMACRO(tlbw_use_hazard,
> >  	 nop; nop; nop; nop; nop; nop
> > @@ -169,7 +169,7 @@ ASMMACRO(back_to_back_c0_hazard,
> >   * processors.
> >   */
> >  ASMMACRO(mtc0_tlbw_hazard,
> > -	 b	. + 8
> > +	 nop; nop; nop; nop; nop; nop
> >  	)
> >  ASMMACRO(tlbw_use_hazard,
> >  	 nop; nop; nop; nop; nop; nop
> > 
> 
> The root problem would be new ASMMACRO lacks .set noreorder.
> 
> Here is my proposal.

It's OK for me.
I tested on VR41xx and Cobalt Qube2(Nevada).

Yoichi
