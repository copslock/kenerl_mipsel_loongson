Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 18:56:54 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36715 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013740AbaKNR4xRQFQs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2014 18:56:53 +0100
Received: by mail-lb0-f182.google.com with SMTP id f15so14574835lbj.13
        for <linux-mips@linux-mips.org>; Fri, 14 Nov 2014 09:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=7tqUhGJWDqUkAB9PJnsczFFfnwYx+7UzRfu7RZhG3ks=;
        b=WqlPIxVaDDz4VBCg/psv7EZjQ9u3Xriv8kKc5Lq6IhEUWzsXac+n+BLtDpSfD/UdI4
         eMtauaVGW5A3aC4jUy6r3uXPYWzCqI0YLc5N/vemO43HAjn34DNWupZfUV5JPsEX7ggF
         tbaK8EBIVVeAHPIyFXx7zrV1NFeu4Kmy22/d+kNCkui+BpM1RmGF+1lP/38gEQmSlpdB
         0gAY7OQO7EG/nBmL4o7KTwf2uc0bxf0aaNIQyIBy54KLoIaMa756qOqNEi9u2uHo8VGQ
         zzzgwVEy5hE9uZCJGbAL4VLEwVshUrlwyZ+OLYv2gc2rrO6FmRBcAXcKncC3poQqY90G
         kijg==
X-Gm-Message-State: ALoCoQnRx2HUIfPgPa2Ij30jWlBVw5qbfVrMNuhCNN2qoPgOgr1LfIx3q0fgS6bVjAw5xNxpy07x
X-Received: by 10.152.87.18 with SMTP id t18mr9639567laz.0.1415987807778;
        Fri, 14 Nov 2014 09:56:47 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp29-22.pppoe.mtu-net.ru. [81.195.29.22])
        by mx.google.com with ESMTPSA id t6sm8365045lbb.23.2014.11.14.09.56.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2014 09:56:47 -0800 (PST)
Message-ID: <5466425D.1060100@cogentembedded.com>
Date:   Fri, 14 Nov 2014 20:56:45 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Dave Hansen <dave@sr71.net>, hpa@zytor.com
CC:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        qiaowei.ren@intel.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 05/11] x86, mpx: add MPX to disaabled features
References: <20141114151816.F56A3072@viggo.jf.intel.com> <20141114151823.B358EAD2@viggo.jf.intel.com>
In-Reply-To: <20141114151823.B358EAD2@viggo.jf.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 11/14/2014 06:18 PM, Dave Hansen wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>

> This allows us to use cpu_feature_enabled(X86_FEATURE_MPX) as
> both a runtime and compile-time check.

> When CONFIG_X86_INTEL_MPX is disabled,
> cpu_feature_enabled(X86_FEATURE_MPX) will evaluate at
> compile-time to 0. If CONFIG_X86_INTEL_MPX=y, then the cpuid
> flag will be checked at runtime.

> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Qiaowei Ren <qiaowei.ren@intel.com>
> ---

>   b/arch/x86/include/asm/disabled-features.h |    8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

> diff -puN arch/x86/include/asm/disabled-features.h~mpx-v11-add-MPX-to-disaabled-features arch/x86/include/asm/disabled-features.h
> --- a/arch/x86/include/asm/disabled-features.h~mpx-v11-add-MPX-to-disaabled-features	2014-11-14 07:06:22.297610243 -0800
> +++ b/arch/x86/include/asm/disabled-features.h	2014-11-14 07:06:22.300610378 -0800
[...]
> @@ -34,6 +40,6 @@
>   #define DISABLED_MASK6	0
>   #define DISABLED_MASK7	0
>   #define DISABLED_MASK8	0
> -#define DISABLED_MASK9	0
> +#define DISABLED_MASK9	(DISABLE_MPX)

    These parens are not really needed. Sorry to be a PITA and not saying this 
before.

[...]

WBR, Sergei
