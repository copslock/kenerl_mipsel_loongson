Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 06:55:20 +0200 (CEST)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34059 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008573AbcDDEzSeQE6j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 06:55:18 +0200
Received: by mail-pa0-f53.google.com with SMTP id fe3so135823460pab.1;
        Sun, 03 Apr 2016 21:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=18CwziD8CMnX74qBEpnGDvLMA55Jefo+za9IRmjHOx4=;
        b=yP7dKgDIylxcrNXP23nNOkXeMOSY/pzIT5xqxecyLhFna9Tqp2ac5o7FasWV7dYoQu
         mw6HPFz3sQIBGr2/S6FcQRNpS9Osgx8CQcmrxrM0JdimEiQhCioZUC5qm+hxsn+SqQXl
         9xAJlastEIJ9Ka4u9jg+Wn677akKUwQiXzPIGzwE7+JVq1y/qMhKhPXJOgl/AdIoWGkd
         +DR0Oe46XTc1mW+2r6Yg+8m3hy2agOCXDZprcqEIM8NjhUI6zeBV+qjnLKNggIlXGNem
         YDhsDUkT0JI7Sl5RQcvOp4eFwr7XaM0/90KbhsEhzZu8yfpNnUlB2lp20Ozur55wxOhx
         rhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=18CwziD8CMnX74qBEpnGDvLMA55Jefo+za9IRmjHOx4=;
        b=iycbX7hwmhluPCWkeWJvfRliezqzcYaaLMUvg1ZOtD9AlYg2J47skm9wI0pt+FizQx
         v9YoRMgZZdsM0ZSmRfkCQ3rlW12kadu6mzhhOKCurU1u4nOQkA8z6sx07ICsCr6Kxole
         UxEHNII/YewQVTjmbatSDfxWb4GgSrXyJeJUJg/fw2I1JhXyU6nqFIaCPU1sPdOzV/22
         zencVU1jfh9Ci/SgBq3N/BR51ZdCsjoc/8u8xKE6UpZyiWbIXzSiGh6Dl2mfHnNdy5/B
         +12OZeqhsn4QUn1BxNaVOGMmSfLW651tt/ZC42QDeiiOPqB3IKugztqCi7rn1cdK6mwR
         9C0A==
X-Gm-Message-State: AD7BkJLL3HrUcyGxm8hBNnSTZujzG1LkrT4/2LnjPsRqR0zf9m6oK/sUPgrQ3vnyc29aLA==
X-Received: by 10.66.141.76 with SMTP id rm12mr50911135pab.30.1459745712792;
        Sun, 03 Apr 2016 21:55:12 -0700 (PDT)
Received: from localhost ([39.7.56.6])
        by smtp.gmail.com with ESMTPSA id v3sm37861466par.17.2016.04.03.21.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Apr 2016 21:55:11 -0700 (PDT)
Date:   Mon, 4 Apr 2016 13:56:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH v4 2/5] printk/nmi: use IRQ work only when ready
Message-ID: <20160404045629.GF6164@swordfish>
References: <1459353210-20260-1-git-send-email-pmladek@suse.com>
 <1459353210-20260-3-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459353210-20260-3-git-send-email-pmladek@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <sergey.senozhatsky.work@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52852
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

Hello,

On (03/30/16 17:53), Petr Mladek wrote:
> NMIs could happen at any time.  This patch makes sure that the safe
> printk() in NMI will schedule IRQ work only when the related structs are
> initialized.
> 
> All pending messages are flushed when the IRQ work is being initialized.

so, does this patch 'fix' 0001 (in a way)? shouldn't it then be folded?
sorry if I'm missing something.

	-ss

>  DEFINE_PER_CPU(printk_func_t, printk_func) = vprintk_default;
> +static int printk_nmi_irq_ready;
>  
>  #define NMI_LOG_BUF_LEN (4096 - sizeof(atomic_t) - sizeof(struct irq_work))
>  
> @@ -84,8 +85,11 @@ again:
>  		goto again;
>  
>  	/* Get flushed in a more safe context. */
> -	if (add)
> +	if (add && printk_nmi_irq_ready) {
> +		/* Make sure that IRQ work is really initialized. */
> +		smp_rmb();
>  		irq_work_queue(&s->work);
> +	}
>  
>  	return add;
>  }
> @@ -195,6 +199,13 @@ void __init printk_nmi_init(void)
>  
>  		init_irq_work(&s->work, __printk_nmi_flush);
>  	}
> +
> +	/* Make sure that IRQ works are initialized before enabling. */
> +	smp_wmb();
> +	printk_nmi_irq_ready = 1;
> +
> +	/* Flush pending messages that did not have scheduled IRQ works. */
> +	printk_nmi_flush();
>  }
