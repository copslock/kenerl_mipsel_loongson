Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 12:32:13 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:41192 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009149AbaLSLcLSjUpK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 12:32:11 +0100
Received: by mail-lb0-f182.google.com with SMTP id f15so685512lbj.41
        for <linux-mips@linux-mips.org>; Fri, 19 Dec 2014 03:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=F4CjejdOmnMaNITx8O8a81r4dMsJiyL9mm0Z8TxIOTU=;
        b=KcZI3So4+Nw/bny8prHnvjL82xbgUZz/AwnAOT+yUfStsrehQFN4lAXTlPuyXa+rTo
         1EUXB7tY++EC4PnZXRo3+d0e6PQqB+Ww74W5vbfKk8e6zwJmrqf/8KU4UYtHyDrpdkQi
         0/PWnH1KYQWHgPAu53O6zut05jroq0lqVZn6yaec4GVJNNp7KgUBzXj6nklDNAG8DtUs
         CbMH6VlfJP4w9y7yFh2nfAXLbcu3jc5JjhQMRsJIcaeqzzVwygu+3P5wAMkuYcuW6H1O
         1BP/mnplDKvOxPckRRr8OL0i+RP/8gqcGM0f1kQqQxFjAU6eANzQmmsCz9b8e0r9m7Qp
         pSOg==
X-Gm-Message-State: ALoCoQnHojLzTenRnnZ1V1vWzDiYabqxSvbJt8wbY505LRR5sj/H19eMy2XchWzPGBnzYmQf7alZ
X-Received: by 10.112.201.72 with SMTP id jy8mr7253562lbc.65.1418988725765;
        Fri, 19 Dec 2014 03:32:05 -0800 (PST)
Received: from [192.168.3.154] (ppp83-237-251-130.pppoe.mtu-net.ru. [83.237.251.130])
        by mx.google.com with ESMTPSA id kw10sm2636001lac.45.2014.12.19.03.32.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Dec 2014 03:32:04 -0800 (PST)
Message-ID: <54940CB4.3090204@cogentembedded.com>
Date:   Fri, 19 Dec 2014 14:32:04 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH RFC 29/67] MIPS: kernel: proc: Add MIPS R6 support to
 /proc/cpuinfo
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-30-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1418915416-3196-30-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44836
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

On 12/18/2014 6:09 PM, Markos Chandras wrote:

> Print 'mips64r6' and/or 'mips32r6' if the kernel is running on
> a MIPS R6 core.

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/kernel/proc.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 097fc8d14e42..b2194770878d 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -82,7 +82,10 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>   		seq_printf(m, "]\n");
>   	}
>
> -	seq_printf(m, "isa\t\t\t: mips1");
> +	if (!cpu_has_mips_r6)
> +		seq_printf(m, "isa\t\t\t: mips1");
> +	else
> +		seq_printf(m, "isa\t\t\t:");

    The following seems shorter.

	seq_printf(m, "isa\t\t\t:");
	if (!cpu_has_mips_r6)
		seq_printf(m, " mips1");

[...]

WBR, Sergei
