Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 00:05:42 +0100 (CET)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:40716 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011713AbbATXFkh0Gg6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 00:05:40 +0100
Received: by mail-ig0-f170.google.com with SMTP id l13so19083155iga.1;
        Tue, 20 Jan 2015 15:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=laI+Hey3xCrCnY6lQnJI3xB6WVzk6fhL/YS3E74oXrg=;
        b=Qh//YAQ2irTaMUXouYNWrR/eNYiC6jqLZ5JsHjwIs5DB/glYfupoF92i7zE1r8V61v
         gZk2mCYh1Vz7D2LOua4vNFfFHmF5idYod4G94n9ucCtETKoYj40R/JMO6KAO+dqb/5K3
         jQj9kQEJ/YxZ97VeJsjHFVJSQyRWCj/nrmO3Ih724lPMbCL/HbHrSg6k3/uqn+n1Fu/n
         5doHhaQZVUePclr527kY6O46f/vILy/vO4ceAjmH2QUD0unwaoGG35TvHe5ccvbP/KzD
         Sp3Fl97qteZkKYcl2hpKl/D58VSCYoMqEn74lL7DUoDsNn2Gzg0xq3/ef8hwfJX0/7op
         8/LQ==
X-Received: by 10.50.67.18 with SMTP id j18mr30319917igt.26.1421795134552;
        Tue, 20 Jan 2015 15:05:34 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id g20sm4007964igt.14.2015.01.20.15.05.33
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 Jan 2015 15:05:33 -0800 (PST)
Message-ID: <54BEDF3C.6040105@gmail.com>
Date:   Tue, 20 Jan 2015 15:05:32 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org>
In-Reply-To: <54BCC827.3020806@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/19/2015 01:02 AM, Joshua Kinard wrote:
> From: Joshua Kinard <kumba@gentoo.org>
>
> This is a small patch to display the CPU byteorder that the kernel was compiled
> with in /proc/cpuinfo.

What would use this?  Or in other words, why is this needed?

Userspace C code doesn't need this as it has its own standard ways of 
determining endianness.

If you need to know as a user you can do:

    readelf -h /bin/sh | grep Data | cut -d, -f2


>
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>   arch/mips/kernel/proc.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> This patch has been submitted several times prior over the years (I think), but
> I don't recall what, if any, objections there were to it.
>
> linux-mips-proc-cpuinfo-byteorder.patch
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 097fc8d..75e6a62 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -65,6 +65,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>   	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
>   		      cpu_data[n].udelay_val / (500000/HZ),
>   		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
> +#ifdef __MIPSEB__
> +	seq_printf(m, "byteorder\t\t: big endian\n");
> +#else
> +	seq_printf(m, "byteorder\t\t: little endian\n");
> +#endif
>   	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
>   	seq_printf(m, "microsecond timers\t: %s\n",
>   		      cpu_has_counter ? "yes" : "no");
>
>
>
