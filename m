Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 03:26:51 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:55935 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493486AbZKIC0p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 03:26:45 +0100
Received: by ewy12 with SMTP id 12so2860232ewy.0
        for <multiple recipients>; Sun, 08 Nov 2009 18:26:39 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=5IU8sezTedkQaFeoU6Cv/SZy+I/ECVx1umRfritjcWM=;
        b=KcPyYNGBhSitdmRBsst06ID6TR1doskOjQORVAJhGHaq6c+zrfO4782xUnNpam9pWw
         r+ROOsoCZp4XzVfMiZ7YQ6lsKaRqjOCXbi9PYkkF4aymTz917Kz6RbmTZ443QKHq3nm4
         vMSfF02mXnXLrtmJskdjwOLZZYZDn7qa2qrQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HgPwcky6KihqZSOYwoDU2YnJaCCeOZjsEvDSZK3nXtxZJe4s3OxF1u23SRkm4/a454
         +3g4+tDYqX+CK/fx7nvJAWxfwqEd5OMjtciLmlz8JH31tOLXuRiy4Tem1YwBwnAQZDhs
         2tdPsvsSIYnIA+zceqVPb1cZJIyKdDjpnEEho=
Received: by 10.213.63.75 with SMTP id a11mr946630ebi.63.1257733599483;
        Sun, 08 Nov 2009 18:26:39 -0800 (PST)
Received: from nowhere (ADijon-552-1-106-222.w90-33.abo.wanadoo.fr [90.33.185.222])
        by mx.google.com with ESMTPS id 5sm4932819eyf.23.2009.11.08.18.26.37
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 18:26:38 -0800 (PST)
Received: by nowhere (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128/128 bits))
	fweisbec@gmail.com; Mon,  9 Nov 2009 03:26:44 +0100 (CET)
Date:	Mon, 9 Nov 2009 03:26:42 +0100
From:	Frederic Weisbecker <fweisbec@gmail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: Re: [PATCH -v6 08/13] tracing: add IRQENTRY_EXIT section for MIPS
Message-ID: <20091109022640.GC13153@nowhere>
References: <cover.1256569489.git.wuzhangjin@gmail.com> <f746f813531a16bd650f9290787c66cbc0cdc34d.1256569489.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f746f813531a16bd650f9290787c66cbc0cdc34d.1256569489.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Oct 26, 2009 at 11:13:25PM +0800, Wu Zhangjin wrote:
> This patch add a new section for MIPS to record the block of the hardirq
> handling for function graph tracer(print_graph_irq) via adding the
> __irq_entry annotation to the the entrypoints of the hardirqs(the block
> with irq_enter()...irq_exit()).
> 
> Thanks goes to Steven & Frederic Weisbecker for their feedbacks.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> +
> +/*
> + * do_IRQ handles all normal device IRQ's (the special
> + * SMP cross-CPU interrupts have their own specific
> + * handlers).
> + */
> +unsigned int __irq_entry do_IRQ(unsigned int irq)
> +{
> +	irq_enter();
> +	__DO_IRQ_SMTC_HOOK(irq);
> +	generic_handle_irq(irq);
> +	irq_exit();
> +
> +	return 1;
> +}



Nano-neat:

Why is it returning a value, it doesn't seem needed (the macro
version didn't)?

Anyway, that looks good to me. I hope the changes from macro
to function calls will be ack by the MIPS maintainers.

Reviewed-by: Frederic Weisbecker <fweisbec@gmail.com>
