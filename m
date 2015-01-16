Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 16:33:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31687 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010095AbbAPPdfTPbhD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 16:33:35 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C0E9B423EDC08
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 15:33:25 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 15:33:28 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 16 Jan
 2015 15:33:27 +0000
Message-ID: <54B92F48.2070201@imgtec.com>
Date:   Fri, 16 Jan 2015 15:33:28 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <Paul.Burton@imgtec.com>
Subject: Re: [PATCH RFC v2 67/70] MIPS: kernel: process: Do not allow FR=0
 on MIPS R6
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-68-git-send-email-markos.chandras@imgtec.com> <6D39441BF12EF246A7ABCE6654B0235320FA8731@LEMAIL01.le.imgtec.org>
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320FA8731@LEMAIL01.le.imgtec.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 01/16/2015 11:54 AM, Matthew Fortune wrote:
> Markos Chandras <Markos.Chandras@imgtec.com> writes:
>> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
>> index b732c0ce2e56..41ebd5d0ac30 100644
>> --- a/arch/mips/kernel/process.c
>> +++ b/arch/mips/kernel/process.c
>> @@ -581,6 +581,10 @@ int mips_set_process_fp_mode(struct task_struct
>> *task, unsigned int value)
>>  	if ((value & PR_FP_MODE_FRE) && !cpu_has_fre)
>>  		return -EOPNOTSUPP;
> 
> There is an inconsistency here in that the kernel will not support
> emulating FRE mode when there is no FPU but will emulate FR1 or FR0
> when there is no FPU.
> 
> For consistency I think we should do this for FRE:
> 
>  	if ((value & PR_FP_MODE_FRE) && cpu_has_fpu && !cpu_has_fre)
>  		return -EOPNOTSUPP;
> 
Ok I will create a separate patch for this one.

-- 
markos
