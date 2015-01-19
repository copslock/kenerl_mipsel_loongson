Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 13:45:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23987 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011795AbbASMp3Xk0sF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 13:45:29 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DE85183ACE44B;
        Mon, 19 Jan 2015 12:45:20 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 19 Jan 2015 12:45:23 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 19 Jan
 2015 12:45:21 +0000
Message-ID: <54BCFC61.4030000@imgtec.com>
Date:   Mon, 19 Jan 2015 12:45:21 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 05/70] MIPS: mm: uasm: Add signed 9-bit immediate
 related macros
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-6-git-send-email-markos.chandras@imgtec.com> <54B8F609.90509@cogentembedded.com> <54BCFA1F.8060101@imgtec.com>
In-Reply-To: <54BCFA1F.8060101@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45309
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

On 01/19/2015 12:35 PM, Markos Chandras wrote:
> On 01/16/2015 11:29 AM, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 1/16/2015 1:48 PM, Markos Chandras wrote:
>>
>>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>>> MIPS R6 redefines several instructions and reduces the immediate
>>> field to 9-bits so add related macros for the microassembler.
>>
>>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>>   arch/mips/mm/uasm.c | 13 ++++++++++++-
>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>>> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
>>> index 4adf30284813..6596b6898637 100644
>>> --- a/arch/mips/mm/uasm.c
>>> +++ b/arch/mips/mm/uasm.c
>> [...]
>>> @@ -41,6 +42,8 @@ enum fields {
>>>   #define FUNC_SH        0
>>>   #define SET_MASK    0x7
>>>   #define SET_SH        0
>>> +#define SIMM9_SH    7
>>> +#define SIMM9_MASK    0x1ff
>>>
>>>   enum opcode {
>>>       insn_invalid,
>>> @@ -116,6 +119,14 @@ static inline u32 build_scimm(u32 arg)
>>>       return (arg & SCIMM_MASK) << SCIMM_SH;
>>>   }
>>>
>>> +static inline u32 build_scimm9(s32 arg)
>>> +{
>>> +    WARN((arg > 0x1ff || arg < -0x200),
>>
>>    Not 0xFF and -0x100? The values above don't fit into 9 bits...
> 
> Hi,
> 
> I think 0x1ff and -0x200 fit into 9-bits. Why do you think they don't?
> 
I think you are right. I will fix that and the 40/70 patch as well.

-- 
markos
