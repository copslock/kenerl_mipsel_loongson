Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 01:33:27 +0200 (CEST)
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35095 "EHLO
        mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025243AbbDCXdZPk6uv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 01:33:25 +0200
Received: by lbdc10 with SMTP id c10so86234977lbd.2
        for <linux-mips@linux-mips.org>; Fri, 03 Apr 2015 16:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aD+I6oXBRnHPXNwbzU5Mwq1av1U7nqK0oJhyEdqb5EE=;
        b=dFrXqrSiq/pfpAfnRytSN/SAzjeYHsEtJlZjKz9VrJ1zDe07sLpZFMubRTzDybtc83
         pPEJJY5h+rATPYyp7SQJcKGKx3k3vA6+NacTnyHrArqo8odsZz8Ey1vc+UwfML4Ze6Z1
         Jqhbp2IF0dweGE1p1PzssT7yHVW/ovGT27ogLpAocGhVZ7b4u6/1cIFIqKAdDUM91cBS
         owdF+npUhSqq7a2FiN3ldLU1HiWQhpOHXUvlEs04Mv3L8lmw6rZACXATLypnjzBglWy4
         HY12wJfAM9IUTlgUxaeOrDvegx0upt83ha38RNfdz0VrtB4L3YA3UV4+V0vWcTMURmnA
         Q91A==
X-Gm-Message-State: ALoCoQk2Yrlx/8LWnt+m/1G1pJ/icqTZ2F0wYTEyZ7Qb2u2+BoPLmPNF/mWqM5mqo8cl19quiwi6
X-Received: by 10.112.17.68 with SMTP id m4mr3988247lbd.50.1428104000779;
        Fri, 03 Apr 2015 16:33:20 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp24-62.pppoe.mtu-net.ru. [81.195.24.62])
        by mx.google.com with ESMTPSA id nj1sm1845862lbc.0.2015.04.03.16.33.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 16:33:19 -0700 (PDT)
Message-ID: <551F233E.4040602@cogentembedded.com>
Date:   Sat, 04 Apr 2015 02:33:18 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 18/48] MIPS: math-emu: Factor out CFC1/CTC1 emulation
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org> <alpine.LFD.2.11.1504030318150.21028@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1504030318150.21028@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46770
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

On 04/04/2015 01:25 AM, Maciej W. Rozycki wrote:

> Move CFC1/CTC1 emulation code to separate functions to avoid excessive
> indentation in forthcoming changes.  Adjust formatting in a minor way
> and remove extraneous round brackets.

> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> linux-mips-emu-cxc.diff
> Index: linux/arch/mips/math-emu/cp1emu.c
> ===================================================================
> --- linux.orig/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:54.099185000 +0100
> +++ linux/arch/mips/math-emu/cp1emu.c	2015-04-02 20:27:54.459192000 +0100
> @@ -840,6 +840,52 @@ do {									\
>   #define DPTOREG(dp, x)	DITOREG((dp).bits, x)
>
>   /*
> + * Emulate a CFC1 instruction.
> + */
> +static inline void cop1_cfc(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
> +			    mips_instruction ir)
> +{
> +	u32 value;
> +
> +	if (MIPSInst_RD(ir) == FPCREG_CSR) {
> +		value = ctx->fcr31;
> +		pr_debug("%p gpr[%d]<-csr=%08x\n",
> +			 (void *)xcp->cp0_epc,
> +			 MIPSInst_RT(ir), value);
> +	} else if (MIPSInst_RD(ir) == FPCREG_RID)
> +		value = 0;
> +	else
> +		value = 0;

    CodingStyle: all arms of the *if* statement shouyld have {} if at leats 
one has them.

> +	if (MIPSInst_RT(ir))
> +		xcp->regs[MIPSInst_RT(ir)] = value;
> +}
> +
> +/*
> + * Emulate a CTC1 instruction.
> + */
> +static inline void cop1_ctc(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
> +			    mips_instruction ir)
> +{
> +	u32 value;
> +
> +	if (MIPSInst_RT(ir) == 0)
> +		value = 0;
> +	else
> +		value = xcp->regs[MIPSInst_RT(ir)];
> +
> +	/* we only have one writable control reg
> +	 */

    This comment would fit on a single line.

[...]

WBR, Sergei
