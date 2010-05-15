Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2010 04:44:03 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:46110 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490973Ab0EOCn7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 May 2010 04:43:59 +0200
Received: by pxi1 with SMTP id 1so1695130pxi.36
        for <multiple recipients>; Fri, 14 May 2010 19:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=P1t16NfSr3m9qVPNkge7u9xpADoUVVU9x+0qi5Ffb8M=;
        b=dfzRhi1bnK3Es9vRmxH6S7La4jOJBXi4gHqcN7TYl8HmIeGMV9vYrPNY0Ror2OFMZX
         x92Dvj+8pJSvtTZXZqwuIDxwYZAtiVKm88rLCxT4cFxdxahYb+9okM6ZHfg5Ud5Ssgyi
         bbTIbKmeUmWificEC3yT7m7KsVC6M/0WhK/2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=vuDs1pB+hugFZ/X10GSrgSDi35p7/7avDThtbUEsMc3+3ophsyX67hWTmHAf8oPp+s
         H6xX2Z0CItNebmC5B9mSjWmW6qxj9rqHkpFezvqP3evqOBvgh1A/12/dfC2TJRE8YVVj
         DWOps9ajH3wcnpUBi1uJq9a0FhJw2H3Q15yrg=
Received: by 10.115.36.31 with SMTP id o31mr1771489waj.171.1273891431654;
        Fri, 14 May 2010 19:43:51 -0700 (PDT)
Received: from [192.168.2.222] ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm25256445wam.17.2010.05.14.19.43.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 19:43:50 -0700 (PDT)
Subject: Re: [PATCH 7/9] tracing: MIPS: Reduce the overhead of dynamic
 Function Tracer
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     David Daney <david.s.daney@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <4BED8524.8010805@gmail.com>
References: <cover.1273834561.git.wuzhangjin@gmail.com>
         <6b4495690164114ff7353c86f6b53b979fca2756.1273834562.git.wuzhangjin@gmail.com>
         <4BED8524.8010805@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 15 May 2010 10:43:45 +0800
Message-ID: <1273891425.8552.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2010-05-14 at 10:15 -0700, David Daney wrote:
> On 05/14/2010 04:08 AM, Wu Zhangjin wrote:
> > From: Wu Zhangjin<wuzhangjin@gmail.com>
> >
> > With the help of uasm, this patch encodes the instructions of dynamic
> > Function Tracer in ftrace_dyn_arch_init() when initializing it.
> >
> [...]
> > +#include<asm/uasm.h>
> >
> 
> All of uasm is _cpuinit, I haven't checked everything, but are you sure 
> you aren't calling if from non-_cpuinit code?

The calling tree looks like this:

start_kernel()  // __init
  --> ftrace_init()  // __init
        --> ftrace_dyn_arch_init() // __init
              --> ftrace_dyn_arch_init_insns() // inline
	            --> uasm_*/UASM_*

Nobody else will call uasm_*/UASM_* in this patch, I have checked the
uasm usage in arch/mips/kernel/traps.c. Seems the usam functions are
also called in the __init *set_except_vector(). so, it will also be safe
in this patch, is it?

Thanks & Regards,
	Wu Zhangjin
