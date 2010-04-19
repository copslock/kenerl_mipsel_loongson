Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Apr 2010 11:37:04 +0200 (CEST)
Received: from [74.125.83.177] ([74.125.83.177]:61895 "EHLO
        mail-pv0-f177.google.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491152Ab0DSJg5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Apr 2010 11:36:57 +0200
Received: by pvc30 with SMTP id 30so2933971pvc.36
        for <multiple recipients>; Mon, 19 Apr 2010 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=1EsG24hSXypweamtSNrpI8xu8WF8EFzuzl9yZiN1B+w=;
        b=Nwi+qgSEYEXJX67Yp7qbY+nb6lDNh9zDebl5ycCQYUPLk4fOSkFBiimg1Kh2vyg4zu
         SttefsANpf9klP0CKUZFD6KZu3xFVS3LNWUlHXo8MsIoVyHIbUHEyguVZNkahP3URkm3
         2XfLFiU5tD6bqm9YFzgNU2ezK1Devbd2C8TrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=tJ05P+aIRE/mFJ+XQBCVsnv2b1N7UHQxMxlVVT1jrvVq4FwbyT1RvEoLLPY2pNdlKm
         mWnayPXFgr5cZqDP5r8WJTWfvLDSi3Q7RfI/mdbzNHv6hNCc0dlNSBPYw3ycObWdQ3VS
         yQP1BK+ky9bXUs480x51FEl7oEXLKzo24/bW4=
Received: by 10.141.107.19 with SMTP id j19mr3776218rvm.90.1271669775037;
        Mon, 19 Apr 2010 02:36:15 -0700 (PDT)
Received: from [192.168.2.243] ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm5363134pzk.3.2010.04.19.02.36.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 02:36:13 -0700 (PDT)
Subject: Re: [PATCH -v5] MIPS: tracing: Optimize the implementation
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1271537514-19584-1-git-send-email-wuzhangjin@gmail.com>
References: <1271537514-19584-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 19 Apr 2010 17:36:08 +0800
Message-ID: <1271669768.25163.2.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2010-04-18 at 04:51 +0800, Wu Zhangjin wrote:
[...]
> diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
[...]
>  
> @@ -45,8 +46,6 @@
>  	PTR_L	a5, PT_R9(sp)
>  	PTR_L	a6, PT_R10(sp)
>  	PTR_L	a7, PT_R11(sp)
> -#endif
> -#ifdef CONFIG_64BIT
>  	PTR_ADDIU	sp, PT_SIZE
>  #else
>  	PTR_ADDIU	sp, (PT_SIZE + 8)
> @@ -71,7 +70,7 @@ _mcount:
>  
>  	MCOUNT_SAVE_REGS
>  #ifdef KBUILD_MCOUNT_RA_ADDRESS
> -	PTR_S	t0, PT_R12(sp)	/* t0 saved the location of the return address(at) by -mmcount-ra-address */
> +	PTR_S	$12, PT_R12(sp)	/* $12 saved the location of the return address(at) */
>  #endif
>  
>  	move	a0, ra		/* arg1: next ip, selfaddr */
> @@ -137,25 +136,22 @@ NESTED(ftrace_graph_caller, PT_SIZE, ra)
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  	PTR_L	a1, PT_R31(sp)	/* load the original ra from the stack */
>  #ifdef KBUILD_MCOUNT_RA_ADDRESS
> -	PTR_L	t0, PT_R12(sp)	/* load the original t0 from the stack */
> +	PTR_L	a0, PT_R12(sp)	/* arg1: the location of the return address */
>  #endif
> -#else
> +#else /* ! CONFIG_DYNAMIC_FTRACE */
>  	MCOUNT_SAVE_REGS
>  	move	a1, ra		/* arg2: next ip, selfaddr */
>  #endif
>  
>  #ifdef KBUILD_MCOUNT_RA_ADDRESS
> -	bnez	t0, 1f		/* non-leaf func: t0 saved the location of the return address */
> +	bnez	a0, 1f		/* non-leaf func: get the location of the return address from saved $12 */
>  	 nop
> -	PTR_LA	t0, PT_R1(sp)	/* leaf func: get the location of at(old ra) from our own stack */
> -1:	move	a0, t0		/* arg1: the location of the return address */
> -#else
> -	PTR_LA	a0, PT_R1(sp)	/* arg1: &AT -> a0 */
>  #endif
> -	jal	prepare_ftrace_return

The above change has broken the static function graph tracer with
-mmcount-ra-address for it did not consider the argument 1 for static
function graph tracer, a new revision of this patch will be sent out as
"MIPS: tracing: adds misc cleanups and fixups".

Regards,
	Wu Zhangjin
