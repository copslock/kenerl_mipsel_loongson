Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 16:24:53 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9062 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822195Ab3IZOYsBRhxK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Sep 2013 16:24:48 +0200
Received: (qmail 21455 invoked by uid 89); 26 Sep 2013 14:24:58 -0000
Received: by simscan 1.3.1 ppid: 21448, pid: 21451, t: 0.0573s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.11?) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 26 Sep 2013 14:24:58 -0000
Message-ID: <524443AC.3040409@nod.at>
Date:   Thu, 26 Sep 2013 16:24:44 +0200
From:   Richard Weinberger <richard@nod.at>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Ramkumar Ramachandra <artagnon@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
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
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com> <52441025.9030308@nod.at> <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com> <52441407.9010603@nod.at> <CALkWK0=FG4COEjv5+mu1JRiiFQ2k6vop1mhFPmAT4bjtYeK6nA@mail.gmail.com> <52442108.1020304@nod.at> <CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com> <CALkWK0ndMtyQxE0uK4H-Ly6oy+tRn-SFc=_1WoC2QAp2uy0dtw@mail.gmail.com> <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com>
In-Reply-To: <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37995
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

Am 26.09.2013 15:26, schrieb Geert Uytterhoeven:
> On Thu, Sep 26, 2013 at 3:13 PM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Ramkumar Ramachandra wrote:
>>> Richard Weinberger wrote:
>>>> I told you already that "make defconfig ARCH=um SUBARCH=x86" will spuriously
>>>> create a x86_64 config on x86_64.
>>>> This breaks existing setups.
>>>
>>> I'll fix this and resubmit soon.
>>
>> Wait a minute. You're now arguing about whether the generic "x86"
>> means i386 or x86_64. Its meaning is already defined in
>> arch/x86/Kconfig and arch/x86/um/Kconfig: see the config 64BIT. Unless
>> i386 is explicitly specified, the default is to build a 64-bit kernel.
>> That is already defined for a normal Linux kernel, and user-mode Linux
>> should not break that convention. So, in the example you pulled out of
>> your hat:
>>
>>   $ make defconfig ARCH=um SUBARCH=x86
>>
>> the user should expect a 64-bit build, and not an i386 build as you
>> say. Both my patches are correct, and the "regression" that you
>> pointed out is a red herring.
> 
> Sorry for chiming in, but... what about cross compiling?
> SUBARCH=x86 should give you a 32-bit ia32 kernel, right?

Correct.
Users expect from SUBARCH=x86 a i386 32bit UML kernel.

Thanks,
//richard
