Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2014 20:22:17 +0200 (CEST)
Received: from smtprelay4.synopsys.com ([198.182.44.111]:43947 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6901552AbaHNSWOHZNkD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Aug 2014 20:22:14 +0200
Received: from us01secmta2.synopsys.com (us01secmta2.synopsys.com [10.9.203.102])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8F24E24E1062;
        Thu, 14 Aug 2014 11:21:59 -0700 (PDT)
Received: from us01secmta2.internal.synopsys.com (us01secmta2.internal.synopsys.com [127.0.0.1])
        by us01secmta2.internal.synopsys.com (Service) with ESMTP id 50236A4102;
        Thu, 14 Aug 2014 11:21:59 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by us01secmta2.internal.synopsys.com (Service) with ESMTP id 76D3EA4114;
        Thu, 14 Aug 2014 11:21:58 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 28DC041D;
        Thu, 14 Aug 2014 11:21:58 -0700 (PDT)
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id EB2853E1;
        Thu, 14 Aug 2014 11:21:48 -0700 (PDT)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.158.1; Thu, 14 Aug 2014 11:21:48 -0700
Received: from IN01WEMBXA.internal.synopsys.com ([fe80::ed6f:22d3:d35:4833])
 by IN01WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0158.001; Thu,
 14 Aug 2014 23:51:45 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Chen Gang <gang.chen.5i5j@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rth@twiddle.net" <rth@twiddle.net>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.de>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        "realmz6@gmail.com" <realmz6@gmail.com>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "a-jacquiot@ti.com" <a-jacquiot@ti.com>,
        "starvik@axis.com" <starvik@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "rkuo@codeaurora.org" <rkuo@codeaurora.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "takata@linux-m32r.org" <takata@linux-m32r.org>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>,
        "jonas@southpole.se" <jonas@southpole.se>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
        "deller@gmx.de" <deller@gmx.de>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        Liqin Chen <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "cmetcalf@tilera.com" <cmetcalf@tilera.com>,
        "jdike@addtoit.com" <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "gxt@mprc.pku.edu.cn" <gxt@mprc.pku.edu.cn>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chris@zankel.net" <chris@zankel.net>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>
CC:     "linux390@de.ibm.com" <linux390@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m32r@ml.linux-m32r.org" <linux-m32r@ml.linux-m32r.org>,
        "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
        "linux@lists.openrisc.net" <linux@lists.openrisc.net>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "user-mode-linux-devel@lists.sourceforge.net" 
        <user-mode-linux-devel@lists.sourceforge.net>,
        "user-mode-linux-user@lists.sourceforge.net" 
        <user-mode-linux-user@lists.sourceforge.net>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
Thread-Topic: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
Thread-Index: AQHPt+CPQyNRLz1f9kGDGhxSg+sSdQ==
Date:   Thu, 14 Aug 2014 18:21:43 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com>
References: <53ECE9DD.80004@gmail.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.9.21.32]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Vineet.Gupta1@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vineet.Gupta1@synopsys.com
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

On Thursday 14 August 2014 09:55 AM, Chen Gang wrote:
> Normal architectures:
>
>  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc
>
>  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
>                   score, unicore32, x86
>
>  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh
>
> Special architectures:
>
>  - Deside by compiler: microblaze, tile, xtensa.
>
>  - Deside by building host: um
>
>  - Next, need improve Kbuild to probe endian to deside whether need mark
>    __BUILDING_TIME_BIG_ENDIAN__ before real config.
>
> Another improvements:
>
>  - score: use '\t' instead of ' '.
>
>  - s390: sort the select value in alpha order.
>
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/alpha/Kconfig      |  1 +
>  arch/arc/Kconfig        |  1 +
>  arch/arm/Kconfig        |  1 +
>  arch/arm64/Kconfig      |  1 +
>  arch/avr32/Kconfig      |  1 +
>  arch/blackfin/Kconfig   |  1 +
>  arch/c6x/Kconfig        |  1 +
>  arch/cris/Kconfig       |  1 +
>  arch/frv/Kconfig        |  1 +
>  arch/hexagon/Kconfig    |  1 +
>  arch/ia64/Kconfig       |  1 +
>  arch/m32r/Kconfig       |  1 +
>  arch/m68k/Kconfig       |  1 +
>  arch/metag/Kconfig      |  1 +
>  arch/microblaze/Kconfig |  2 ++
>  arch/mips/Kconfig       |  1 +
>  arch/mn10300/Kconfig    |  1 +
>  arch/openrisc/Kconfig   |  1 +
>  arch/parisc/Kconfig     |  1 +
>  arch/powerpc/Kconfig    |  1 +
>  arch/s390/Kconfig       |  3 ++-
>  arch/score/Kconfig      | 21 +++++++++++----------
>  arch/sparc/Kconfig      |  1 +
>  arch/tile/Kconfig       |  2 ++
>  arch/um/Kconfig.common  |  2 ++
>  arch/unicore32/Kconfig  |  1 +
>  arch/x86/Kconfig        |  1 +
>  arch/xtensa/Kconfig     |  2 ++
>  init/Kconfig            |  6 ++++++
>  29 files changed, 49 insertions(+), 11 deletions(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index b7ff9a3..1cb7426 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -27,6 +27,7 @@ config ALPHA
>  	select MODULES_USE_ELF_RELA
>  	select ODD_RT_SIGACTION
>  	select OLD_SIGSUSPEND
> +	select CPU_LITTLE_ENDIAN
>  	help
>  	  The Alpha is a 64-bit general-purpose processor designed and
>  	  marketed by the Digital Equipment Corporation of blessed memory,
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 9596b0a..e939abd 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -35,6 +35,7 @@ config ARC
>  	select OF_EARLY_FLATTREE
>  	select PERF_USE_VMALLOC
>  	select HAVE_DEBUG_STACKOVERFLOW
> +	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN

It is not clear what exactly are you trying to fix. What doesn't work w/o this
patch !

-Vineet
