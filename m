Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 09:54:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40225 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010416AbbAVIyL1bgfl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2015 09:54:11 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DCB8E5AAED00B;
        Thu, 22 Jan 2015 08:54:03 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 22 Jan 2015 08:54:05 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 22 Jan
 2015 08:54:05 +0000
Message-ID: <54C0BAAC.8020702@imgtec.com>
Date:   Thu, 22 Jan 2015 08:54:04 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>,
        David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: kernel: cps-vec: Replace "addi" with "addiu"
References: <1421854030-28929-1-git-send-email-markos.chandras@imgtec.com> <54BFE91F.7050906@gmail.com> <20150121180200.GC15278@NP-P-BURTON>
In-Reply-To: <20150121180200.GC15278@NP-P-BURTON>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45427
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

On 01/21/2015 06:02 PM, Paul Burton wrote:
> On Wed, Jan 21, 2015 at 09:59:59AM -0800, David Daney wrote:
>> On 01/21/2015 07:27 AM, Markos Chandras wrote:
>>> The "addi" instruction will trap on overflows which is not something
>>> we need in this code, so we replace that with "addiu".
>>>
>>> Link: http://www.linux-mips.org/archives/linux-mips/2015-01/msg00430.html
>>> Cc: Maciej W. Rozycki <macro@linux-mips.org>
>>> Cc: <stable@vger.kernel.org> # v3.15+
>>> Cc: Paul Burton <paul.burton@imgtec.com>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>
>> Acked-by: David Daney <david.daney@cavium.com>
>>
>> Same comment about the stable thing.  Is it needed for anything other than
>> follow-on MIPS r6 Patches?
> 
> In both this & the MSA asmmacro.h cases, the additions should never
> cause overflow. So I agree, backporting to stable seems like overkill.
> 
> Paul
> 

Maciej suggested to backport it to stable branches. I personally don't mind.


-- 
markos
