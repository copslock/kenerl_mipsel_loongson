Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 22:28:21 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:56249 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823426Ab2KMV2UAK9fZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 22:28:20 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 13 Nov 2012 13:28:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,768,1352102400"; 
   d="scan'208";a="241671630"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2012 13:28:12 -0800
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.1.355.2; Tue, 13 Nov 2012 13:28:11 -0800
Received: from orsmsx108.amr.corp.intel.com ([169.254.9.119]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.48]) with mapi id 14.01.0355.002;
 Tue, 13 Nov 2012 13:28:11 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     James Hogan <james.hogan@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "uclinux-dist-devel@blackfin.uclinux.org" 
        <uclinux-dist-devel@blackfin.uclinux.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Frysinger <vapier@gentoo.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Mundt <lethal@linux-sh.org>
Subject: RE: [PATCH 1/1] arch Kconfig: remove references to IRQ_PER_CPU
Thread-Topic: [PATCH 1/1] arch Kconfig: remove references to IRQ_PER_CPU
Thread-Index: AQHNwZaYI0r8PGS1HEq9XKPGYxEB6JfoR+uQ
Date:   Tue, 13 Nov 2012 21:28:11 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F19D5F453@ORSMSX108.amr.corp.intel.com>
References: <1352807948-26920-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1352807948-26920-1-git-send-email-james.hogan@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 34990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony.luck@intel.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

> But IRQ_PER_CPU wasn't removed from any of the architecture Kconfig
> files where it was defined or selected. It's completely unused so remove
> the remaining references.

Acked-by: Tony Luck <tony.luck@intel.com>

[Hope someone picks up this whole patch ... otherwise I can take the ia64 hunk]
