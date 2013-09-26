Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 13:59:48 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9062 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824799Ab3IZN4Vj8GoR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Sep 2013 15:56:21 +0200
Received: (qmail 21020 invoked by uid 89); 26 Sep 2013 13:56:46 -0000
Received: by simscan 1.3.1 ppid: 21013, pid: 21016, t: 0.2900s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO 046207148010.atmpu0029.highway.a1.net) (richard@nod.at@46.207.148.10)
  by radon.swed.at with ESMTPA; 26 Sep 2013 13:56:46 -0000
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com> <52441025.9030308@nod.at> <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com> <52441407.9010603@nod.at> <CALkWK0=FG4COEjv5+mu1JRiiFQ2k6vop1mhFPmAT4bjtYeK6nA@mail.gmail.com> <52442108.1020304@nod.at> <CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com> <CALkWK0ndMtyQxE0uK4H-Ly6oy+tRn-SFc=_1WoC2QAp2uy0dtw@mail.gmail.com> <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----5QY7030VZWCJNE5X8N17B2HC1XHSHG"
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
From:   Richard Weinberger <richard@nod.at>
Date:   Thu, 26 Sep 2013 15:56:07 +0200
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ramkumar Ramachandra <artagnon@gmail.com>
CC:     Linux-Arch <linux-arch@vger.kernel.org>,
        Michal Marek <mmarek@suse.cz>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jeff Dike <jdike@addtoit.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Message-ID: <6ca106c1-3ba4-4d49-97ad-9f400045dd2c@email.android.com>
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38285
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
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

------5QY7030VZWCJNE5X8N17B2HC1XHSHG
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit

Correct. Users expect Form SUBARCH=x86 a 32bit kernel.



Geert Uytterhoeven <geert@linux-m68k.org> schrieb:

>On Thu, Sep 26, 2013 at 3:13 PM, Ramkumar Ramachandra
><artagnon@gmail.com> wrote:
>> Ramkumar Ramachandra wrote:
>>> Richard Weinberger wrote:
>>>> I told you already that "make defconfig ARCH=um SUBARCH=x86" will
>spuriously
>>>> create a x86_64 config on x86_64.
>>>> This breaks existing setups.
>>>
>>> I'll fix this and resubmit soon.
>>
>> Wait a minute. You're now arguing about whether the generic "x86"
>> means i386 or x86_64. Its meaning is already defined in
>> arch/x86/Kconfig and arch/x86/um/Kconfig: see the config 64BIT.
>Unless
>> i386 is explicitly specified, the default is to build a 64-bit
>kernel.
>> That is already defined for a normal Linux kernel, and user-mode
>Linux
>> should not break that convention. So, in the example you pulled out
>of
>> your hat:
>>
>>   $ make defconfig ARCH=um SUBARCH=x86
>>
>> the user should expect a 64-bit build, and not an i386 build as you
>> say. Both my patches are correct, and the "regression" that you
>> pointed out is a red herring.
>
>Sorry for chiming in, but... what about cross compiling?
>SUBARCH=x86 should give you a 32-bit ia32 kernel, right?
>
>Gr{oetje,eeting}s,
>
>                        Geert
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
>geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a
>hacker. But
>when I'm talking to journalists I just say "programmer" or something
>like that.
>                                -- Linus Torvalds

-- 
Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gesendet.
------5QY7030VZWCJNE5X8N17B2HC1XHSHG
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head/><body><html><head></head><body>Correct. Users expect Form SUBARCH=x86 a 32bit kernel.<br><br><div class="gmail_quote"><br>
<br>
Geert Uytterhoeven &lt;geert@linux-m68k.org&gt; schrieb:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre style="white-space: pre-wrap; word-wrap:break-word; font-family: sans-serif; margin-top: 0px">On Thu, Sep 26, 2013 at 3:13 PM, Ramkumar Ramachandra<br />&lt;artagnon@gmail.com&gt; wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;">Ramkumar Ramachandra wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #ad7fa8; padding-left: 1ex;">Richard Weinberger wrote:<br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #8ae234; padding-left: 1ex;">I told you already that "make defconfig ARCH=um SUBARCH=x86" will spuriously<br />create a x86_64 config on x86_64.<br />This breaks existing setups.</blockquote><br />I'll fix this and resubmit soon.</blockquote><br />Wait a minute. You're now arguing about whether the generic "x86"<br />means i386 or x86_64. Its meaning is already defined in<br />arch/x86/Kconfig and
arch/x86/um/Kconfig: see the config 64BIT. Unless<br />i386 is explicitly specified, the default is to build a 64-bit kernel.<br />That is already defined for a normal Linux kernel, and user-mode Linux<br />should not break that convention. So, in the example you pulled out of<br />your hat:<br /><br />$ make defconfig ARCH=um SUBARCH=x86<br /><br />the user should expect a 64-bit build, and not an i386 build as you<br />say. Both my patches are correct, and the "regression" that you<br />pointed out is a red herring.</blockquote><br />Sorry for chiming in, but... what about cross compiling?<br />SUBARCH=x86 should give you a 32-bit ia32 kernel, right?<br /><br />Gr{oetje,eeting}s,<br /><br />Geert<br /><br />--<br />Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org<br /><br />In personal conversations with technical people, I call myself a hacker. But<br />when I'm talking to journalists I just say "programmer" or something like that.<br />-- Linus
Torvalds<br /></pre></blockquote></div><br>
-- <br>
Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gesendet.</body></html></body></html>
------5QY7030VZWCJNE5X8N17B2HC1XHSHG--
