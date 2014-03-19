Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2014 19:42:54 +0100 (CET)
Received: from mail-pb0-f47.google.com ([209.85.160.47]:48359 "EHLO
        mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816543AbaCSSmwaEGYC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Mar 2014 19:42:52 +0100
Received: by mail-pb0-f47.google.com with SMTP id up15so9312713pbc.20
        for <multiple recipients>; Wed, 19 Mar 2014 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=d7d48lP9NUV5o6UKTgMoV7eFCTm78gcSSS4G7GyERbo=;
        b=prDxhOPzgPA8+AB6mMcGulc7c3Wwe+k7PJD25wHbgKG6xxgQUax1hACEI9Dvbc6+8q
         jjLwncywIhoFzM9urEi5i5i7quwDU4QEo+ulcDb+9BjxiWC74BqqPU5pCUy8P3dTPXWF
         snBWInlInS78PCuasdE+d4TGaIiPqNkLnPQI2huXii4kZi8V4fAL1pp0B772DwGD61qs
         YiiVOUhxo9nySCxvVrWhJX145i+Rf4WKSYee9PBgPmdqvqyE1R2M5KCKrmGQWLFBHYCQ
         rKe/FFKkTHjTPPRynDZP3vTS9Tl6HFSieYJOAg3/cqXwW/BlDInuXRuOJe39YhSmvulC
         J/8w==
MIME-Version: 1.0
X-Received: by 10.68.227.4 with SMTP id rw4mr42676713pbc.3.1395254566078; Wed,
 19 Mar 2014 11:42:46 -0700 (PDT)
Received: by 10.70.48.138 with HTTP; Wed, 19 Mar 2014 11:42:45 -0700 (PDT)
In-Reply-To: <20140317145641.GN19285@linux-mips.org>
References: <1393055209-28251-1-git-send-email-villerhsiao@gmail.com>
        <1393055209-28251-2-git-send-email-villerhsiao@gmail.com>
        <20140317145641.GN19285@linux-mips.org>
Date:   Wed, 19 Mar 2014 19:42:45 +0100
X-Google-Sender-Auth: HdzLhfH-D3agPVnhFDB0c6b7ok4
Message-ID: <CAMuHMdV5OWjMrJDhDmzHJpcXNoJ+9cjgF9QAbp4OVvr+jDH2iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MIPS: ftrace: Tweak safe_load()/safe_store() macros
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Viller Hsiao <villerhsiao@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Qais.Yousef@imgtec.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Ralf,

On Mon, Mar 17, 2014 at 3:56 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Feb 22, 2014 at 03:46:48PM +0800, Viller Hsiao wrote:
>
>> Due to name collision in ftrace safe_load and safe_store macros,
>> these macros cannot take expressions as operands.
>>
>> For example, compiler will complain for a macro call like the following:
>>   safe_store_code(new_code2, ip + 4, faulted);
>>
>>   arch/mips/include/asm/ftrace.h:61:6: note: in definition of macro 'safe_store'
>>      : [dst] "r" (dst), [src] "r" (src)\
>>         ^
>>   arch/mips/kernel/ftrace.c:118:2: note: in expansion of macro 'safe_store_code'
>>     safe_store_code(new_code2, ip + 4, faulted);
>>     ^
>>   arch/mips/kernel/ftrace.c:118:32: error: undefined named operand 'ip + 4'
>>     safe_store_code(new_code2, ip + 4, faulted);
>>                                   ^
>>   arch/mips/include/asm/ftrace.h:61:6: note: in definition of macro 'safe_store'
>>      : [dst] "r" (dst), [src] "r" (src)\
>>         ^
>>   arch/mips/kernel/ftrace.c:118:2: note: in expansion of macro 'safe_store_code'
>>     safe_store_code(new_code2, ip + 4, faulted);
>>     ^
>>
>> This patch tweaks variable naming in those macros to allow flexible
>> operands.
>
> Interesting catch - and while I think your patch indeed is an improvment
> nobody seems to have observed this in a kernel tree, so I'm going to treat
> this as a non-urgent improvment and queue it for 3.15.
>
> If this can be triggered in any -stable or v3.14-rc7 tree, please let me
> know.

Mips/allmodconfig started to fail _after_ v3.14-rc7:

http://kisskb.ellerman.id.au/kisskb/buildresult/10807340/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
