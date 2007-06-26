Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2007 16:20:59 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.178]:13793 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021575AbXFZPUy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Jun 2007 16:20:54 +0100
Received: by py-out-1112.google.com with SMTP id p76so3213897pyb
        for <linux-mips@linux-mips.org>; Tue, 26 Jun 2007 08:20:43 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pPmHfGZIyHv4JuUGCHnQFicYfTLU8Tt7rCUZIa6qVOOn3ikI1gKMp+RpM7UuRagu7jmzadkHPeN75JGO/i1CIXRLlFQrtekH9/HeZWg0Fva1muqslaMpWgTtIR7KPGFsG2t1QotCqGEUhGfwprJKUSUF1ZfETTFIBRZbCkHO4VA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lbOTE4ehBS8WxKxfKua5VqFALfiTdubkCXtEs0ZDNsqVOndb12qpo3NIt9Lp0WquIcvBnitK2YnW9QrenzBk1YG/ok/BxZ3DR+c07Ye82bQ5AggpYGzeQ93stldKlZOl1I7gieXQRNWk1ENdAetq392vjCg2J78zYyWGhKkYtlc=
Received: by 10.64.213.3 with SMTP id l3mr11311475qbg.1182871243774;
        Tue, 26 Jun 2007 08:20:43 -0700 (PDT)
Received: by 10.65.185.1 with HTTP; Tue, 26 Jun 2007 08:20:43 -0700 (PDT)
Message-ID: <cda58cb80706260820y4db3eacnae4dff0101852d52@mail.gmail.com>
Date:	Tue, 26 Jun 2007 17:20:43 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] generic clk API implementation for MIPS
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20070626.233332.74753130.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070626.011449.132112302.anemo@mba.ocn.ne.jp>
	 <cda58cb80706260237r60a0b6b3obeba7daac7cf114a@mail.gmail.com>
	 <20070626.233332.74753130.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
>
> Well, it seems simpler, but I suppose clk_register() is very useful ;)
>

Thinking about it, it seems to me that a clock is very static. I can't
think of a use case that would need to register a new clock after the
kernel has booted. Do you have a use case in mind ? cpu hotplug
perhaps ?

I'm a bit worry because if we go that way, we must be sure that
clk_register() can be called very early in the boot process. For
example, when using early printk thing...

> +static void clk_kref_release(struct kref *kref)
> +{
> +	/* Nothing to do */
> +}
> +
> +static void __clk_disable(struct clk *clk)
> +{
> +	if (clk->flags & CLK_ALWAYS_ENABLED)
> +		return;
> +
> +	kref_put(&clk->kref, clk_kref_release);
> +}
> +
> +void clk_disable(struct clk *clk)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&clock_lock, flags);
> +	__clk_disable(clk);
> +	spin_unlock_irqrestore(&clock_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(clk_disable);

It seems that you stripped too much here: where clk->disable() method
is called ?

> +struct clk;
> +
> +struct clk_ops {
> +	void (*init)(struct clk *clk);
> +	void (*enable)(struct clk *clk);
> +	void (*disable)(struct clk *clk);
> +	int (*set_rate)(struct clk *clk, unsigned long rate);
> +};
> +
> +struct clk {
> +	struct list_head	node;
> +	const char		*name;
> +	int			id;
> +
> +	struct clk		*parent;

Is this field used by board code ?
---
                Franck
