Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 05:17:45 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:22628 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990432AbeC3DRhjvAQG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Mar 2018 05:17:37 +0200
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2018 20:17:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000"; 
   d="gz'50?scan'50,208,50";a="41974514"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga004.fm.intel.com with ESMTP; 29 Mar 2018 20:16:54 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1f1kX8-000RHV-1E; Fri, 30 Mar 2018 11:16:54 +0800
Date:   Fri, 30 Mar 2018 11:16:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Shea Levy <shea@shealevy.com>
Cc:     kbuild-all@01.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        linux-cris-kernel@axis.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
        linux-xtensa@linux-xtensa.org, Albert Ou <albert@sifive.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-m68k@lists.linux-m68k.org, Stafford Horne <shorne@gmail.com>,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Lennox Wu <lennox.wu@gmail.com>, Rob Herring <robh@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-snps-arc@lists.infradead.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-parisc@vger.kernel.org, Rob Landley <rob@landley.net>,
        linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Rich Felker <dalias@libc.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jonas Bonn <jonas@southpole.se>, linux-am33-list@redhat.com,
        Richard Weinberger <richard@nod.at>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Shea Levy <shea@shealevy.com>, Ingo Molnar <mingo@redhat.com>,
        Mark Salter <msalter@redhat.com>,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-s390@vger.kernel.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mikael Starvik <starvik@axis.com>,
        openrisc@lists.librecores.org,
        user-mode-linux-user@lists.sourceforge.net,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Simek <monstr@monstr.eu>,
        Vineet Gupta <vgupta@synopsys.com>,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Message-ID: <201803300916.uTxZY6Kv%fengguang.wu@intel.com>
References: <20180328152714.6103-1-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20180328152714.6103-1-shea@shealevy.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lkp@intel.com
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


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shea,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc7]
[cannot apply to next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shea-Levy/Extract-initrd-free-logic-from-arch-specific-code/20180330-085507
config: m32r-m32104ut_defconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

All warnings (new ones prefixed by >>):

warning: (M32R) selects HAVE_ARCH_FREE_INITRD_MEM which has unmet direct dependencies (BLK_DEV_INITRD)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--d6Gm4EdcadzBjdND
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
3McsSlybIGuuI9r6iXWK/wcmdp8QOrYAAA==

--d6Gm4EdcadzBjdND--
