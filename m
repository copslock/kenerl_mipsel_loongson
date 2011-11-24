Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2011 23:09:06 +0100 (CET)
Received: from moutng.kundenserver.de ([212.227.126.186]:63267 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904619Ab1KXWJC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Nov 2011 23:09:02 +0100
Received: from wuerfel.localnet (port-92-200-107-254.dynamic.qsc.de [92.200.107.254])
        by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
        id 0Lirv8-1QqWxb3mes-00d5x5; Thu, 24 Nov 2011 23:08:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux@openrisc.net,
        linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Lennox Wu <lennox.wu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch@vger.kernel.org, Arend van Spriel <arend@broadcom.com>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Lasse Collin <lasse.collin@tukaani.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        microblaze-uclinux@itee.uq.edu.au, Paul Bolle <pebolle@tiscali.nl>,
        Rob Herring <rob.herring@calxeda.com>,
        Mikael Starvik <starvik@axis.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Franky Lin <frankyl@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Baltieri <fabio.baltieri@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Michael Ellerman <michael@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
        linux-cris-kernel@axis.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Kyle McMartin <kyle@mcmartin.ca>,
        Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH-RFC 02/10] lib: add GENERIC_PCI_IOMAP
Date:   Thu, 24 Nov 2011 23:07:57 +0100
Message-ID: <1564173.bLjG0I2D2P@wuerfel>
User-Agent: KMail/4.7.2 (Linux/3.1.0-rc8nosema+; KDE/4.7.2; x86_64; ; )
In-Reply-To: <b5a1327dd8bb38f87cba7ae10b308ec3b63de66a.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com> <b5a1327dd8bb38f87cba7ae10b308ec3b63de66a.1322163031.git.mst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:EG8dozazYPpsKr6UJtFOn4IfwTCKaaCkCZeDOe2Okjx
 Cc2TasOhfy9zUcOiKOO/P4lBxzfT3wMDoGESgqYTQEy8BURAks
 aHiYWvWNEc/kLykrF2UPTLFDD/9VfjWt9vHwk2+3HJ//OBFEhb
 phThG2+Zp6D5oukiJTckKukA6Uyj7H8OymA4b1BCA7CJ23Oyhb
 dB63p7LQtYJrJ/xwZ5B2imHQQUb0ujoBmKv0Da8NcLOgE8Ykyn
 zjbjZTaiCGBZNL0lQ3qJfnM203vI5Kh2w7TEsv1vxGrmpFBUYj
 EX0pEBeIQlEmE9icwl3ae2LQQJSdUfHn6Z+ZZ6iASvV9cv10c5
 W3ITD/8xeXK/SyLQ3mPg=
X-archive-position: 31989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21120

On Thursday 24 November 2011 22:17:02 Michael S. Tsirkin wrote:
> Many architectures want a generic pci_iomap but
> not the rest of iomap.c. Split that to a separate .c
> file and add a new config symbol. select automatically
> by GENERIC_IOMAP.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Very nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>
