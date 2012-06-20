Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 22:10:40 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:52742 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903507Ab2FTUKf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2012 22:10:35 +0200
Received: by eaaf11 with SMTP id f11so2735346eaa.36
        for <multiple recipients>; Wed, 20 Jun 2012 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=1sJe6v3KdjlhG0vJo7t+XlXm+z3e4jOLZeoYtJoiAGg=;
        b=LzyJu7LalRKZt+SXXTzN1EaxrgBL9qZaG5uExV/NIjuBsOJnopmWjnQG/fwexUYnFy
         FskX+KfNcgIRC27HsLdfg0XHbzCf8cuPY/nHXwcNNv+fq52rb/cJD7vMHQQMx8mUJVTy
         I4QklcT/3MWwKMNj9X8X28jRw0iXjZFRkoilf/cuEIltXnqQLdIP7sft4A9KihjHmLhs
         Y6bSlDoLHMcZ+9/m5s9mY+yXD4Ve8tdB2ZgKMSXVLXh6qZLcz9UsoANbPgshAewMW70v
         paDP1snkh3eDyTqR2YO3FAsmWCCqd8XeAmJKmr8Ad6Mz9HuuQR2KhNjSx/gzjBDXZ6NQ
         cWRA==
Received: by 10.14.186.4 with SMTP id v4mr1003275eem.26.1340223030591;
        Wed, 20 Jun 2012 13:10:30 -0700 (PDT)
Received: from bender.localnet ([2a01:e35:2f70:4010:20e5:1628:3cc8:6041])
        by mx.google.com with ESMTPS id v16sm93468125eem.17.2012.06.20.13.10.27
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 13:10:28 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, zhzhl555@gmail.com
Subject: Re: [PATCH V7 2/4] MIPS: Add board support for Loongson1B
Date:   Wed, 20 Jun 2012 22:10:26 +0200
Message-ID: <1463808.aB2kcWCEuH@bender>
Organization: OpenWrt
User-Agent: KMail/4.8.3 (Linux/3.2.0-25-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <4FE225F3.4080806@mvista.com>
References: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com> <20120620192551.GC29446@linux-mips.org> <4FE225F3.4080806@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-archive-position: 33749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wednesday 20 June 2012 23:35:15 Sergei Shtylyov wrote:
> Hello.
> 
> On 06/20/2012 11:25 PM, Ralf Baechle wrote:
> 
> >> +#include <linux/clk.h>
> 
> >> +static LIST_HEAD(clocks);
> >> +static DEFINE_MUTEX(clocks_mutex);
> >> +
> >> +struct clk *clk_get(struct device *dev, const char *name)
> >> +{
> >> +	struct clk *c;
> >> +	struct clk *ret = NULL;
> >> +
> >> +	mutex_lock(&clocks_mutex);
> >> +	list_for_each_entry(c, &clocks, node) {
> >> +		if (!strcmp(c->name, name)) {
> >> +			ret = c;
> >> +			break;
> >> +		}
> >> +	}
> >> +	mutex_unlock(&clocks_mutex);
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL(clk_get);
> 
> > This redefines a function that already is declared in <linux/clk.h> and
> > defined in drivers/clk/clkdev.c.  Why?
> 
>     Because he doesn't support clkdev? clkdev support is optional.

I don't think it is a good idea not to support clkdev for new targets. Ralf 
what do you think about it?


> 
> >> +int clk_register(struct clk *clk)
> >> +{
> >> +	mutex_lock(&clocks_mutex);
> >> +	list_add(&clk->node, &clocks);
> >> +	if (clk->ops->init)
> >> +		clk->ops->init(clk);
> >> +	mutex_unlock(&clocks_mutex);
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL(clk_register);
> 
> > Same here.
> 
> >    Ralf
> 
> WBR, Sergei
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Florian
