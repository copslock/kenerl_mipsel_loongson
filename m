Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2014 12:18:37 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:50825 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817913AbaDKKSfLx9ki (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Apr 2014 12:18:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9B7CEBDB28824;
        Fri, 11 Apr 2014 11:18:26 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 11 Apr 2014 11:18:28 +0100
Received: from [192.168.154.67] (192.168.154.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 11 Apr
 2014 11:18:27 +0100
Message-ID: <5347C173.30902@imgtec.com>
Date:   Fri, 11 Apr 2014 11:18:27 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Richard Guy Briggs <rgb@redhat.com>, Eric Paris <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, Paul Burton <paul.burton@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: use current instead of task in syscall_get_arch
References: <1397183132-16528-1-git-send-email-eparis@redhat.com> <20140411024334.GD24821@madcap2.tricolour.ca>
In-Reply-To: <20140411024334.GD24821@madcap2.tricolour.ca>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39775
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

On 04/11/2014 03:43 AM, Richard Guy Briggs wrote:
> On 14/04/10, Eric Paris wrote:
>> In commit 6e345746 Markos started using task to determine 64bit vs
>> 32bit instead of it being completely CONFIG based.
>>
>> In commit 5e937a9a we dropped the 'task' argument to syscall_get_arch()
>> across the entire system.
>>
>> This obviously results in a build failure when Linus's and the audit
>> tree were merged.  This patch should be applied as part of the merge
>> conflict, as both sides of the merge are correct and the failure happens
>> AT the merge.
>>
>> The fix is simple.  The task is always current.  Use current.
>>
>> Signed-off-by: Eric Paris <eparis@redhat.com>
>> Cc: markos.chandras@imgtec.com
>> Cc: Paul Burton <paul.burton@imgtec.com>
>> Cc: James Hogan <james.hogan@imgtec.com>
>> Cc: linux-mips@linux-mips.org
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Looks good to me. Thanks for taking care of that.

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos
