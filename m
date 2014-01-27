Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 19:38:57 +0100 (CET)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:45347 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823911AbaA0SixVFvQg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jan 2014 19:38:53 +0100
Received: by mail-ie0-f181.google.com with SMTP id to1so1319984ieb.40
        for <linux-mips@linux-mips.org>; Mon, 27 Jan 2014 10:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bN/sF58Hvq7WWdheuIJSKQ4kPHc95jc9I4fXzBQCMl8=;
        b=p1vMxWDoAD3e04+i6pf2GisgZLhj9ScAEKOB+MzH2mR05Lkc3YB2Jv1igcH37HT4sw
         CG9kfTuQ7sFxIqDSdW7qfpLd/KHkJ/nzE4r0d63jGIwMlo72h94D/de+cgKt97yWHZXy
         mO3bhJlB5tNhNcCTzmOSWFWdgqoWe2jLSfkT4nVyUfntZJt7GCxu9vENIS0co+xpQtFa
         1UQb9/ity5U9T5K0RVp+tGooTIWBD3bjAafK5MhsyWx7VEgIfCc3o4bRr9PqQUWbiNg6
         Z6MA5fpRM4iXcHpwp5x2+5GfvQ6mAEgsVYUJ7Kh1FCIEFR/ygGH2wEVIzG3mQjKGZzBp
         YPew==
X-Received: by 10.50.79.168 with SMTP id k8mr19151685igx.18.1390847927061;
        Mon, 27 Jan 2014 10:38:47 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id w4sm47205243igb.5.2014.01.27.10.38.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jan 2014 10:38:46 -0800 (PST)
Message-ID: <52E6A7B5.2040505@gmail.com>
Date:   Mon, 27 Jan 2014 10:38:45 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 14/15] mips: panic if vector register partitioning is
 implemented
References: <1390836194-26286-1-git-send-email-paul.burton@imgtec.com> <1390836194-26286-15-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1390836194-26286-15-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39113
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

On 01/27/2014 07:23 AM, Paul Burton wrote:
> No current systems implementing MSA include support for vector register
> partitioning which makes it somewhat difficult to implement support for
> it in the kernel. Thus for the moment the kernel includes no such
> support. However if the kernel were to be run on a system which
> implemented register partitioning then it would not function correctly,
> mishandling MSA disabled exceptions. Calling panic when run on a system
> with vector register partitioning implemented ensures that we're not
> caught out by this later but instead reminded to implement support once
> such a system is available.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>   arch/mips/kernel/cpu-probe.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 852e085..003ba3c 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -1193,9 +1193,13 @@ void cpu_probe(void)
>   	else
>   		c->srsets = 1;
>
> -	if (cpu_has_msa)
> +	if (cpu_has_msa) {
>   		c->msa_id = cpu_get_msa_id();
>
> +		if (c->msa_id & MSA_IR_WRPF)
> +			panic("Vector register partitioning unimplemented!");

You should probably use a WARN_ON() instead.  There is no reason to 
crash the kernel for this condition is there?

> +	}
> +
>   	cpu_probe_vmbits(c);
>
>   #ifdef CONFIG_64BIT
>
