Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 11:29:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44324 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992974AbdDTJ3rW1-ID (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Apr 2017 11:29:47 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3K9TgPd030748;
        Thu, 20 Apr 2017 11:29:42 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3K9TgBf030747;
        Thu, 20 Apr 2017 11:29:42 +0200
Date:   Thu, 20 Apr 2017 11:29:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, kbuild-all@01.org,
        linux-mips@linux-mips.org
Subject: Re: [mips-sjhill:mips-for-linux-next 37/40]
 arch/mips/cavium-octeon/octeon-usb.c:256:12: error: 'union
 cvmx_gpio_bit_cfgx' has no member named 'cn73xx'
Message-ID: <20170420092942.GC28041@linux-mips.org>
References: <201704191014.yOa9zsIb%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201704191014.yOa9zsIb%fengguang.wu@intel.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Apr 19, 2017 at 10:51:24AM +0800, kbuild test robot wrote:

> tree:   git://git.linux-mips.org/pub/scm/sjhill/linux-sjhill.git mips-for-linux-next
> head:   1f658c055f06e85d017652fd9cf0d1253277a316
> commit: 23c1c950836486c2cc15437e2e800c557fa96f21 [37/40] MIPS: Octeon: Remove unused GPIO types and macros.
> config: mips-cavium_octeon_defconfig (attached as .config)
> compiler: mips64-linux-gnuabi64-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 23c1c950836486c2cc15437e2e800c557fa96f21
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/mips/cavium-octeon/octeon-usb.c: In function 'dwc3_octeon_config_power':
> >> arch/mips/cavium-octeon/octeon-usb.c:256:12: error: 'union cvmx_gpio_bit_cfgx' has no member named 'cn73xx'
>        gpio_bit.cn73xx.output_sel = (index == 0 ? 0x14 : 0x15);
>                ^
> >> arch/mips/cavium-octeon/octeon-usb.c:261:12: error: 'union cvmx_gpio_bit_cfgx' has no member named 'cn70xx'
>        gpio_bit.cn70xx.output_sel = (index == 0 ? 0x14 : 0x19);
>                ^
> >> arch/mips/cavium-octeon/octeon-usb.c:264:33: error: implicit declaration of function 'CVMX_GPIO_XBIT_CFGX' [-Werror=implicit-function-declaration]
>        gpio_bit.u64 = cvmx_read_csr(CVMX_GPIO_XBIT_CFGX(gpio));
>                                     ^~~~~~~~~~~~~~~~~~~
>    arch/mips/cavium-octeon/octeon-usb.c:266:12: error: 'union cvmx_gpio_bit_cfgx' has no member named 'cn70xx'
>        gpio_bit.cn70xx.output_sel = (index == 0 ? 0x14 : 0x19);
>                ^
>    cc1: all warnings being treated as errors

I've dropped the offending commit 23c1c9508364 ("MIPS: Octeon: Remove
unused GPIO types and macros.") and the following commit 8ed898353e36
("MIPS: Octeon: Remove unused MIO types and macros.") which was causing

  CC      drivers/net/ethernet/cavium/octeon/octeon_mgmt.o
drivers/net/ethernet/cavium/octeon/octeon_mgmt.c: In function ‘octeon_mgmt_ioctl_hwtstamp’:
drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:707:20: error: ‘CVMX_MIO_PTP_CLOCK_COMP’ undeclared (first use in this function)
     cvmx_write_csr(CVMX_MIO_PTP_CLOCK_COMP, clock_comp);
                    ^
drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:707:20: note: each undeclared identifier is reported only once for each function it appears in
scripts/Makefile.build:294: recipe for target 'drivers/net/ethernet/cavium/octeon/octeon_mgmt.o' failed
make[5]: *** [drivers/net/ethernet/cavium/octeon/octeon_mgmt.o] Error 1

  Ralf
