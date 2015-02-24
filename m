Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 08:39:15 +0100 (CET)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34974 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006864AbbBXHjO0V0YT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 08:39:14 +0100
Received: by wggz12 with SMTP id z12so3448747wgg.2
        for <linux-mips@linux-mips.org>; Mon, 23 Feb 2015 23:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xfRLyw0EOFJ0tjKSuwyTCk4Y5dPzNWLcpNcpo8hKCrU=;
        b=JuoDp3q9TMncxrylb0Hoo42x2DSODlcYZ9IAZcBIC2PoK9qSFgwYxNZD4NyjgIXiPj
         Xal/SfGe8k38hECO0xJjKFXkzAvX7eTmCZ+OR0WsgYxwunJxB+33t2biXEfxkWKCX74p
         UZO/UI2/k6i5bY/59NgPV1Bu4PYgTnzkz754N8sFiRfen/thhZbbLItEs8CF4J5pR1Os
         pKYJvshzLgCj3sjIUc0I1I0i4X0uooJcxZWsjLRh8aScFh0+vsbYlSLtR3CZjMutqxO3
         pdbfZWj5okTZgfIhNXPTGfFPA95G2hNkqnjLUsBB17tMtTjt0RNWE6hwvb5bmB7cwaCn
         3mhw==
X-Received: by 10.194.80.193 with SMTP id t1mr30677360wjx.8.1424763549585;
        Mon, 23 Feb 2015 23:39:09 -0800 (PST)
Received: from gmail.com (540331C6.catv.pool.telekom.hu. [84.3.49.198])
        by mx.google.com with ESMTPSA id 18sm58937260wjr.46.2015.02.23.23.39.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2015 23:39:08 -0800 (PST)
Date:   Tue, 24 Feb 2015 08:39:06 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Hector Marco Gisbert <hecmargi@upv.es>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ismael Ripoll <iripoll@upv.es>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
Message-ID: <20150224073906.GA16422@gmail.com>
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150223205436.15133mg1kpyojyik@webmail.upv.es>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Hector Marco Gisbert <hecmargi@upv.es> wrote:

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + brk_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

> +unsigned long randomize_et_dyn(unsigned long base)
> +{
> +	unsigned long ret;
> +	if ((current->personality & ADDR_NO_RANDOMIZE) ||
> +		!(current->flags & PF_RANDOMIZE))
> +		return base;
> +	ret = base + mmap_rnd();
> +	return (ret > base) ? ret : base;
> +}

That pointless repetition should be avoided.

Thanks,

	Ingo
