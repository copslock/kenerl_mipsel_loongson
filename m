Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 04:31:34 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:63064 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491910AbZKIDb2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 04:31:28 +0100
Received: by yxe42 with SMTP id 42so3590519yxe.22
        for <multiple recipients>; Sun, 08 Nov 2009 19:31:19 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=dcSjrvR3X/EvCGPnWKAYR8bAdfnZ01v4e1IywO9dFWQ=;
        b=YLwk4IGU/6T91dnkwAxoXD0cdJGj54bLkYLj7xTo9pLHNmXyty/rQkTePXQ4SjzxzJ
         FZrU9eeJkkvtvaUTmKpWTevgx19XWkcFFbIt5Bh+ONAX3jFbrD6YxeM3zcfUhgFepjcL
         0hSEp++vu21eGsmxyVQm+YtQr2WONcIOTrxhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=u+uRL9XDRRWpwIW108J5CkO0y48fX1uP16L1BkblBdQEMS70vzy/L7Q7UiQzhaPKzM
         oBpcnCst/LDkpN9Pu+d22wV4ZxX74ZAqnGfpA9JIbAbUgY5R1pHCVQewinjXVvTgNrsu
         k+kyrKIEVndYS+Kt5K6gI3XLnmQkP7sKQMer8=
Received: by 10.91.103.17 with SMTP id f17mr13511888agm.114.1257737479469;
        Sun, 08 Nov 2009 19:31:19 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 36sm1068350yxh.49.2009.11.08.19.31.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 19:31:18 -0800 (PST)
Subject: Re: [PATCH -v6 08/13] tracing: add IRQENTRY_EXIT section for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Frederic Weisbecker <fweisbec@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20091109022640.GC13153@nowhere>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
	 <f746f813531a16bd650f9290787c66cbc0cdc34d.1256569489.git.wuzhangjin@gmail.com>
	 <20091109022640.GC13153@nowhere>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Mon, 09 Nov 2009 11:31:08 +0800
Message-ID: <1257737468.3451.9.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 2009-11-09 at 03:26 +0100, Frederic Weisbecker wrote:
> On Mon, Oct 26, 2009 at 11:13:25PM +0800, Wu Zhangjin wrote:
> > This patch add a new section for MIPS to record the block of the hardirq
> > handling for function graph tracer(print_graph_irq) via adding the
> > __irq_entry annotation to the the entrypoints of the hardirqs(the block
> > with irq_enter()...irq_exit()).
> > 
> > Thanks goes to Steven & Frederic Weisbecker for their feedbacks.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > +
> > +/*
> > + * do_IRQ handles all normal device IRQ's (the special
> > + * SMP cross-CPU interrupts have their own specific
> > + * handlers).
> > + */
> > +unsigned int __irq_entry do_IRQ(unsigned int irq)
> > +{
> > +	irq_enter();
> > +	__DO_IRQ_SMTC_HOOK(irq);
> > +	generic_handle_irq(irq);
> > +	irq_exit();
> > +
> > +	return 1;
> > +}
> 
> 
> 
> Nano-neat:
> 
> Why is it returning a value, it doesn't seem needed (the macro
> version didn't)?
> 

Will remove it later. 

> Anyway, that looks good to me. I hope the changes from macro
> to function calls will be ack by the MIPS maintainers.
> 

Hope Ralf give some feedbacks about it ;)

> Reviewed-by: Frederic Weisbecker <fweisbec@gmail.com>
> 

Thanks!

BTW: 

Who should I resend this patchset to? you or Steven? If this patchset
are okay, I will rebase it on the latest tracing/core branch of -tip and
send the latest version out, and hope you can apply it, otherwise, I
need to rebase it to the future mainline versions again and again ;) and
at least, I have tested all of them and their combinations on YeeLoong
netbook, they work well. of course, more testing report from the other
MIPS developers are welcome ;)

Regards,
	Wu Zhangjin
