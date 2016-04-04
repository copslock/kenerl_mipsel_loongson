Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 06:50:41 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35252 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013787AbcDDEuk1dBBj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 06:50:40 +0200
Received: by mail-pa0-f54.google.com with SMTP id td3so135313914pab.2
        for <linux-mips@linux-mips.org>; Sun, 03 Apr 2016 21:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8JB39GqfmTQRtG+SS2uHSozeuxGLKSM7QsimX9Low2s=;
        b=WwAE4iOvpVr+Ed82p6bGFF5YPHjVooqdzE3ki/h3NEPfkUAXkteMJD/+rn8MIklWnY
         Sx0RG7BgztSFBbIZZkrOKqj5ku9DDyJui0xlSNSKCqvUC5AIvIa8JQ5/4mSL2nOF5e57
         ZhDfzMdKC/ltg3zWaPbigU3EdxLn1aYO4+lcA6ovAqGq+YcC+9IVh7onAr8q5+h+RQhn
         I9tGv5d+QocueIyv6EPtKH4hYCVhjN4ohnJ3xf35fHJHOROPNuvpRxpu+kSXNVkkTJOo
         L45f/vIuYyfuFQqR6F1tUh3wtV1sFmPTRawe8ARMqi+Sab76P8VtXfv1tzeOwTwIAngr
         Wbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8JB39GqfmTQRtG+SS2uHSozeuxGLKSM7QsimX9Low2s=;
        b=CcPP5I8k+3sTzjW4gAzDTcOkZJ0q0+HjOJUmYEpZ2jU4ElH73WtRkLgYNGGtXKfsfs
         guulbJhl05/5gP3jDNzI8OH13ga7Gcx3culW1oIgl18+LdayzdsPiqiOB0RAXSRrqdFy
         a4uRm3pUWuSjHmSmeS4tWoQazfpCNJl/CnGomnx5zuTEs4F+EdJzIEjJ6klDcsrluiy5
         1FLG/YJt4x+x09P14w9Xx+SkGHQIIGotkmGY8faV6Ow2nogFeZmNSXrTLXpF+Hwl54ww
         4dA2BjJMX4lZVY2+JDQm4cgtcRtnM7ot7ze0q8RgCkvrf5EKrN5lMYtaGf/Pm9/OXJgq
         OVDw==
X-Gm-Message-State: AD7BkJLeQQoIjzyj4ksi1LWAH7MXCA5QvRlGpAQ3uxkHRdlLIqOeL9EDVIJZ2M4VXRBAyQ==
X-Received: by 10.67.14.138 with SMTP id fg10mr50196696pad.145.1459745434817;
        Sun, 03 Apr 2016 21:50:34 -0700 (PDT)
Received: from localhost ([39.7.56.6])
        by smtp.gmail.com with ESMTPSA id r68sm35667189pfa.33.2016.04.03.21.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Apr 2016 21:50:33 -0700 (PDT)
Date:   Mon, 4 Apr 2016 13:52:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 5/5] printk/nmi: flush NMI messages on the system panic
Message-ID: <20160404045200.GE6164@swordfish>
References: <1459353210-20260-6-git-send-email-pmladek@suse.com>
 <201603310000.dKufp7mg%fengguang.wu@intel.com>
 <20160331123657.GN5522@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160331123657.GN5522@pathway.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <sergey.senozhatsky.work@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52851
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

On (03/31/16 14:36), Petr Mladek wrote:
[..]
>  #ifdef CONFIG_PRINTK_NMI
> +#define deferred_console_in_nmi() in_nmi()
>  #else
> +#define deferred_console_in_nmi() 0
[..]
> +	if (!in_sched && !deferred_console_in_nmi()) {
>  		lockdep_off();
>  		/*
>  		 * Try to acquire and then immediately release the console

or use SCHED level for nmi messages instead of defining deferred_console_in_nmi()?
so !in_sched will work for both SCHED and NMI messages.

	-ss
