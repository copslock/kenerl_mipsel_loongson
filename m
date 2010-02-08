Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2010 12:54:38 +0100 (CET)
Received: from mail-yw0-f186.google.com ([209.85.211.186]:63929 "EHLO
        mail-yw0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491821Ab0BHLyf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2010 12:54:35 +0100
Received: by ywh16 with SMTP id 16so518917ywh.25
        for <multiple recipients>; Mon, 08 Feb 2010 03:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Kt/1Xt+dPYiWhX16Xi4cZAJM1DLCu/XDPZKG7UdKPNA=;
        b=L+ltBTNT9g5B8SmusNvJVhsvYaOtaSf9o61us0P5abdVQ1fv61nA4BzCQHUSbXmorU
         eoh2KkukWveLwWbwNXxLGrPn224oa1xxaEHSYzygHuqfquzyRlKH4EVcVmyE8FRhB/vh
         TCl5mEP2SmHgD9AU6gij8kuSpXAT8p5yb8+QY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=VVf1vGBEb06e2qWmawiPRCsIYIvbs2dSN30BOxt6pg/zEft91p80aamZmJlY+G3PIl
         07r7IF+CRb1WW4V9bNOKOsFL8/HdNRyZxSBRZDSwgScPyL+zHg+J9eiyAgJ5xqo+dPyj
         kWBG1cQ9njrGSzFqWLpLNl39QNsqYPlOt9EZA=
Received: by 10.101.198.37 with SMTP id a37mr8071640anq.11.1265630068752;
        Mon, 08 Feb 2010 03:54:28 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm2851000gxk.14.2010.02.08.03.54.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Feb 2010 03:54:27 -0800 (PST)
Date:   Mon, 8 Feb 2010 20:54:07 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     yuasa@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: add 8250/16550 serial early printk driver
Message-Id: <20100208205407.cdaa3f21.yuasa@linux-mips.org>
In-Reply-To: <4B6FE030.1080708@ru.mvista.com>
References: <20100205232857.eb65967f.yuasa@linux-mips.org>
        <4B6FE030.1080708@ru.mvista.com>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello Sergei,

On Mon, 08 Feb 2010 12:58:08 +0300
Sergei Shtylyov <sshtylyov@mvista.com> wrote:

> Hello.
> 
> Yoichi Yuasa wrote:
> 
> > Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> >   
> [...]
> > +config EARLY_PRINTK_8250
> > +	bool "8250/16550 and compatible serial early printk driver"
> > +	depends on EARLY_PRINTK
> > +	default n
> > +	help
> > +	  If you say Y here, it will be possible to use a 8250/16550 serial
> > +	  port as the boot console.
> > +	
> >   
> 
>    Tab not needed here.

thanks

> > diff --git a/arch/mips/kernel/early_printk_8250.c b/arch/mips/kernel/early_printk_8250.c
> > new file mode 100644
> > index 0000000..6faf8fd
> > --- /dev/null
> > +++ b/arch/mips/kernel/early_printk_8250.c
[...]
> > +static unsigned long serial8250_base;
> > +static unsigned int serial8250_reg_shift;
> > +static unsigned int serial8250_tx_timeout;
> > +
> > +void setup_8250_early_printk_port(unsigned long base, unsigned int reg_shift,
> > +				  unsigned int timeout)
> > +{
> > +	serial8250_base = base;
> >   
> 
>    Why not declare 'serial8250_base' as 'void __iomem *' and only cast 
> once, here?

You're right. I'll update it.

Thanks,

Yoichi
