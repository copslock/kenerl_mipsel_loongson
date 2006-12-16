Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Dec 2006 17:19:17 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:40644 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20039490AbWLPRTM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 Dec 2006 17:19:12 +0000
Received: from lagash (p54A46E44.dip.t-dialin.net [84.164.110.68])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 6CDADBAD28;
	Sat, 16 Dec 2006 18:10:59 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1Gvd4Z-0008C1-5t; Sat, 16 Dec 2006 17:11:43 +0000
Date:	Sat, 16 Dec 2006 17:11:43 +0000
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	qemu-devel@nongnu.org
Subject: Re: [MIPS] Use conditional traps for BUG_ON on MIPS II and better.
Message-ID: <20061216171142.GA21660@networkno.de>
References: <S20037651AbWK3BXW/20061130012322Z+10503@ftp.linux-mips.org> <20061204.015327.36921579.anemo@mba.ocn.ne.jp> <20061203213518.GA22225@linux-mips.org> <20061216.012645.07642903.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216.012645.07642903.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Sun, 3 Dec 2006 21:35:18 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > It seems this commit break QEMU kernel ...  or QEMU can not interpret
> > > the TNE instruction correctly?
> > 
> > Thiemo says that's indeed a possibility.  Probably that feature has not
> > been well tested in qemu.
> 
> I found the bug.  "Trap If XXX" instructions are translated as it was
> "Trap If XXX Immediate".
> 
> Index: target-mips/translate.c
> ===================================================================
> RCS file: /sources/qemu/qemu/target-mips/translate.c,v
> retrieving revision 1.27
> diff -u -r1.27 translate.c
> --- target-mips/translate.c	10 Dec 2006 22:08:10 -0000	1.27
> +++ target-mips/translate.c	15 Dec 2006 16:16:07 -0000
> @@ -1276,6 +1276,7 @@
>              GEN_LOAD_REG_TN(T1, rt);
>              cond = 1;
>          }
> +        break;
>      case OPC_TEQI:
>      case OPC_TGEI:
>      case OPC_TGEIU:

Thanks, committed.


Thiemo
