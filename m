Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 13:59:05 +0100 (CET)
Received: from mail-la0-f48.google.com ([209.85.215.48]:52460 "EHLO
        mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010671AbbASM7DP5lzM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 13:59:03 +0100
Received: by mail-la0-f48.google.com with SMTP id gf13so28524081lab.7
        for <linux-mips@linux-mips.org>; Mon, 19 Jan 2015 04:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=LkBdkRIxH2h2c/GDJ35/7QQt8IYZry2RiT5AWu0tCvE=;
        b=XDHaF3ZL+PNrik5+kwOMi9w4Ic1l1yUlXCgxBC4dgw/Gvlrp6uKNmnPrtYFUrRtYUz
         0f3U16Qb8Uy9RFDQ2M2/ZIcdr8qL+Hc4h9tCrslEyXK+S1k8eqm9oi3BeQ1llzf7xOA4
         1jqczElB+hbY68URVDGsOrcO5QLDo4/V+CiOAWBs66uItpbQ1Uz4NlVrU9gq91bXpVyO
         Eepp17QP05Ozncd5qfzVM+YLS44hD7DnBPgrEJze0tFCpinusdgrshQKcWiu7IaNZ7Gy
         D6cCKx0EFcDAmkZtHgeCadfDegjkGkk1srBBt0zusAV3WCvTy2nHusDz4cMpN9YH64QE
         7Cbg==
X-Gm-Message-State: ALoCoQlckdSwgwY0MRPkS6tEARQH2Jw0iBNnw0CZLvPRoqwZ9dIpRycZ8B8WIkqQrgeSOsrodL48
X-Received: by 10.112.183.197 with SMTP id eo5mr12750937lbc.81.1421671854558;
        Mon, 19 Jan 2015 04:50:54 -0800 (PST)
Received: from [192.168.3.68] (ppp28-153.pppoe.mtu-net.ru. [81.195.28.153])
        by mx.google.com with ESMTPSA id xh7sm3058566lbb.17.2015.01.19.04.50.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2015 04:50:53 -0800 (PST)
Message-ID: <54BCFDAD.1050407@cogentembedded.com>
Date:   Mon, 19 Jan 2015 15:50:53 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        linux-mips@linux-mips.org
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 05/70] MIPS: mm: uasm: Add signed 9-bit immediate
 related macros
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-6-git-send-email-markos.chandras@imgtec.com> <54B8F609.90509@cogentembedded.com> <54BCFA1F.8060101@imgtec.com>
In-Reply-To: <54BCFA1F.8060101@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 1/19/2015 3:35 PM, Markos Chandras wrote:

>>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

>>> MIPS R6 redefines several instructions and reduces the immediate
>>> field to 9-bits so add related macros for the microassembler.

>>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>>    arch/mips/mm/uasm.c | 13 ++++++++++++-
>>>    1 file changed, 12 insertions(+), 1 deletion(-)

>>> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
>>> index 4adf30284813..6596b6898637 100644
>>> --- a/arch/mips/mm/uasm.c
>>> +++ b/arch/mips/mm/uasm.c
>> [...]
>>> @@ -41,6 +42,8 @@ enum fields {
>>>    #define FUNC_SH        0
>>>    #define SET_MASK    0x7
>>>    #define SET_SH        0
>>> +#define SIMM9_SH    7
>>> +#define SIMM9_MASK    0x1ff
>>>
>>>    enum opcode {
>>>        insn_invalid,
>>> @@ -116,6 +119,14 @@ static inline u32 build_scimm(u32 arg)
>>>        return (arg & SCIMM_MASK) << SCIMM_SH;
>>>    }
>>>
>>> +static inline u32 build_scimm9(s32 arg)
>>> +{
>>> +    WARN((arg > 0x1ff || arg < -0x200),

>>     Not 0xFF and -0x100? The values above don't fit into 9 bits...

> Hi,

> I think 0x1ff and -0x200 fit into 9-bits. Why do you think they don't?

    Because 0x1ff occupies 9 bits already and -0x200 (~0x200 + 1) occupies at 
least 10 bits. I thought that was pretty obvious...

WBR, Sergei
