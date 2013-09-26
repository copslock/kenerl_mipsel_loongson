Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 19:10:42 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9061 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6831351Ab3IZRKjjxvtD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Sep 2013 19:10:39 +0200
Received: (qmail 23762 invoked by uid 89); 26 Sep 2013 17:10:42 -0000
Received: by simscan 1.3.1 ppid: 23695, pid: 23759, t: 0.0585s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.11?) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 26 Sep 2013 17:10:42 -0000
Message-ID: <52446A89.1080409@nod.at>
Date:   Thu, 26 Sep 2013 19:10:33 +0200
From:   Richard Weinberger <richard@nod.at>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ramkumar Ramachandra <artagnon@gmail.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com> <52441025.9030308@nod.at> <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com> <52441407.9010603@nod.at> <CALkWK0=FG4COEjv5+mu1JRiiFQ2k6vop1mhFPmAT4bjtYeK6nA@mail.gmail.com> <52442108.1020304@nod.at> <CALkWK0nm=9n7DiV0MaGKVLMs=vxAiiQUx=OFuOg-DinkdMej5A@mail.gmail.com> <CALkWK0ndMtyQxE0uK4H-Ly6oy+tRn-SFc=_1WoC2QAp2uy0dtw@mail.gmail.com> <CAMuHMdU3LdDhbp_AKjD7b8Wytbqfp29DrPwTdtwQa2hUNdcy3Q@mail.gmail.com> <524443AC.3040409@nod.at> <CALkWK0kcd03t9W4O24wiVBQ8SZQ8ZcrbvQaUkcCm+y5n=d1wPw@mail.gmail.com> <52444CED.40401@nod.at> <CALkWK0=u8CdtmbaOtA5=jxuWsei2ZQhxDwSsnhAR=ZRBNyoH6Q@mail.gmail.com>
In-Reply-To: <CALkWK0=u8CdtmbaOtA5=jxuWsei2ZQhxDwSsnhAR=ZRBNyoH6Q@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38001
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

Am 26.09.2013 18:06, schrieb Ramkumar Ramachandra:
> Richard Weinberger wrote:
>> And, of course, this makes your patch valid.
>> Can you also please ensure that your new defconfigs are minimal?
> 
> Yeah, it's close to a minimal configuration for the 3.10 kernel
> (latest at the time of patch submission). I was aiming to minimize the
> diff between the current defconfig and the two new defconfigs in
> configs/. The slim diffstat does the talking:
> 
>  arch/um/Kconfig.common                          |   5 -
>  arch/um/Makefile                                |  11 ++
>  arch/um/{defconfig => configs/i386_defconfig}   | 209 +++++++++++++-------
>  arch/um/{defconfig => configs/x86_64_defconfig} | 250 +++++++++++++++---------
>  arch/x86/um/Kconfig                             |   5 +
>  5 files changed, 306 insertions(+), 174 deletions(-)
>  copy arch/um/{defconfig => configs/i386_defconfig} (86%)
>  rename arch/um/{defconfig => configs/x86_64_defconfig} (83%)
> 
> If we find some deficiencies, we can always update it. For now, please
> commit these two patches.

Please resend them with savedefconfig applied.
There is no need to have three commits for that.

Thanks,
//richard
