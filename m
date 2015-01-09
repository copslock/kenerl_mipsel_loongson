Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2015 00:29:27 +0100 (CET)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35934 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008709AbbAIX3ZEFh3Z convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Jan 2015 00:29:25 +0100
Received: by mail-ig0-f181.google.com with SMTP id a13so4273507igq.2
        for <linux-mips@linux-mips.org>; Fri, 09 Jan 2015 15:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=converseincode.com; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wWC329Lrg30ZqcrS2BJ/N6PXTBRtpN47JY4k88EiRwI=;
        b=hhttEv9uLJPaP19p/r1So1lc3aihKRj80p+DnUYDvuEEBqFSIUrffMdnn6/cERxfJa
         08yM6/KrEdjq0hkkEuDacMjcDG4o45y1WTgmDqcH3Qr4oHbxvJ3PmOPH1nZqHYe+5WV9
         +NQMUtVEgGxrlNbGTFICmf+acj6qURHREeZJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wWC329Lrg30ZqcrS2BJ/N6PXTBRtpN47JY4k88EiRwI=;
        b=BhpMNEN9RKDIm8sW/I8yEkFlJlRp9HBBGttERD1DRlCEqnDHNIiqmZLzonvPnibTWG
         6uqNSl8w6W5VsydZc2R3OeoSfODL5cbXqSsIeJsStw84YrME/LX7AA0l+ZKu8R6a8Cjt
         IvDd6yGbz4soiWH8uIuUYdB/EXlZluezlKFTbiSsFdndB047UXRBytILSTpL+QIqmhpH
         2iTMaPAvH17qCPn0oju5BJZ2Qttu9gYMuwLgAzR8CU0twzHeMigSX5aYp+QyJPUsJwH9
         /fsA7/jVEEJKy5GuZQwtGQ25zWxvUdy2qtef9D1oElV2SFMoyK94q0FSCzvw6ErPoRLu
         HAgA==
X-Gm-Message-State: ALoCoQmECjo07Hv2O6kpVdnr6Vwd7Czp6hmTBtYvHLespw4rZVk83ypOvFX/WgXbFPSd++NzsXmG
X-Received: by 10.50.35.195 with SMTP id k3mr5136928igj.11.1420846158661;
        Fri, 09 Jan 2015 15:29:18 -0800 (PST)
Received: from ?IPv6:2001:470:b26c:0:850:8ed7:4632:1f86? ([2001:470:b26c:0:850:8ed7:4632:1f86])
        by mx.google.com with ESMTPSA id a126sm4520303ioa.13.2015.01.09.15.29.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2015 15:29:17 -0800 (PST)
Message-ID: <54B0644A.5070403@converseincode.com>
Date:   Fri, 09 Jan 2015 15:29:14 -0800
From:   Behan Webster <behanw@converseincode.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Daniel Sanders <Daniel.Sanders@imgtec.com>,
        David Daney <ddaney.cavm@gmail.com>
CC:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>
Subject: Re: [PATCH] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
References: <1420805177-9087-1-git-send-email-daniel.sanders@imgtec.com> <54AFC6F3.1020300@cogentembedded.com> <E484D272A3A61B4880CDF2E712E9279F458E68B8@hhmail02.hh.imgtec.org> <54B00F3C.8030903@gmail.com> <E484D272A3A61B4880CDF2E712E9279F458E7DF1@hhmail02.hh.imgtec.org>
In-Reply-To: <E484D272A3A61B4880CDF2E712E9279F458E7DF1@hhmail02.hh.imgtec.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-Path: <behanw@converseincode.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: behanw@converseincode.com
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

On 01/09/15 12:06, Daniel Sanders wrote:
>> -----Original Message-----
>> From: David Daney [mailto:ddaney.cavm@gmail.com]
>> Sent: 09 January 2015 17:26
>> To: Daniel Sanders
>> Cc: Sergei Shtylyov; linux-mips@linux-mips.org; Ralf Baechle; Paul Burton;
>> Markos Chandras; James Hogan; Behan Webster
>> Subject: Re: [PATCH] MIPS: Changed current_thread_info() to an equivalent
>> supported by both clang and GCC
>>
>> On 01/09/2015 05:23 AM, Daniel Sanders wrote:
>>> Hi,
>>>
>>> Thanks for the quick reply.
>>>
>>>> -----Original Message-----
>>>> From: Sergei Shtylyov [mailto:sergei.shtylyov@cogentembedded.com]
>>>> Sent: 09 January 2015 12:18
>>>> To: Daniel Sanders; linux-mips@linux-mips.org; Ralf Baechle
>>>> Cc: Paul Burton; Markos Chandras; James Hogan; Behan Webster
>>>> Subject: Re: [PATCH] MIPS: Changed current_thread_info() to an equivalent
>>>> supported by both clang and GCC
>>>>
>>>> Hello.
>>>>
>>>> On 1/9/2015 3:06 PM, Daniel Sanders wrote:
>>>>
>>>>> Without this, a 'break' instruction is executed very early in the boot and
>>>>> the boot hangs.
>>>>> The problem is that clang doesn't honour named registers on local
>> variables
>>>>> and silently treats them as normal uninitialized variables. However, it
>>>>> does honour them on global variables.
>> Why not fix clang instead?
> There's some significant implementation difficulties in LLVM that appear to stem from it not being designed to accommodate this extension. There were also some objections based on the future direction of LLVM. The thread can be found at http://lists.cs.uiuc.edu/pipermail/llvmdev/2014-March/071555.html. I've linked to the bit where the issues started to be discussed rather than the start of the thread.
>
> Difficulty and objections aside, it's also a very large amount of work to support a single (as far as I know) user of named register locals, especially when Linux has already accepted patches to switch named register locals to named register globals elsewhere. On balance, it seems best to change Linux.
>
>>>>> Signed-off-by: Daniel Sanders <daniel.sanders@imgtec.com>
>>>> [...]
>>>>
>>>>> diff --git a/arch/mips/include/asm/thread_info.h
>>>> b/arch/mips/include/asm/thread_info.h
>>>>> index 99eea59..2a2f3c4 100644
>>>>> --- a/arch/mips/include/asm/thread_info.h
>>>>> +++ b/arch/mips/include/asm/thread_info.h
>>>>> @@ -58,11 +58,11 @@ struct thread_info {
>>>>>    #define init_stack		(init_thread_union.stack)
>>>>>
>>>>>    /* How to get the thread information struct from C.  */
>>>>> +register struct thread_info *current_gp_register asm("$28");
>>>>      *static* missing?
>>>>
>>>> WBR, Sergei
>>> Combining 'register' and 'static' is invalid.
>> Defining global variables in header files is also invalid.
> I agree with that statement but named register globals are not the same as normal global variables. In particular, they do not take up space in the data section and they do not have an entry in the symbol table. They can therefore be included in multiple objects without causing link errors.
Daniel's code is in line with the solution already used in both the arm
and arm64/aarch64 arches which works with both gcc and clang.

Just in case that helps.

Behan

-- 
Behan Webster
behanw@converseincode.com
