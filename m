Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 11:20:15 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.10]:56789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013909AbaKRKUOLzpht (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 11:20:14 +0100
Received: from wuerfel.localnet (HSI-KBW-149-172-15-242.hsi13.kabel-badenwuerttemberg.de [149.172.15.242])
        by mrelayeu.kundenserver.de (node=mreue104) with ESMTP (Nemesis)
        id 0MYeLS-1XUDKk14h0-00VT3c; Tue, 18 Nov 2014 11:19:52 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH V2 22/22] MIPS: Add multiplatform BMIPS target
Date:   Tue, 18 Nov 2014 11:19:51 +0100
Message-ID: <12543154.MaArN0zy9N@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAJiQ=7B6Xwz2iqqH4vEG8WzPOzHj7NHsuGWqq49uy-E34RHp4A@mail.gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com> <3357597.nYlNZ6O0nJ@wuerfel> <CAJiQ=7B6Xwz2iqqH4vEG8WzPOzHj7NHsuGWqq49uy-E34RHp4A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:J+GcyzG5e8+IZqaDVFOygOa1NjCOebCZGc92OQUYqGS
 9u905NTZD5ojaaEAOx0NhSGkcaqd3n/sPlM+rFT370Wk/QT9OZ
 G82K9YYxCRqARcUkufnjKTl7KPpLdwJQ372lntNIMJTpLzGLYx
 L5lQ66sBSxhOSZKYNKynygrUac46MWBvyuK5d5eMMxHXAw7RIy
 Ugj9Bn/CeIEHu+MMi5vxW7okxaT5Jwipk7i6TeOL29CqMIGExu
 17dkOFpHcwz67y+XZpNeajuFexopSqytXYCrQq49QgBYgqDYea
 n1rB2rBkLdnLiuQn7wOLpCOUuQEvZzFJOPsSCm9hT0JUdTr+pb
 dKjMsqHkAWTnhJBOQ3xQ=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44266
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

On Monday 17 November 2014 13:21:45 Kevin Cernekee wrote:
> On Mon, Nov 17, 2014 at 12:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> One possible complication: for BCM63xx/BCM7xxx (MIPS) there is no
> >> decompressor in the kernel.  The firmware loads an ELF image into
> >> memory and jumps directly to kernel_entry.
> >>
> >
> > Right, that complicates it a bit, but is there a reason why a decompressor
> > would be hard to do, or would be considered a bad thing?
> > There is already generic decompressor code in arch/mips/boot/compressed/
> > that I would assume you could use without firmware changes. Are you
> > worried about boot time overhead?
> 
> Currently the bootloader is responsible for decompressing the image.
> On STB the bootloader typically loads a gzipped ELF file; on DSL/CM
> the bootloader unpacks a custom image format containing an
> LZMA-compressed kernel in some form.  So we would be
> double-compressing the same kernel in this scheme.
> 
> STB/DSL should be able to boot the arch/mips/boot/compressed "vmlinuz"
> ELF file; I tested STB.  CM might be questionable, but doesn't need
> decompressor mods because the bootloader is DT-aware.
> 
> Also, the decompressor may need to be modified so that it recognizes /
> passes / doesn't overwrite DTB blobs coming from the bootloader.  And
> to make sure it doesn't stomp on any of the code or data that our
> bootloaders use for their callback mechanisms.
> 
> So, one possibility is to submit a V3 patch which allows 0 or 1 DTB
> files to be compiled in statically (similar to
> CONFIG_ARM_APPENDED_DTB) and requires a DT-aware bootloader or
> decompressor for anything else.  Any opinions?

That sounds like a good approach, in particular with the patch that
Jonas linked to. With that, most or all of your arch/mips/bmips/setup.c
should become completely generic, and I would think the rest can
be handled through a function that is called after looking up the
root "compatible" property in DT.

	Arnd
