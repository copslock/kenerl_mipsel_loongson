Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 20:10:46 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:61074 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816199AbaDGSKpM9Ry8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 20:10:45 +0200
Received: by mail-ie0-f172.google.com with SMTP id as1so6593177iec.31
        for <linux-mips@linux-mips.org>; Mon, 07 Apr 2014 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TRIwjzHLo8cDBNdbM52o/ePABAl24r2JgKGcZEjoU7Y=;
        b=wSC6/W6wLiPqVCVGhrjMpbJgzCazcsbmuqgEMCA+0ycd4r+2bWzTfO3aGxBmGXt13m
         nd/rwxCwUpjjnISirkGbHSnOpuhnILoTaFwyoa39AYRyM++9A9IwxTr013aUTYt3VA/w
         vygEORZ3ds4Uro7gSZI3R2wgvid6IU2H3QNHc4ur42OwuAqwNul2Z/hsgmSTS15J1MNt
         3AtAe35zP7teoiYG1D81+lWp0tdU7lusgV4Pg+LbhFQKCI2rAvggnRX/p+ti3phyMuuw
         w8RDBlot0PRf1yqPH78vXX/q13StBq7JI/hQ9cdWJosWRAakvuj7IlZFJkjHos43eyXf
         Cuxw==
X-Received: by 10.50.43.170 with SMTP id x10mr21724149igl.20.1396894238666;
        Mon, 07 Apr 2014 11:10:38 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id jy4sm31286562igb.17.2014.04.07.11.10.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 07 Apr 2014 11:10:38 -0700 (PDT)
Message-ID: <5342EA1C.3010605@gmail.com>
Date:   Mon, 07 Apr 2014 11:10:36 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH v5 2/2] MIPS: optional floating point support
References: <1396893214-298664-1-git-send-email-manuel.lauss@gmail.com> <1396893214-298664-2-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1396893214-298664-2-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39689
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

On 04/07/2014 10:53 AM, Manuel Lauss wrote:
[...]
> +#else	/* no CONFIG_MIPS_FPU_SUPPORT */
> +static inline int do_dsemulret(struct pt_regs *xcp)
> +{
> +	return 0;	/* 0 means error, should never get here anyway */
> +}
> +
> +static inline int fpu_emulator_cop1Handler(struct pt_regs *xcp,
> +				struct mips_fpu_struct *ctx, int has_fpu,
> +				void *__user *fault_addr)
> +{
> +	return SIGILL;	/* we don't speak MIPS FPU */

In a message in the other branch, Ralf suggested emitting very ugly 
messages in the case that something tries to use the FPU.

This code doesn't quite satisfy that request.


> +}
> +#endif	/* CONFIG_MIPS_FPU_SUPPORT */
> +
>   int process_fpemu_return(int sig, void __user *fault_addr);
>
>   /*
>
