Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2015 13:55:01 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49606 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009610AbbAHMy7rxOU1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jan 2015 13:54:59 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A091D265BCA8
        for <linux-mips@linux-mips.org>; Thu,  8 Jan 2015 12:54:49 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 8 Jan 2015 12:54:52 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Thu, 8 Jan 2015 12:54:51 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Paul Burton <Paul.Burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>
Subject: RE: [PATCH] MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS
Thread-Topic: [PATCH] MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for
 MIPS
Thread-Index: AQHQKz0aVg8DXyTJm0m129S1G97fJpy2JRwA
Date:   Thu, 8 Jan 2015 12:54:50 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320F99E61@LEMAIL01.le.imgtec.org>
References: <1420719457-690-1-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1420719457-690-1-git-send-email-paul.burton@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.151]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45012
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

> +	/* Avoid inadvertently triggering emulation */
> +	if ((value & PR_FP_MODE_FR) && cpu_has_fpu &&
> +	    !(current_cpu_data.fpu_id & MIPS_FPIR_F64))
> +		return -EOPNOTSUPP;
> +	if ((value & PR_FP_MODE_FRE) && !cpu_has_fre)
> +		return -EOPNOTSUPP;

This is perhaps not important immediately but these two cases can
be seen as inconsistent. I.e. FR1 is emulated if there is no FPU
but FRE is not emulated if there is no FPU.

I believe this would be more consistent:

	if ((value & PR_FP_MODE_FRE) && cpu_has_fpu &&
	    !cpu_has_fre)
		return -EOPNOTSUPP;

The kernel then freely emulates any requested mode when there is
no FPU but sticks to only true hardware modes when there is an FPU.

= More detailed discussion =

There has been debate internally at IMG over the issue of FPU emulation
so I think it is appropriate to comment on why emulation is not always
desirable according to the new o32 FP ABI extensions. I'll try to be
brief...

The simple reason is that it is obviously better to use a true hardware
FPU mode whenever possible. Most of the o32 hard-float ABI variants
can execute in multiple hardware modes and the glibc dynamic linker
will probe to find the best supported hardware mode by trying them:

https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/mips/dl-machine-reject-phdr.h;h=b277450c4d02088acb8f24c74cea6ce04783688f;hb=0bd956720c457ff054325b48f26ac7c91cb060e8#l286

If an FPU exists but an emulated mode is used rather than a
true hardware mode then the code will run slower than necessary.

The second aspect to avoiding emulated modes is that users may
have multiple versions of an object available each with different
ABI extensions. If one fails to load then the next one may succeed
with a true hardware-supported mode.

With all that in mind I suspect we can find a balance (in a later
update) that may be able to balance the desire for emulation against
the desire for using real hardware modes. As it stands there is no
clear-cut answer or spec for this so I am in agreement with the
overall behaviour of this patch, perhaps with the tweak applied.

thanks,
Matthew
