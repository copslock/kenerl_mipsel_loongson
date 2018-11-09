Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2018 20:02:11 +0100 (CET)
Received: from tartarus.angband.pl ([IPv6:2001:41d0:602:dbe::8]:48492 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990717AbeKITA2HkuhW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Nov 2018 20:00:28 +0100
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gLC0X-000503-84; Fri, 09 Nov 2018 19:59:53 +0100
Date:   Fri, 9 Nov 2018 19:59:53 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 0/17] Kernel compression: add ZSTD, remove LZMA1 and BZIP2
Message-ID: <20181109185953.xwyelyqnygbskkxk@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Return-Path: <kilobyte@angband.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kilobyte@angband.pl
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

Hi!
As new compressors get invented, they tend to find their way into the
kernel, yet we never prune superseded ones.  It's time to do so.

In particular, BZIP2 is drastically slower than other compressors we
have, even when they achieve smaller sizes.  It takes more memory, too.
And, BZIP2 is not used anywhere else in the kernel -- just for booting
the kernel itself and the initrd.  Thus, we can drop it from the tree
completely, making Linus happier by around 900 lines.

LZMA1 is redundant with XZ (LZMA2), and unlike the latter, it uses its own
copy of code that's not shared with anything else (some drivers use XZ).
Let's drop it as well.  Some bootloaders can use it thus let's keep the
Kconfig option, but I left no piece of code inside the kernel itself.

On the other hand, Nick Terrell has a couple of patches adding ZSTD support
(using code already in use in multiple pieces around the kernel).  ZSTD is
strong and fast, obsoleting all mid-range compressors.  As the removal of
BZIP2 and LZMA1 would be hopelessly entangled with this addition, I'm
resending Nick's patches here.  I've been booting using them since Oct'17
on amd64 (kernel+initrd), armhf and arm64 (initrd) without issues, other
folks tested various other architectures as well.

Thus, I'd recommend people to use:
* XZ for most machines
* ZSTD where speed is important
* maaaaybe LZ4 is some special cases
(grub and u-boot are ridiculously slow at reading, making fast but weak
decompressors a net loss.  On the other hand, XZ decompresses pretty fast
but is very slow at compress time, making ZSTD preferred for rapid devel
cycles.)

* we can't get rid of GZIP in foreseable future
* LZO is obsolete but is used elsewhere in the kernel

Total:
 69 files changed, 518 insertions(+), 1785 deletions(-)

Not sure whose tree this patchset should go through.  I'm also not sure
how finely split into commits you want the arch bits be; I included
defconfig bits all together, yet separated code changes per-arch.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
