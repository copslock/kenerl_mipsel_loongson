Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2014 11:15:32 +0200 (CEST)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36103 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818018AbaFEJPaMHKfm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2014 11:15:30 +0200
Received: by mail-ie0-f173.google.com with SMTP id lx4so640129iec.32
        for <multiple recipients>; Thu, 05 Jun 2014 02:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZjUhWMd2psckfXtcPv08t5L/BzeABGlVxo0/SO7RZk8=;
        b=KEgUAhYiR6PSE0fizpSaRFNJv46r8pQ+ZJxPfijMzqOxFbgaAgl7K/oCQriRhQPLI1
         5rlVuruBI2SQGKURQ/LvagB3FE1GuwjWEdwsk84Zngod0/pdVAsGDkLJaUIVCvwTvJ/0
         L0u/daVy1BsXswXEYo1AeisCUebvaqR3HL5jtPEDptPkeUHb0zGbiceOPFLuKom2kqP0
         2yP3eprWchVS2ATmBU5A/sqGVanzVXZ3Sdwsrbvj139EnI4hQWgIuq2gqW+DmsuhoYo9
         e8clewvEO5T8pAxDXbqoQ8HWf+86njZa1wt5ZtTQlKp994L50P6memfVvCOT7Q2ontwf
         l4sQ==
MIME-Version: 1.0
X-Received: by 10.50.109.202 with SMTP id hu10mr17888836igb.1.1401959723735;
 Thu, 05 Jun 2014 02:15:23 -0700 (PDT)
Received: by 10.64.137.71 with HTTP; Thu, 5 Jun 2014 02:15:23 -0700 (PDT)
In-Reply-To: <538F55C9.7090905@gmail.com>
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
        <1397348662-22502-5-git-send-email-chenhc@lemote.com>
        <20140603224739.GU17197@linux-mips.org>
        <538E5EA8.8010907@gmail.com>
        <20140604064601.GU5157@linux-mips.org>
        <538F55C9.7090905@gmail.com>
Date:   Thu, 5 Jun 2014 17:15:23 +0800
X-Google-Sender-Auth: 6g1L_aqE4pnPzWJ5hDMNeKLnfP4
Message-ID: <CAAhV-H6wq-a3Ud114LREUNsTSAWhcSqcwqJgw2mD5Y1BVmu3qw@mail.gmail.com>
Subject: Re: [PATCH V2 4/8] MIPS: Add NUMA support for Loongson-3
From:   Huacai Chen <chenhc@lemote.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Now what should I do?  Change MAX_PHYSMEM_BITS and XPHYSADDR to 49
bits in a separte patch?

Huacai

On Thu, Jun 5, 2014 at 1:22 AM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 06/03/2014 11:46 PM, Ralf Baechle wrote:
>>
>>
>> A more important value which I haven't noticed the Looongson patches to
>> modify is SECTION_SIZE_BITS in <asm/sparsemem.h>:
>>
>> #if defined(CONFIG_MIPS_HUGE_TLB_SUPPORT) &&
>> defined(CONFIG_PAGE_SIZE_64KB)
>> # define SECTION_SIZE_BITS      29
>> #else
>> # define SECTION_SIZE_BITS      28
>> #endif
>>
>> Don't ask me why its definition depends on MIPS_HUGE_TLB_SUPPORT and
>> PAGE_SIZE_64KB - the value describes the larges chunk of contiguous
>> memory (that is for example memory per node) and that doesn't depend
>> on these CONFIG_* symbols.
>>
>
> I think I can answer that.  We do the same thing for OCTEON I think.
>
> IIRC, with SPARSEMEM, you cannot allocate high order pages that span
> multiple sections.  Therefore you have to have the sections be at least as
> large as a huge page.  in the case of CONFIG_PAGE_SIZE_64KB, the huge pages
> are 512MB which doesn't fit in 28 bits.
>
> David.
>
>
>>    Ralf
>>
>>
>
>
