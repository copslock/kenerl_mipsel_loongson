Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2010 16:03:53 +0100 (CET)
Received: from mail-px0-f189.google.com ([209.85.216.189]:45353 "EHLO
        mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492707Ab0CLPDt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Mar 2010 16:03:49 +0100
Received: by pxi27 with SMTP id 27so1265400pxi.0
        for <multiple recipients>; Fri, 12 Mar 2010 07:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=7DRRm1y41sEgGyKsYWpW4b4Cv34B6XM69lXsKM6TCpQ=;
        b=PXxmf9m82nf8ijFsHmjQ6E9cDa7hkUsn/+YcLNLkZYOAzl+RMsx3zqWFFnz7x7MWMA
         LPZ5bBZxe7NxBy3oW4i1ye8S2wESZszI15FjM7cvo8xMtISJ3MB0AZ808ssjZMaEmTeO
         ZuoVHRBRLzHsptBmNZ7nEmT/WRTt0tsivYnaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=xUboVqciTDBBzi7Bt7p+KzOuLOke5DSTxBng1r6YE0AtQYdX/znRvkdZ1lctEuSIRz
         TT73IFrICsafvoasESvsUvIjvbEHiQEurJs/jYnSdAzYNUnoPi7yplgGz+US5VxtIAeV
         bWJF+1RF3AG4iUEMZTL3kufBDa4U5SCJGa/Ec=
Received: by 10.143.84.6 with SMTP id m6mr2656435wfl.162.1268406222422;
        Fri, 12 Mar 2010 07:03:42 -0800 (PST)
Received: from [202.201.12.142] ([202.201.12.142])
        by mx.google.com with ESMTPS id 23sm1415526pzk.2.2010.03.12.07.03.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 07:03:41 -0800 (PST)
Subject: Re: [PATCH] MIPS: tracing: Optimize the implementation
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
In-Reply-To: <1268394209.6447.94.camel@falcon>
References: <8b93c417fefa4d446f801abfd718ba94fdcb1821.1268330348.git.wuzhangjin@gmail.com>
         <4B993B32.7000006@caviumnetworks.com>  <1268394209.6447.94.camel@falcon>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 12 Mar 2010 22:57:08 +0800
Message-ID: <1268405828.9527.3.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2010-03-12 at 19:43 +0800, Wu Zhangjin wrote:
[...]
> Right, then, we can search the JAL or JALR, for kernel, will get it
> immediatly, for module, will only several instructions, we can do this
> searching in ftrace_make_nop and ftrace_make_call at run-time, but just
> found we can use the following function to do it in ftrace_init(), looks
> good.
> 
> static inline int is_call_mcount(unsigned int insn)
> {
> 	return ((insn & JAL) == JAL) || (insn == JALR_V1);
> }
> 
> static inline unsinged long mcount_callsite(unsigned long addr)
> {
> 	unsigned int insn;
> 
> 	insn = *(unsigned int *)addr; /*need safe_load_code*/
> 	if (is_call_mcount(insn))
> 		return addr;
> 
> 	do {
> 		addr += 4;	/* what about big endian? */
> 		insn = *(unsigned int *)addr; /*need safe_load_code*/
> 	} while (!is_call_mcount(insn));
> 

This is not possible for modules, for currently, the modules are not
loaded yet.

Regards,
	Wu Zhangjin
