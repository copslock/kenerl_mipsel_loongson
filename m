Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 12:36:19 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.75]:64247 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992246AbdAILgMgmbvc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 12:36:12 +0100
Received: from wuerfel.localnet ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPSA (Nemesis) id
 0Mg0zl-1c5Ho43kub-00NRrB; Mon, 09 Jan 2017 12:34:02 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org
Cc:     Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
        linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        airlied@linux.ie, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-am33-list@redhat.com,
        linux-c6x-dev@linux-c6x.org, linux-rdma@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org,
        coreteam@netfilter.org, fcoe-devel@open-fcoe.org,
        xen-devel@lists.xenproject.org, linux-snps-arc@lists.infradead.org,
        linux-media@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        mmarek@suse.com, netfilter-devel@vger.kernel.org,
        linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        davem@davemloft.net
Subject: Re: [PATCH v2 0/7] uapi: export all headers under uapi directories
Date:   Mon, 09 Jan 2017 12:33:58 +0100
Message-ID: <3131144.4Ej3KFWRbz@wuerfel>
User-Agent: KMail/5.1.3 (Linux/4.4.0-34-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com> <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:wU8GJSP4OhJhd2G07RdfqjkficQJ7uKfv+nqSredestBcn9w8Ak
 cyqdP31aGe4IXlyw8HcQrUPySHuSZ+Z4Oo6csQUQPHHD8YGDm5HljdGbw8TZIaZns8gYrEr
 wSlZmtpBexxu5dY27E+ORE/Nj9HGNQpfoPbh6KuxUu6BxJZK3SkuOU/7Ol/aoRC3fTWjECo
 2PT8B0Ak0ZqZcF+1YO4EQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MTir4VDdfTQ=:aSv4A5Fx+SGSeaorHRgk/C
 0PdMhHey0cTCpHuau+Wjj8w3yBunjnoPWQG1QKad/hmd5O8s10a6fJgkE+XfEepXGoebsWPI+
 WRLNx6SypBaHp3GCjmzUNk/8cQPJC8pZLZanaapLqkEckm2dNGjpGwgzIIH6RpLOjXJYSSDUK
 MdKYxPx+cyzs5p02SyTjZml9By8LVQXzvDj4G4EDKNTdWgZILLULOECdsJp6BsI6+wk2k6eIF
 pZQsfGwMwn1SdetyXj8GaUIQ9ceNlX98KGxRjqpc6VE/5puJ11/q4Aiac+9Z847Vwou9bRHRY
 aildmwrSmpiah32mrU9th/PBxKLM6PaZmRUTrWO1JKUqw0Bym+5VZuIZjYFLj1PoXgtqs8hAW
 DshhWXJEEcirmIBHUmbeUlkgeRXLusSB56UYOQlavwddlw2ZWqmiRdgKHAC/xswe1/8iidsWf
 Pzcl8Rk01kTt/ZSsX0JId8ZrUWHpWUUHoKfhOXEIMgFItYOTOJ644ekuESkve8E6gl1RZNyI4
 2hqgsrctk0to814BfMBZq+96Rz/Sx0X8b0+UDXjzNSBjUifuoKWR3HFCVfeHJoB1JqM2G+mrX
 2s4DFdVPgT2YuSr6+0nDDSyyt6Zagwpw8eaEDO9zmJYUasWnRGUhA0RD+NRAyakFDxSO27M4S
 3N910RyxC1RagVNxELKQt9zt0CqWER9NkXaM31gBX0HfpU7H183Gq1Myftu9Ns776YD6P7G5I
 4Tpkl/pmA0Da1HFz
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56228
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

On Friday, January 6, 2017 10:43:52 AM CET Nicolas Dichtel wrote:
> Here is the v2 of this series. The first 5 patches are just cleanup: some
> exported headers were still under a non-uapi directory.

Since this is meant as a cleanup, I commented on this to point out a cleaner
way to do the same.

> The patch 6 was spotted by code review: there is no in-tree user of this
> functionality.
> The last patch remove the use of header-y. Now all files under an uapi
> directory are exported.

Very nice!

> asm is a bit special, most of architectures export asm/<arch>/include/uapi/asm
> only, but there is two exceptions:
>  - cris which exports arch/cris/include/uapi/arch-v[10|32];

This is interesting, though not your problem. Maybe someone who understands
cris better can comment on this: How is the decision made about which of
the arch/user.h headers gets used? I couldn't find that in the sources,
but it appears to be based on kernel compile-time settings, which is
wrong for user space header files that should be independent of the kernel
config.

>  - tile which exports arch/tile/include/uapi/arch.
> Because I don't know if the output of 'make headers_install_all' can be changed,
> I introduce subdir-y in Kbuild file. The headers_install_all target copies all
> asm/<arch>/include/uapi/asm to usr/include/asm-<arch> but
> arch/cris/include/uapi/arch-v[10|32] and arch/tile/include/uapi/arch are not
> prefixed (they are put asis in usr/include/). If it's acceptable to modify the
> output of 'make headers_install_all' to export asm headers in
> usr/include/asm-<arch>/asm, then I could remove this new subdir-y and exports
> everything under arch/<arch>/include/uapi/.

I don't know if anyone still uses "make headers_install_all", I suspect
distros these days all use "make headers_install", so it probably
doesn't matter much.

In case of cris, it should be easy enough to move all the contents of the
uapi/arch-*/*.h headers into the respective uapi/asm/*.h headers, they
only seem to be referenced from there.

For tile, I suspect that would not work as the arch/*.h headers are
apparently defined as interfaces for both user space and kernel.

> Note also that exported files for asm are a mix of files listed by:
>  - include/uapi/asm-generic/Kbuild.asm;
>  - arch/x86/include/uapi/asm/Kbuild;
>  - arch/x86/include/asm/Kbuild.
> This complicates a lot the processing (arch/x86/include/asm/Kbuild is also
> used by scripts/Makefile.asm-generic).
> 
> This series has been tested with a 'make headers_install' on x86 and a
> 'make headers_install_all'. I've checked the result of both commands.
> 
> This patch is built against linus tree. I don't know if it should be
> made against antoher tree.

The series should probably get merged through the kbuild tree, but testing
it on mainline is fine here.

	Arnd
