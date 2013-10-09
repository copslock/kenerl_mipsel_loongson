Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 14:00:04 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9062 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817505Ab3I0J0ZRwPLp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Sep 2013 11:26:25 +0200
Received: (qmail 1572 invoked by uid 89); 27 Sep 2013 09:26:31 -0000
Received: by simscan 1.3.1 ppid: 1565, pid: 1568, t: 0.0523s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.11?) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 27 Sep 2013 09:26:30 -0000
Message-ID: <52454F38.60902@nod.at>
Date:   Fri, 27 Sep 2013 11:26:16 +0200
From:   Richard Weinberger <richard@nod.at>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
CC:     Ramkumar Ramachandra <artagnon@gmail.com>,
        linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>,
        geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org,
        Jeff Dike <jdike@addtoit.com>, gxt@mprc.pku.edu.cn,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/8] um: Create defconfigs for i386 and x86_64
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-2-git-send-email-richard@nod.at> <CALkWK0=W38JpZoGVkPYD4qd=+Pt1G7oYPEK_R=c8TAW6W=wxyg@mail.gmail.com> <52440DE0.1030807@nod.at> <52454E58.3010305@gmx.de>
In-Reply-To: <52454E58.3010305@gmx.de>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38286
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

Am 27.09.2013 11:22, schrieb Toralf Förster:
> On 09/26/2013 12:35 PM, Richard Weinberger wrote:
>> Am 26.09.2013 12:20, schrieb Ramkumar Ramachandra:
>>> Richard Weinberger wrote:
>>>> This patch is based on: https://lkml.org/lkml/2013/7/4/396
>>>>
>>>> Cc: Ramkumar Ramachandra <artagnon@gmail.com>
>>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>>> ---
>>>>  arch/um/configs/i386_defconfig   | 954 +++++++++++++++++++++++++++++++++++++++
>>>>  arch/um/configs/x86_64_defconfig | 943 ++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 1897 insertions(+)
>>>>  create mode 100644 arch/um/configs/i386_defconfig
>>>>  create mode 100644 arch/um/configs/x86_64_defconfig
>>>
>>> First, I'm pissed that the upstream tree doesn't build and run out of
>>> the box months after I submitted a fix in July (and it's September
>>> now). Fact that you dropped my sane patches aside and decided to write
>>> a much larger series aside, user-mode Linux in upstream is broken.
>>> This means that any user who does:
>>>
>>> $ ARCH=um make defconfig
>>> $ ARCH=um make
>>>
>>> will end up with a *broken* Linux _today_. Unless the user is living
>>> in the Stone Age with a 32-bit computer, this is what she will see
>>> when she attempts to boot up Linux:
> 
> :-{
> 
> Grmpf
> 
> There are a lot of 32 bit user land linux installation (beside my own,
> look at the x86 Gentoo world) in the wild - even running on modern 64bit
> CPUs. The simple reason is that those installations run fine and the
> performance "boost" of 64bit often isn't worth a new reinstallation.

You *can* of course run 32bit userland on UML. Just create a 32bit UML on x86_64.

make defconfig ARCH=um SUBARCH=i386
make linux ARCH=um SUBARCH=i386

This will work on x86_64 and x86 hosts.

Thanks,
//richard
