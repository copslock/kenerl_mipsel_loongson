Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 00:08:57 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:25252 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491000Ab1FNWIr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 00:08:47 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 14 Jun 2011 15:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,366,1304319600"; 
   d="scan'208";a="16250488"
Received: from orsmsx603.amr.corp.intel.com ([10.22.226.49])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2011 15:08:38 -0700
Received: from orsmsx505.amr.corp.intel.com ([10.22.226.208]) by
 orsmsx603.amr.corp.intel.com ([10.22.226.49]) with mapi; Tue, 14 Jun 2011
 15:08:38 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Kyle McMartin <kyle@mcmartin.ca>,
        Lennox Wu <lennox.wu@gmail.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Mikael Starvik <starvik@axis.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@arm.linux.org.uk>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
CC:     "microblaze-uclinux@itee.uq.edu.au" 
        <microblaze-uclinux@itee.uq.edu.au>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Date:   Tue, 14 Jun 2011 15:08:37 -0700
Subject: RE: [RFC,PATCH] Cleanup PC parallel port Kconfig
Thread-Topic: [RFC,PATCH] Cleanup PC parallel port Kconfig
Thread-Index: AcwqxtP+0jyIPAsgQYKo7DQ7Gdbl3gAGFmPA
Message-ID: <987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com>
References: <20110614190850.GA13526@linux-mips.org>
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 30388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony.luck@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11922

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 38280ef..849805a 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -23,6 +23,7 @@ config IA64
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DMA_API_DEBUG
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
 	select IRQ_PER_CPU

I took a look at the back of all my ia64 systems - none of them
have a parallel port.  It seems unlikely that new systems will
start adding parallel ports :-)

So even if I had a printer (or other device) that used a parallel
port, I have no way to test it.

-Tony
