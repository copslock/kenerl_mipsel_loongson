Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 15:07:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53341 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009498AbbGNNHnQSjDh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 15:07:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 01B77FFFB102D;
        Tue, 14 Jul 2015 14:07:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 14 Jul 2015 14:07:37 +0100
Received: from [192.168.154.48] (192.168.154.48) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 14 Jul
 2015 14:07:37 +0100
Subject: Re: [PATCH 6/7] MIPS: kernel: cps-vec: Use macros for various
 arithmetics and memory operations
To:     Paul Burton <paul.burton@imgtec.com>
References: <1435738414-30944-1-git-send-email-markos.chandras@imgtec.com>
 <1435738414-30944-7-git-send-email-markos.chandras@imgtec.com>
 <20150714124011.GH2519@NP-P-BURTON>
CC:     <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
Message-ID: <55A50998.4030308@imgtec.com>
Date:   Tue, 14 Jul 2015 14:07:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <20150714124011.GH2519@NP-P-BURTON>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48272
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

On 07/14/2015 01:40 PM, Paul Burton wrote:
>> @@ -152,7 +152,7 @@ dcache_done:
>>  
>>  	/* Enter the coherent domain */
>>  	li	t0, 0xff
>> -	sw	t0, GCR_CL_COHERENCE_OFS(v1)
>> +	PTR_S	t0, GCR_CL_COHERENCE_OFS(v1)
> 
> Hi Markos,
> 
> I don't believe this is correct where accessing GCRs. Since you've
> pushed elsewhere to perform 32 bit accesses when running a 32 bit kernel
> on a MIPS64 core with CM3, can we just keep doing 32 bit accesses here?
> 

Hi Paul,

Yes. This patch is already upstream though. I will wait for the
'mips_cm_is64' to make it upstream as well and then I will submit a fix
for this one. It should not break anything at the moment. Thanks

-- 
markos
