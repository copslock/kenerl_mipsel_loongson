Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2006 14:45:32 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:32195 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133613AbWDUNpW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Apr 2006 14:45:22 +0100
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id 52DB045428; Fri, 21 Apr 2006 15:58:10 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.61)
	(envelope-from <ths@networkno.de>)
	id 1FWw8c-00027s-Rh; Fri, 21 Apr 2006 14:57:34 +0100
Date:	Fri, 21 Apr 2006 14:57:34 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] fix modpost segfault for 64bit mipsel kernel
Message-ID: <20060421135734.GL10665@networkno.de>
References: <20060420001900.GC30806@networkno.de> <20060421.010237.25910405.anemo@mba.ocn.ne.jp> <20060420162319.GD10665@networkno.de> <20060421.020514.96686583.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421.020514.96686583.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Thu, 20 Apr 2006 17:23:19 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > > Well, I just take ELF64_MIPS_R_TYPE() from glibc source.
> > 
> > It is not more useful in glibc. :-)  Any use of the TYPE data will have
> > to take the MIPS64 specifics in account, and thus split it up again
> > into single characters.
> 
> OK, then I drop TYPE data and simplify the patch.  Take 4.

Looks good to me, FWIW.


Thiemo
