Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 13:20:17 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.173]:15730 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022559AbXGSMUP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 13:20:15 +0100
Received: by ug-out-1314.google.com with SMTP id u2so418535uge
        for <linux-mips@linux-mips.org>; Thu, 19 Jul 2007 05:19:57 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=JV9WzANQ17RgOrcSMxYjiNtwZRtSEVsqlIAXNLrf8nEEpo2+g2hGuYscYn0pQtrttmzIYkAFVLCJUi/di9E04A9NnGy2zG1Q9CFO9COqkb88LqnqhMwzoMhNi8Ts9NSr39uQ1f6vyP0thEJVAKGv5ZybDOdOsF1LbxwYGjOD8CU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=eBQvo6Z2kjbKtJwKli+01RcqGK7EntPrm77M6A4WEYw/aA6DOHadxXjUV6fXIgv86ed3J6obWatKMaocfVWV8hBgYXPcAbnloGBhYmTHmnOL20Dk0m/Y2MFGLVDtl4NAJkQ/1c8ofinw/pGsBRu51eFPP+qS4RuCNCjZ5gA2pOg=
Received: by 10.86.62.3 with SMTP id k3mr1900971fga.1184847597876;
        Thu, 19 Jul 2007 05:19:57 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTPS id m1sm4313683fke.2007.07.19.05.19.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jul 2007 05:19:57 -0700 (PDT)
Message-ID: <469F56CF.2080409@innova-card.com>
Date:	Thu, 19 Jul 2007 14:19:27 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] User stack pointer randomisation
References: <469F0E5F.4050005@innova-card.com> <20070719111440.GA19916@linux-mips.org> <cda58cb80707190447m1cd9b37fye7d330b50331b199@mail.gmail.com> <20070719120130.GB16258@linux-mips.org>
In-Reply-To: <20070719120130.GB16258@linux-mips.org>
X-Enigmail-Version: 0.94.4.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Jul 19, 2007 at 01:47:19PM +0200, Franck Bui-Huu wrote:
> 
>> this is weird I would have defined them like this instead:
>>
>> #if (_MIPS_SIM == _MIPS_SIM_ABI32)
>> #define ALSZ 8
>> #elif (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
>> #define ALSZ 16
>> #endif
>>
>> #define ALMASK (~(ALSZ-1))
> 

> <asm/asm.h> which is fairly similar to it's userspace equivalent
> <sys/asm.h> contains definitions which are some sort of
> pseudo-standard in the MIPS world, including ALSZ and ALMASK. If I
> had choosen them I'd have set ALSZ to 8 rsp. 16, just like you ...
> Anyway, having similar macros makes porting of assembler code
> easier.  This also is why <asm/regdef.h> and <asm/fpregdef.h> are as
> they are.  RISC/os, IRIX, some of the BSD variants, even the
> non-Linux SDE variants for example for baremetal use a similar set
> of macros and headers.

Thanks for explanations.

That makes me think that we may have the same alignement issue in
include/asm-mips/ptrace.h header file:

	struct pt_regs {
	#ifdef CONFIG_32BIT
	        /* Pad bytes for argument save space on the stack. */
	        unsigned long pad0[6];
	#endif
	
	        /* Saved main processor registers. */
	        unsigned long regs[32];
	
	        /* Saved special registers. */
	        unsigned long cp0_status;
	        unsigned long hi;
	        unsigned long lo;
	#ifdef CONFIG_CPU_HAS_SMARTMIPS
	        unsigned long acx;
	#endif
	        unsigned long cp0_badvaddr;
	        unsigned long cp0_cause;
	        unsigned long cp0_epc;
	#ifdef CONFIG_MIPS_MT_SMTC
	        unsigned long cp0_tcstatus;
	#endif /* CONFIG_MIPS_MT_SMTC */
	} __attribute__ ((aligned (8)));

Note that the structure is aligned on a 8 bytes boundary which is not
correct for a 64 bit kernel, is it ?

Thanks
		Franck
