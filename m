Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 03:43:55 +0200 (CEST)
Received: from mga06.intel.com ([134.134.136.31]:32339 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990422AbeC3Bnrfd420 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Mar 2018 03:43:47 +0200
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2018 18:43:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000"; 
   d="gz'50?scan'50,208,50";a="29256311"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2018 18:43:29 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1f1j4h-000RCX-Vr; Fri, 30 Mar 2018 09:43:28 +0800
Date:   Fri, 30 Mar 2018 09:43:19 +0800
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
Message-ID: <201803300950.Egf6dCw2%fengguang.wu@intel.com>
References: <20180328152714.6103-1-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
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
X-archive-position: 63351
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


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Shea,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc7]
[cannot apply to next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shea-Levy/Extract-initrd-free-logic-from-arch-specific-code/20180330-085507
config: ia64-allnoconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

warning: (IA64) selects HAVE_ARCH_FREE_INITRD_MEM which has unmet direct dependencies (BLK_DEV_INITRD)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--tThc/1wpZn/ma/RB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
H+DM34itVQAA

--tThc/1wpZn/ma/RB--
