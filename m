Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 13:01:35 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9062 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6818991Ab3IZLBdrJtdg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Sep 2013 13:01:33 +0200
Received: (qmail 17712 invoked by uid 89); 26 Sep 2013 11:01:33 -0000
Received: by simscan 1.3.1 ppid: 17705, pid: 17708, t: 0.0624s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.11?) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 26 Sep 2013 11:01:33 -0000
Message-ID: <52441407.9010603@nod.at>
Date:   Thu, 26 Sep 2013 13:01:27 +0200
From:   Richard Weinberger <richard@nod.at>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ramkumar Ramachandra <artagnon@gmail.com>
CC:     linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>,
        geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org,
        Jeff Dike <jdike@addtoit.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com> <52441025.9030308@nod.at> <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com>
In-Reply-To: <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37986
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

Am 26.09.2013 12:53, schrieb Ramkumar Ramachandra:
> Richard Weinberger wrote:
>> So, what exactly is broken in upstream?
>> make defconfig works as it always did.
> 
> Auto-detection of SUBARCH, which can be done with a simple call to
> uname -m (the 90% case). The second patch I submitted prevented
> spawning xterms unnecessarily, which we discussed was a good move.

Covering only 90% of all cases is not enough.
We must not break existing setups.
That's also why my "Get rid of SUBARCH" series is not upstream.

Your second patch changed CONFIG_CON_CHAN to pts, which is ok but not
a major issue.
The xterms are also not spawning unnecessarily they spawn upon a tty device is opened.
With your patch UML create another pts. Thus, the spawning is hidden...
I did not push it upstream because it depended on your first one and as I said, it's not critical.
This does not mean that I moved it to /dev/null.
Again, the plan is to get rid of SUBARCH at all.

>> make defconfig ARCH=um SUBARCH=x86 (or SUBARCH=i386) will create a defconfig for 32bit.
>> make defconfig ARCH=um SUBARCH=x86_64 one for 64bit.
> 
> Yes, that's how I prepared the patch in the first place.

So, nothing is broken.

If you want "make defconfig ARCH=um" creating a defconfig for the correct arch you need
more than your first patch. Again, "Get rid of SUBARCH" series has the same goal.

Thanks,
//richard
