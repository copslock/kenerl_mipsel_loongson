Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2017 11:59:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60484 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992028AbdCXK70HAPAE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Mar 2017 11:59:26 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2OAxP5b026293;
        Fri, 24 Mar 2017 11:59:25 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2OAxOZM026292;
        Fri, 24 Mar 2017 11:59:24 +0100
Date:   Fri, 24 Mar 2017 11:59:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Remove unused MIO types and macros.
Message-ID: <20170324105924.GA26117@linux-mips.org>
References: <1489068885-9711-1-git-send-email-steven.hill@cavium.com>
 <20170316160219.GL5512@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170316160219.GL5512@linux-mips.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57432
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

On Thu, Mar 16, 2017 at 05:02:19PM +0100, Ralf Baechle wrote:

> Thanks, queued for 4.12.

And dropped again:

[...]
  CC      drivers/net/ethernet/cavium/octeon/octeon_mgmt.o
drivers/net/ethernet/cavium/octeon/octeon_mgmt.c: In function ‘octeon_mgmt_ioctl_hwtstamp’:
drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:707:20: error: ‘CVMX_MIO_PTP_CLOCK_COMP’ undeclared (first use in this function)
     cvmx_write_csr(CVMX_MIO_PTP_CLOCK_COMP, clock_comp);
                    ^
drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:707:20: note: each undeclared identifier is reported only once for each function it appears in
scripts/Makefile.build:294: recipe for target 'drivers/net/ethernet/cavium/octeon/octeon_mgmt.o' failed
make[5]: *** [drivers/net/ethernet/cavium/octeon/octeon_mgmt.o] Error 1
make[5]: Target '__build' not remade because of errors.
scripts/Makefile.build:553: recipe for target 'drivers/net/ethernet/cavium/octeon' failed
make[4]: *** [drivers/net/ethernet/cavium/octeon] Error 2
make[4]: Target '__build' not remade because of errors.
scripts/Makefile.build:553: recipe for target 'drivers/net/ethernet/cavium' failed
make[3]: *** [drivers/net/ethernet/cavium] Error 2
make[3]: Target '__build' not remade because of errors.
scripts/Makefile.build:553: recipe for target 'drivers/net/ethernet' failed
make[2]: *** [drivers/net/ethernet] Error 2
make[2]: Target '__build' not remade because of errors.
scripts/Makefile.build:553: recipe for target 'drivers/net' failed
make[1]: *** [drivers/net] Error 2
  CC      drivers/watchdog/octeon-wdt-main.o
drivers/watchdog/octeon-wdt-main.c: In function ‘octeon_wdt_init’:
drivers/watchdog/octeon-wdt-main.c:585:18: error: ‘CVMX_MIO_BOOT_LOC_ADR’ undeclared (first use in this function)
   cvmx_write_csr(CVMX_MIO_BOOT_LOC_ADR, i * 8);
                  ^
drivers/watchdog/octeon-wdt-main.c:585:18: note: each undeclared identifier is reported only once for each function it appears in
drivers/watchdog/octeon-wdt-main.c:586:18: error: ‘CVMX_MIO_BOOT_LOC_DAT’ undeclared (first use in this function)
   cvmx_write_csr(CVMX_MIO_BOOT_LOC_DAT, ptr[i]);
                  ^
drivers/watchdog/octeon-wdt-main.c:588:17: error: implicit declaration of function ‘CVMX_MIO_BOOT_LOC_CFGX’ [-Werror=implicit-function-declaration]
  cvmx_write_csr(CVMX_MIO_BOOT_LOC_CFGX(0), 0x81fc0000);
                 ^
cc1: some warnings being treated as errors
scripts/Makefile.build:294: recipe for target 'drivers/watchdog/octeon-wdt-main.o' failed
make[2]: *** [drivers/watchdog/octeon-wdt-main.o] Error 1
make[2]: Target '__build' not remade because of errors.
scripts/Makefile.build:553: recipe for target 'drivers/watchdog' failed
make[1]: *** [drivers/watchdog] Error 2
make[1]: Target '__build' not remade because of errors.
Makefile:1002: recipe for target 'drivers' failed
make: *** [drivers] Error 2
make: Target '_all' not remade because of errors.

  Ralf
