Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2013 10:40:22 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:52257 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817505Ab3KLJkK7BRsH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Nov 2013 10:40:10 +0100
Message-ID: <5281F778.2050004@imgtec.com>
Date:   Tue, 12 Nov 2013 09:40:08 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH 4/6] MIPS: mm: Use the TLBINVF instruction to flush the
 VTLB
References: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com> <1383844120-29601-5-git-send-email-markos.chandras@imgtec.com> <528139B1.9010909@gmail.com>
In-Reply-To: <528139B1.9010909@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_12_09_40_04
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38503
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

On 11/11/2013 08:10 PM, David Daney wrote:
> On 11/07/2013 09:08 AM, Markos Chandras wrote:
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>> The TLBINVF instruction can be used to flush the entire VTLB.
>> This eliminates the need for the TLBWI loop and improves performance.
>>
>> Reviewed-by: Paul Burton <paul.burton@imgtec.com>
>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>
>
> This should be split into two patches.  One for each file.
>
> Also...

Hi David,

But it is a single functional change. I believe it makes sense
to have it in a single commit.

-- 
markos
