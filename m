Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:54:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6332 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006154AbbAPLyPAKQV6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 12:54:15 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2FF3BBE854290
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 11:54:07 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 11:54:09 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Fri, 16 Jan 2015 11:54:08 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <Paul.Burton@imgtec.com>
Subject: RE: [PATCH RFC v2 67/70] MIPS: kernel: process: Do not allow FR=0
 on MIPS R6
Thread-Topic: [PATCH RFC v2 67/70] MIPS: kernel: process: Do not allow FR=0
 on MIPS R6
Thread-Index: AQHQMXrAnE6Fp7/ZnUCeBO9xWdbvQZzCorHQ
Date:   Fri, 16 Jan 2015 11:54:08 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320FA8731@LEMAIL01.le.imgtec.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
 <1421405389-15512-68-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1421405389-15512-68-git-send-email-markos.chandras@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.116]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45217
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

Markos Chandras <Markos.Chandras@imgtec.com> writes:
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index b732c0ce2e56..41ebd5d0ac30 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -581,6 +581,10 @@ int mips_set_process_fp_mode(struct task_struct
> *task, unsigned int value)
>  	if ((value & PR_FP_MODE_FRE) && !cpu_has_fre)
>  		return -EOPNOTSUPP;

There is an inconsistency here in that the kernel will not support
emulating FRE mode when there is no FPU but will emulate FR1 or FR0
when there is no FPU.

For consistency I think we should do this for FRE:

 	if ((value & PR_FP_MODE_FRE) && cpu_has_fpu && !cpu_has_fre)
 		return -EOPNOTSUPP;

thanks,
Matthew

> 
> +	/* FR = 0 not supported in MIPS R6 */
> +	if (!(value & PR_FP_MODE_FR) && cpu_has_fpu && cpu_has_mips_r6)
> +		return -EOPNOTSUPP;
> +
>  	/* Save FP & vector context, then disable FPU & MSA */
>  	if (task->signal == current->signal)
>  		lose_fpu(1);
> --
> 2.2.1
