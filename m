Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2010 17:09:40 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.171]:59789 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491134Ab0JUPJh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Oct 2010 17:09:37 +0200
Received: from klappe2.localnet (deibp9eh1--blueice3n2.emea.ibm.com [195.212.29.180])
        by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
        id 0M3wNK-1OIlac1238-00rZ1I; Thu, 21 Oct 2010 17:09:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v2 22/22] bitops: remove minix bitops from asm/bitops.h
Date:   Thu, 21 Oct 2010 17:10:10 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.35-16-generic; KDE/4.3.2; x86_64; ; )
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@uclinux.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        microblaze-uclinux@itee.uq.edu.au,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Hirokazu Takata <takata@linux-m32r.org>,
        linux-m32r@ml.linux-m32r.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, Chris Zankel <chris@zankel.net>
References: <1287672077-5797-1-git-send-email-akinobu.mita@gmail.com> <1287672077-5797-23-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1287672077-5797-23-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201010211710.10736.arnd@arndb.de>
X-Provags-ID: V02:K0:ZLUM1Q9uuV/6O6UOhJAlAlE/SGeNzOxudOM8cA5EF66
 zOSJB/cXirRPp77YrAde2fPzjbo3yq9Kw3MKuPyvuv3FNIpNiR
 rG38TncmX3WInmf2ERL6CNRGaDMGYyLDymr2Q5BfS+kiDJEL+I
 VAC1TFouLjQOLvIGIAqOtBdw28J4i7Ad6mDfzOV1hhPUShhfmM
 wNQpufBPvIc6m4DAE4xDA==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips

On Thursday 21 October 2010, Akinobu Mita wrote:
> minix bit operations are only used by minix filesystem and useless
> by other modules. Because byte order of inode and block bitmaps is
> defferent on each architecture like below:
> 
> m68k:
> 	big-endian 16bit indexed bitmaps
> 
> h8300, microblaze, s390, sparc, m68knommu:
> 	big-endian 32 or 64bit indexed bitmaps
> 
> m32r, mips, sh, xtensa:
> 	big-endian 32 or 64bit indexed bitmaps for big-endian mode
> 	little-endian bitmaps for little-endian mode
> 
> Others:
> 	little-endian bitmaps
> 
> In order to move minix bit operations from asm/bitops.h to
> architecture independent code in minix file system, this provides two
> config options.
> 
> CONFIG_MINIX_FS_BIG_ENDIAN_16BIT_INDEXED is only selected by m68k.
> CONFIG_MINIX_FS_NATIVE_ENDIAN is selected by the architectures which
> use native byte order bitmaps (h8300, microblaze, s390, sparc,
> m68knommu, m32r, mips, sh, xtensa).
> The architectures which always use little-endian bitmaps do not select
> these options.
> 
> Finally, we can remove minix bit operations from asm/bitops.h for
> all architectures.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
