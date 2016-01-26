Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 18:48:55 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35644 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011636AbcAZRsyXTB2s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 18:48:54 +0100
Received: by mail-lb0-f170.google.com with SMTP id bc4so96308105lbc.2
        for <linux-mips@linux-mips.org>; Tue, 26 Jan 2016 09:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+tnkqbesXKiQwWs+C0i5+9fG8Xbb5ZP7bWVd6dOL1ZQ=;
        b=oFN0EvBKvXvavyIIDqvbDQ7JShZ/mNqefmUA3e5GkA2juwYojSdPLmA4wOWuXF8GmF
         61ohNsmKHxQyuo/vPT24a9tWt/1/5nmypdPdHq5UioXkGp7n88GLVnkvHwrfKk3XeTQJ
         lurjg2pBfqbXQbgT4CyNz2Jf7JS17NSpnLMa7X26B3bq089RSC8EnUuUl+QIeAlviJfc
         SoAcZQFKEX+zq352HEMtgIhqHc5UCkILFJvJPwY4ar0O1y58+D/oE1pbpswrPbzOlzEN
         PjzukIcsQUoY0NRy/rPKejKcpMp2ACFbJPoUYv0c6HX876Ma/jOqM+heWIgUfg26Di47
         QHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=+tnkqbesXKiQwWs+C0i5+9fG8Xbb5ZP7bWVd6dOL1ZQ=;
        b=FQLRCKPfledTusgPJrTKktspxflEcODySkmBF/w4riYdQ/y0/4cEKqu6VHwyPYRJwq
         ogLXYzExRPyvxAcgrsRfbDI4iGLrHSwI9cFfBaKiZCfFWHeVMFNTLLfDc58z+Gw+bO0W
         mosRywmRwNwwf/wjcA0QvkkUcCdH1OQi+QA/hXpIhXtlh81AqSLP+COZni838FFmkllO
         Ah6R3VTpPBYYoJoe81Kbv8QqqwpZOF3tn7N73uTeaotKs1f2A8joKk0Mwsbi27L5+bY5
         BlI7OwZ7X8sqmlK32EQru6/qWVnHPRS8CsWP4DmpiPYkvwAqLEvIsCxSY0IQRd3152Fe
         CPiw==
X-Gm-Message-State: AG10YORkG8ANSIABK3YOoInsmzWGxDaiAy9uejOmWt1uxbMqlzD608Djah8ayK0rJC3bG0HuuvIR6x6uoauJdXoR
X-Received: by 10.112.13.8 with SMTP id d8mr8871852lbc.110.1453830528998; Tue,
 26 Jan 2016 09:48:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.88.140 with HTTP; Tue, 26 Jan 2016 09:48:29 -0800 (PST)
In-Reply-To: <20160126174441.GA18873@ravnborg.org>
References: <cover.1453759363.git.luto@kernel.org> <e520030f750b29d14486aa1e99c271a0fa18f19e.1453759363.git.luto@kernel.org>
 <20160126062951.GA17107@ravnborg.org> <20160125.225100.1932707129794761764.davem@davemloft.net>
 <20160126174441.GA18873@ravnborg.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 26 Jan 2016 09:48:29 -0800
Message-ID: <CALCETrVaOC2=CC0bDoc-g2o+wjwaFfj+LAB7umrRMCHYwsk+Bg@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] sparc/compat: Provide an accurate
 in_compat_syscall implementation
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-parisc@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Tue, Jan 26, 2016 at 9:44 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Mon, Jan 25, 2016 at 10:51:00PM -0800, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Tue, 26 Jan 2016 07:29:51 +0100
>>
>> > Could you please add a comment about where 0x110 comes from.
>> > I at least failed to track this down.
>>
>> Frankly I'm fine with this.  Someone who understands sparc64 can look
>> at the trap table around entry 0x110 and see:
>>
>> tl0_resv10e:  BTRAP(0x10e) BTRAP(0x10f)
>> tl0_linux32:  LINUX_32BIT_SYSCALL_TRAP
>> tl0_oldlinux64:       LINUX_64BIT_SYSCALL_TRAP
>
> If one realise to look in the trap table in the first place - yes.
>
> Adding a short:
>
> /* Check if this is LINUX_32BIT_SYSCALL_TRAP */
> Would make wonders to readability.

I'll add a comment in v2.

--Andy
-- 
Andy Lutomirski
AMA Capital Management, LLC
