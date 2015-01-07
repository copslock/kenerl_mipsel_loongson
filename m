Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 18:21:39 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:44748 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010732AbbAGRVhnPlcj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 18:21:37 +0100
Received: by mail-lb0-f182.google.com with SMTP id u10so1396081lbd.41
        for <linux-mips@linux-mips.org>; Wed, 07 Jan 2015 09:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=FzTXbXhrwJSiciA/H+5Uset/z/HN9jJjSHe48F5dKAU=;
        b=Wue+85XuZ9zjzc/J/I2+6bx/96YfJkNP2d2wJTmZUKwcNZplJ6rdaxVF1DzuRxobEF
         LlXg/fS0t3Kg/mvXGKKmyQ9UbdCQ4b3Mq+i14xKIdGdWsZm7Q5lkpaJ3Xmsm8Zbljnuq
         R39ymRMcvFNhH8k6g+79JIw60b3wnm90pMnYL//WPwUSTx0zSZNTXDJAXcUAPFTWYvv0
         iNffH6WLM/uJZxwzH72IChbegqUmiHsLodce3W8MxmCSQehQk6Lch7AdSAr2ITArHIbV
         oAvG+Pe2UAXDlVMF2eSjmwkU7u47cMnm2plu/2ZFt9UOez92bQN6yBjuPmdyY+WSnqiX
         7kCA==
X-Gm-Message-State: ALoCoQlLF/3f4m9+45rTnDAiBNdIvCu+ZQU25SELKSDI0+BP51z79wwYqpfcRfnKoOAZdby4aXFd
X-Received: by 10.112.30.71 with SMTP id q7mr6491180lbh.41.1420651292330;
        Wed, 07 Jan 2015 09:21:32 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp83-237-253-86.pppoe.mtu-net.ru. [83.237.253.86])
        by mx.google.com with ESMTPSA id ba19sm573868lab.23.2015.01.07.09.21.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2015 09:21:31 -0800 (PST)
Message-ID: <54AD6B19.3020007@cogentembedded.com>
Date:   Wed, 07 Jan 2015 20:21:29 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>, linux-mips@linux-mips.org
CC:     ralf@linux-mips.org
Subject: Re: [PATCH 13/17] MIPS: Netlogic: Handle XLP hardware errata
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com> <1420630118-17198-14-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1420630118-17198-14-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45007
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

On 01/07/2015 02:28 PM, Jayachandran C wrote:

> Core configuration register IFU_BRUB_RESERVE has to be setup to handle
> a silicon errata which can result in a CPU hang.

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>

[...]

> diff --git a/arch/mips/netlogic/common/reset.S b/arch/mips/netlogic/common/reset.S
> index 701c4bc..ff2673a 100644
> --- a/arch/mips/netlogic/common/reset.S
> +++ b/arch/mips/netlogic/common/reset.S
> @@ -235,6 +235,24 @@ EXPORT(nlm_boot_siblings)
>   	mfc0	v0, CP0_EBASE, 1
>   	andi	v0, 0x3ff		/* v0 <- node/core */
>
> +	/* Errata: to avoid potential live lock, only apply to 4
> +	 * thread per core mode */

    The preferred multi-line comment style is:

/*
  * bla
  * bla
  */

> +	andi	v1, v0, 0x3             /* v1 <- thread id */
> +	bnez	v1, 2f
> +	nop

    If this 'nop' is in a delay slot, there's a tradition to add extra space 
before the instruction.

> +
> +	/* thread 0 of each core. */
> +	li	t0, CKSEG1ADDR(RESET_DATA_PHYS)

    Hm, does this get auto-expanded into several instructions?

> +	lw	t1, BOOT_THREAD_MODE(t0)        /* t1 <- thread mode */
> +	subu	t1, 0x3				/* 4-thread per core mode? */
> +	bnez	t1, 2f
> +	nop

    Same here...

WBR, Sergei
