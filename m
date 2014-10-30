Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 18:17:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25007 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012259AbaJ3RRSCQjpb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 18:17:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4A20140321EA3;
        Thu, 30 Oct 2014 17:17:08 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 30 Oct
 2014 17:17:10 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 30 Oct 2014 17:17:10 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0195.001; Thu, 30 Oct 2014 17:17:10 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>
Subject: RE: [RFC PATCH v4] MIPS: fix build with binutils 2.24.51+
Thread-Topic: [RFC PATCH v4] MIPS: fix build with binutils 2.24.51+
Thread-Index: AQHP71OuH0A1wmf7OU2YCIumpQwto5w/Cfgw
Date:   Thu, 30 Oct 2014 17:17:10 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320F3856D@LEMAIL01.le.imgtec.org>
References: <1414132079-155342-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1414132079-155342-1-git-send-email-manuel.lauss@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.76]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Hi Manuel,

Sorry for taking a while to respond to you, from a toolchain perspective
I think this patch is looking good with one extra change as below. I'll
leave the kernel guys to comment further.

Manuel Lauss <manuel.lauss@gmail.com> writes:
> diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
> index 8352523..f21c046 100644
> --- a/arch/mips/kernel/r4k_fpu.S
> +++ b/arch/mips/kernel/r4k_fpu.S
> @@ -33,10 +34,14 @@
>  	.set	arch=r4000
> 
>  LEAF(_save_fp_context)
> +	.set	push
> +	SET_HARDFLOAT
>  	cfc1	t1, fcr31
> +	.set	pop
> 
>  #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
>  	.set	push
> +	SET_HARDFLOAT
>  #ifdef CONFIG_CPU_MIPS32_R2
>  	.set	mips64r2

I know you haven't modified the lines with .set mips64r2 on them but
they are not strictly correct.
Instead of mips64r2 (which is dangerous to put in 32-bit code for a
variety of reasons unless absolutely critical)... this should be:

.set mips32r2
.set fp=64

There should be no need to protect this change based on assembler version
as I believe .set fp=... support predates .set mips64r2. This change
protects the kernel source from failing to build depending on how future
toolchains are configured and it would be ideal to include in this patch
to keep all these tweaks in one place.

For the record the issue is that .set mips64r2 is getting used with the
O32 ABI which is OK albeit weird. Under some circumstances the use of
.set mips64r2 will result in implicitly setting fp=64 which is required
for the SDC1 instructions which follow, however it will not always set
fp=64. Markos has a set of tools which are configured such that .set
mips64r2 used with an O32 ABI will not switch to 64-bit FP registers
which is the reason he has seen a problem which you can't reproduce.

> @@ -150,6 +161,7 @@ LEAF(_restore_fp_context)
> 
>  #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
>  	.set	push
> +	SET_HARDFLOAT
>  #ifdef CONFIG_CPU_MIPS32_R2
>  	.set	mips64r2

Likewise.

Thanks,
Matthew
