Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 16:31:35 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.228]:11446 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038609AbXBHQbb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 16:31:31 +0000
Received: by qb-out-0506.google.com with SMTP id e12so84619qba
        for <linux-mips@linux-mips.org>; Thu, 08 Feb 2007 08:30:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hlhcRTXMF7LExNHjteVbFAG7fddNT46TB1TcqXBWACLriS9xR/fQmhtUqka4qm5uptMyBqS4B0ikL95Xj7WDJAcVULfwuE9RIW7cMzOTsEWm48ydg22D/8mleIdgnlnLyNPQqov6Uf+mF+BOyXdpXln7x8xtxpA+yYDoM7qikHI=
Received: by 10.114.75.1 with SMTP id x1mr4374091waa.1170952229739;
        Thu, 08 Feb 2007 08:30:29 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Thu, 8 Feb 2007 08:30:29 -0800 (PST)
Message-ID: <cda58cb80702080830n44627bafw88b0b6620eefb693@mail.gmail.com>
Date:	Thu, 8 Feb 2007 17:30:29 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from a context.
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	macro@linux-mips.org
In-Reply-To: <20070209.002323.115905985.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070208.012216.103777705.anemo@mba.ocn.ne.jp>
	 <Pine.LNX.4.64N.0702071725150.9744@blysk.ds.pg.gda.pl>
	 <20070208.120219.96684712.nemoto@toshiba-tops.co.jp>
	 <20070209.002323.115905985.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/8/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Thu, 08 Feb 2007 12:02:19 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Here is a first cut.  Changes in r4k_fpu.S can be reverted, and after
> Franck's patchset applied, this patch can be a bit smaller.  Please
> review.
>

yes this's going to conflict a lot with the patchset I sent...

[snip]

> +static inline int
>  restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
>  {
>         unsigned int used_math;
> @@ -112,7 +144,8 @@ restore_sigcontext(struct pt_regs *regs,
>         if (used_math()) {

sorry for the stupid question but I don't know fpu code...Here
used_math() function is used as condition whereas used_math local is
already defined. Are we sure we want to use the function here ?

-- 
               Franck
