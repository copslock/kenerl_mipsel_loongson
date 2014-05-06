Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2014 09:47:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:19324 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6817913AbaEFHrtpdvsh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 May 2014 09:47:49 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C14F149AE1DE
        for <linux-mips@linux-mips.org>; Tue,  6 May 2014 08:47:40 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 6 May
 2014 08:47:42 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 6 May 2014 08:47:42 +0100
Received: from [192.168.154.35] (192.168.154.35) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 6 May
 2014 08:47:41 +0100
Message-ID: <5368939D.9030801@imgtec.com>
Date:   Tue, 6 May 2014 08:47:41 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3.15] MIPS: Add new AUDIT_ARCH token for the N32 ABI on
 MIPS64
References: <1397550996-14805-1-git-send-email-markos.chandras@imgtec.com> <1398177636-10442-1-git-send-email-markos.chandras@imgtec.com> <2110472.rttbk0K4Ne@sifl> <5360C13A.5040902@imgtec.com>
In-Reply-To: <5360C13A.5040902@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.35]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40021
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

On 04/30/2014 10:24 AM, Markos Chandras wrote:
> On 04/24/2014 08:19 PM, Paul Moore wrote:
>> On Tuesday, April 22, 2014 03:40:36 PM Markos Chandras wrote:
>>> A MIPS64 kernel may support ELF files for all 3 MIPS ABIs
>>> (O32, N32, N64). Furthermore, the AUDIT_ARCH_MIPS{,EL}64 token
>>> does not provide enough information about the ABI for the 64-bit
>>> process. As a result of which, userland needs to use complex
>>> seccomp filters to decide whether a syscall belongs to the o32 or n32
>>> or n64 ABI. Therefore, a new arch token for MIPS64/n32 is added so it
>>> can be used by seccomp to explicitely set syscall filters for this ABI.
>>>
>>> Link: http://sourceforge.net/p/libseccomp/mailman/message/32239040/
>>> Cc: Andy Lutomirski <luto@amacapital.net>
>>> Cc: Eric Paris <eparis@redhat.com>
>>> Cc: Paul Moore <pmoore@redhat.com>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>> Ralf, can we please have this in 3.15 (Assuming it's ACK'd)?
>>>
>>> Thanks a lot!
>>> ---
>>>  arch/mips/include/asm/syscall.h |  2 ++
>>>  include/uapi/linux/audit.h      | 12 ++++++++++++
>>>  2 files changed, 14 insertions(+)
>>
>> I'm far from qualified to ACK any MIPS specific patches, but I do want to add 
>> my support for this patch.  As Markos states above, without this patch any 
>> seccomp BPF code will be more complex than necessary (see x32 for an idea) and 
>> projects that try to abstract away the arch/ABI specific nature of the BPF 
>> seccomp filters will be have to do a lot more work.  Please merge this patch, 
>> or something similar, along with the MIPS BPF seccomp filters in 3.15; waiting 
>> until 3.16 will be too late.
>>
>> I also don't want to speak for the audit folks (Eric?), but I think you'll 
>> hear that this patch makes life much easier for them as well.
>>
>> Thanks,
>> -Paul
> 
> Ralf ping? Can we please have this in 3.15 so userspace application get
> the updated token instead of using the AUDIT_ARCH_MIPS{,EL}64 for both
> n32 and n64? It may be harder to change it once 3.15 is released (ABI
> break).
> 

Ralf ping again? With -r5 approaching, there might be limited time left
to push this.

-- 
markos
