Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Nov 2011 21:12:43 +0100 (CET)
Received: from wolverine01.qualcomm.com ([199.106.114.254]:55458 "EHLO
        wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1905208Ab1K1UMd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Nov 2011 21:12:33 +0100
X-IronPort-AV: E=McAfee;i="5400,1158,6544"; a="141631582"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 28 Nov 2011 12:12:29 -0800
Received: from codeaurora.org (pdmz-snip-v218.qualcomm.com [192.168.218.1])
        by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 9008010004D5;
        Mon, 28 Nov 2011 12:12:27 -0800 (PST)
Date:   Mon, 28 Nov 2011 14:12:26 -0600
From:   Richard Kuo <rkuo@codeaurora.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Paul Bolle <pebolle@tiscali.nl>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <rob.herring@calxeda.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Fabio Baltieri <fabio.baltieri@gmail.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        "John W. Linville" <linville@tuxdriver.com>,
        Lasse Collin <lasse.collin@tukaani.org>,
        Arend van Spriel <arend@broadcom.com>,
        Franky Lin <frankyl@broadcom.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linux@openrisc.net, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH-RFC 01/10] lib: move GENERIC_IOMAP to lib/Kconfig
Message-ID: <20111128201226.GA4296@codeaurora.org>
References: <cover.1322163031.git.mst@redhat.com>
 <5aed7b7e1dbc8a50ebd6986245df8054fd05b7cd.1322163031.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aed7b7e1dbc8a50ebd6986245df8054fd05b7cd.1322163031.git.mst@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 32010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkuo@codeaurora.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 23324

On Thu, Nov 24, 2011 at 10:15:42PM +0200, Michael S. Tsirkin wrote:
> define GENERIC_IOMAP in a central location
> instead of all architectures. This will be helpful
> for the follow-up patch which makes it select
> other configs. Code is also a bit shorter this way.

For the Hexagon config,

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
