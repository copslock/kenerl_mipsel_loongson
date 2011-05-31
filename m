Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2011 19:24:58 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:51769 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491821Ab1EaRYw convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 May 2011 19:24:52 +0200
Received: by iyb39 with SMTP id 39so5002661iyb.36
        for <multiple recipients>; Tue, 31 May 2011 10:24:46 -0700 (PDT)
Received: by 10.42.28.5 with SMTP id l5mr9984522icc.117.1306862686066; Tue, 31
 May 2011 10:24:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.37.137 with HTTP; Tue, 31 May 2011 10:24:26 -0700 (PDT)
X-Originating-IP: [84.3.113.253]
In-Reply-To: <20110524084250.GR20052@erda.amd.com>
References: <1305290285-13818-1-git-send-email-gergely@homejinni.com> <20110524084250.GR20052@erda.amd.com>
From:   Gergely Kis <gergely@homejinni.com>
Date:   Tue, 31 May 2011 19:24:26 +0200
Message-ID: <BANLkTik2RN+DDamEZ96XKBABUwirij1Ydg@mail.gmail.com>
Subject: Re: [PATCH 0/2] MIPS: oprofile: callgraph support
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Robert Richter <robert.richter@amd.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Daniel Kalmar <kalmard@homejinni.com>,
        "oprofile-list@lists.sourceforge.net" 
        <oprofile-list@lists.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <gergely@homejinni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gergely@homejinni.com
Precedence: bulk
X-list: linux-mips

Dear Ralf,

Did you have a chance to look at our oprofile callgraph patch?

Thank you,
Gergely

On Tue, May 24, 2011 at 10:42 AM, Robert Richter <robert.richter@amd.com> wrote:
> On 13.05.11 08:38:03, Gergely Kis wrote:
>> From: Daniel Kalmar <kalmard@homejinni.com>
>>
>> These patches add callgraph/backtrace support to oprofile on MIPS.
>>
>> Stack unwinding is done by code examination. For kernelspace, the
>> already existing unwind function is utilized that uses kallsyms to
>> quickly find the beginning of functions. For userspace a new function
>> was added that examines code at and before the pc.
>>
>> Daniel Kalmar (2):
>>   MIPS: Add unwind_stack_by_address to support unwinding from any
>>     kernel code address
>>   MIPS: oprofile: Add callgraph support
>>
>>  arch/mips/include/asm/stacktrace.h |    4 +
>>  arch/mips/kernel/process.c         |   18 +++-
>>  arch/mips/oprofile/Makefile        |    2 +-
>>  arch/mips/oprofile/backtrace.c     |  173 ++++++++++++++++++++++++++++++++++++
>>  arch/mips/oprofile/common.c        |    1 +
>>  arch/mips/oprofile/op_impl.h       |    2 +
>>  6 files changed, 194 insertions(+), 6 deletions(-)
>>  create mode 100644 arch/mips/oprofile/backtrace.c
>
> Daniel and Gergely,
>
> the patches look good so far. I fixed the coding style to have the
> opening brace of functions at the beginning of the next line. After
> the MIPS maintainer's ack I will apply them to the oprofile tree.
>
> Thanks for your contribution.
>
> Ralf,
>
> please ack.
>
> Thanks,
>
> -Robert
>
> --
> Advanced Micro Devices, Inc.
> Operating System Research Center
>
>
