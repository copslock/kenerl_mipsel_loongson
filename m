Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2010 00:52:51 +0100 (CET)
Received: from mail-yw0-f186.google.com ([209.85.211.186]:53625 "EHLO
        mail-yw0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491981Ab0BGXwq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2010 00:52:46 +0100
Received: by ywh16 with SMTP id 16so186365ywh.25
        for <multiple recipients>; Sun, 07 Feb 2010 15:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=y390IcCrBl2sao1vDD3GLVAtIxPn+PoXa91I3hMdChI=;
        b=HkIejIxYj1o5tBJIQKvHq0WD1rfene00SQVcjdwMvUzXNrVCnBssfDq3ZKdQokCUZL
         DrEOUhaw7YFt9cR97GoVMYjOgIyEKoJmqzxYJngt1FgowdpfbTa69p+wZsORmwMXDC1n
         mtsUqZQqRuTk5d+6XilovxObrJJahFnN2x608=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=wES0GyyPRJJSFPsPZQwgr67HL7QPbzyNeiTNdbgEcQwKzrZ1zrK4HrD1aDTFuD+8vd
         AusPenv8Xvnt24iv2wLa4vvp3B8UnnCUUtwbA8jspD5+WL8lhddDlUSw7BoNUG1o/t6b
         GbqaPJhml5gArhK/IBxQ/dGV8fU4d4qCuNcrg=
Received: by 10.101.28.3 with SMTP id f3mr7245445anj.68.1265586759555;
        Sun, 07 Feb 2010 15:52:39 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm2482338gxk.5.2010.02.07.15.52.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 15:52:38 -0800 (PST)
Date:   Mon, 8 Feb 2010 08:52:17 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     yuasa@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: add 8250/16550 serial early printk driver
Message-Id: <20100208085217.ba16b45e.yuasa@linux-mips.org>
In-Reply-To: <20100206121622.GA8775@alpha.franken.de>
References: <20100205232857.eb65967f.yuasa@linux-mips.org>
        <20100206121622.GA8775@alpha.franken.de>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 6 Feb 2010 13:16:22 +0100
Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:

> On Fri, Feb 05, 2010 at 11:28:57PM +0900, Yoichi Yuasa wrote:
> > Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> > ---
> >  arch/mips/Kconfig.debug              |    8 ++++
> >  arch/mips/include/asm/setup.h        |    9 ++++
> >  arch/mips/kernel/Makefile            |    1 +
> >  arch/mips/kernel/early_printk_8250.c |   68 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 86 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/mips/kernel/early_printk_8250.c
> > 
> > diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
> > index 32a010d..f5d739c 100644
> > --- a/arch/mips/Kconfig.debug
> > +++ b/arch/mips/Kconfig.debug
> > @@ -20,6 +20,14 @@ config EARLY_PRINTK
> >  	  doesn't cooperate with an X server. You should normally say N here,
> >  	  unless you want to debug such a crash.
> >  
> > +config EARLY_PRINTK_8250
> > [..]
> 
> have you looked at drivers/serial/8250_early.c ?

Yes, I have.

> It looks like it
> was invented for some sort of early console on 8250 devices...

The early printk is registered at the early boot stage(in setup_arch()).

Yoichi
