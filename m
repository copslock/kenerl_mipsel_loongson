Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2014 22:58:13 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:58704 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007105AbaIAU6MF2kND convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Sep 2014 22:58:12 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue005) with ESMTP (Nemesis)
        id 0MZ9ey-1XhAun3vAK-00Ky2i; Mon, 01 Sep 2014 22:57:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
Date:   Mon, 01 Sep 2014 22:57:46 +0200
Message-ID: <7233866.BdZFBc3HWf@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAOiHx==sRquiqrQW6T0S+UsOz5H8V1Wt7x1RD=SVo6=gu7M1Vg@mail.gmail.com>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com> <4072992.6HB7sP7z87@wuerfel> <CAOiHx==sRquiqrQW6T0S+UsOz5H8V1Wt7x1RD=SVo6=gu7M1Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V02:K0:UMF+2WEWBpFeXgvPRlOBDGV7FhvBoWIZrpY96MnvhEp
 YeFSeFBAvS6Fu9gXxgTWp1UC77xpcXepeuwzPjg2pCbSv7s6q7
 43ZZxnlrymAaT+EXv5wIi1DDCMFlH2ilRzeGxybFcJLk6vkb2w
 +zUr2177VHBKJlllPPcxeMvCIfcwyL15p8FFkdNvqQWBRPBYDt
 MMyOXUCaBOd+wWFvHnKIM9ZONvmjCQyWYBclnFh/TYhFOVrG3W
 Kd8a0iT2G6aqHWPO9Ou7zfsKgG265vX6Qmfvxod4Bqh08gqUEI
 PdRgf0aT1ne7PdEb/AntSjotz5RDxbYZKC5xA1u6EE5TENuJu3
 Db2lIIQ8gWurDGS2VcsI=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Monday 01 September 2014 22:45:25 Jonas Gorski wrote:
> On Mon, Sep 1, 2014 at 4:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 01 September 2014 09:48:48 Rafał Miłecki wrote:
> >> On 31 August 2014 11:20, Rafał Miłecki <zajec5@gmail.com> wrote:
> >> So I think we'll need to change our vision of flash access in
> >> bcm74xx_nvram driver. I guess we will have to:
> >> 1) Register NAND core early
> >> 2) Initialize NAND driver
> >> 3) Use mtd/nand API in bcm47xx_nvram
> >
> > This would mean it's available really late. Is that a problem?
> 
> That's probably mostly fine (for MIPS), except for two places:
> a) the kernel command line is stored in nvram, and used for finding
> out the correct console tty.

Is this also the case on ARM? According to the documented boot protocol,
ARM systems are supposed to pass the command line either through the
ATAGS interface or through a DT, and we have code to move it from
the former into the latter one. Of course it wouldn't be the first
system that ignores the boot protocol, but it has fortunately become
rather rare these days.

> b) on one specific chip, the configured system clock rate needs to be
> read out from nvram.
> 
> Both can be also done through DT, but b) is somewhat important to do
> right, as it will cause the time running fast/slow if the value is
> wrong.

Can you have two systems that can use the same DTB with the exception
of the clock rate? This sounds no different than on any other system
that has a variable clock input.

	Arnd
