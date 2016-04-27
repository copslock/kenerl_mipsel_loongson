Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Apr 2016 02:32:44 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35381 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027448AbcD0Acm42mf8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Apr 2016 02:32:42 +0200
Received: by mail-pa0-f42.google.com with SMTP id iv1so12707027pac.2
        for <linux-mips@linux-mips.org>; Tue, 26 Apr 2016 17:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OuSxuMKwDJQgnfTG8q3r1IVa2I45fdap4oZ+NFG3Cqo=;
        b=NACAzjMUIE6INzPJQ07TJYjLNJS+kLOltJxpjdw2VPAc+8Y8DspCSf8O65F1VwHCDg
         AJlGAYbjDLPmuXjmUKnUDqUUJ+FEf3rQC0gj6q+DakWMdiSOpZY9iLzT80a4OMt8R1Ni
         3f8hzCzFb2fXFILedr3g+QPLEPoWtpm/3r3XOeeVd7xrw77pGfgStm23cZ8Q6VHmEqtb
         mhO9OAVmfTsoBi7iWaeX24MPjh/2evnbmpTvpiH0cEeqInp8VaMcplQjedDXd8E/wgm/
         VkVuMxMRsumQaZb/6hL08a/YAPuB+0CpQgRY3ZTHuwuUxD/RJWDDAGd2RXVAqg813Ypi
         dmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OuSxuMKwDJQgnfTG8q3r1IVa2I45fdap4oZ+NFG3Cqo=;
        b=FnrPKTEf78TjUpz87fnBJbtT0iAiJ/7XUlpFJ14tisxZtndbQjBZpU3QyoDYJDPyLj
         ftD6/bTIEJtv3edfLFi3n3vOn++EgiswKpVvpPZkgHr78FNCMwSPa1SMVeesB0jNNFwP
         TIFcwkxykT/vEfxi9Yj7p29yCJqYPPKzu7/peyYNbltfkAT92mmCaAIXq46sRKAcPryA
         gZVSZPn3S+j4P6i3MiHyAt1X0k+MfAP4Z5aPk4K9mpNl+Goo3pUwBTjVTe0hObAn2cKU
         xXOZlL5T+N6xU6J3PWcCeGl9pq6anpV7KtGjCGM2dVQQH+s4PjiN2/5mxckZ4qOTjOUP
         B4sA==
X-Gm-Message-State: AOPr4FVdayD8Jez4i1e6YFbkowL9Hr9qFO7zV82+3+Iif4BF4kLz5yzcFb7THxiSsKJKmg==
X-Received: by 10.66.136.235 with SMTP id qd11mr7690275pab.140.1461717156836;
        Tue, 26 Apr 2016 17:32:36 -0700 (PDT)
Received: from localhost ([110.70.50.108])
        by smtp.gmail.com with ESMTPSA id lz5sm1362701pab.34.2016.04.26.17.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2016 17:32:35 -0700 (PDT)
Date:   Wed, 27 Apr 2016 09:34:09 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk/nmi: flush NMI messages on the system panic
Message-ID: <20160427003409.GA4782@swordfish>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-5-git-send-email-pmladek@suse.com>
 <20160423034924.GA535@swordfish>
 <20160426142157.GK2749@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160426142157.GK2749@pathway.suse.cz>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <sergey.senozhatsky.work@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergey.senozhatsky.work@gmail.com
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

On (04/26/16 16:21), Petr Mladek wrote:
[..]
> > move printk_nmi_flush_on_panic() to printk.c, and place it next to
> > printk_flush_on_panic() (so we will have two printk "flush-on-panic"
> > functions sitting together). /* printk_nmi_flush() is in printk.h,
> > so it's visible to printk anyway */
> > 
> > it also will let us keep logbuf_lock static, it's a bit too internal
> > to printk to expose it, I think.
> > 
> > IOW, something like this?
> 
> It is rather cosmetic change. I 

oh yes, it is. just to keep similar functionality (flush, zap locks)
in one place (printk).

	-ss
