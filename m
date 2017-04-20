Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 11:34:02 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44724 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993886AbdDTJdwdwh-D (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Apr 2017 11:33:52 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3K9XonI020472;
        Thu, 20 Apr 2017 11:33:50 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3K9XmPX020471;
        Thu, 20 Apr 2017 11:33:48 +0200
Date:   Thu, 20 Apr 2017 11:33:48 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: next/master build: 206 builds: 2 failed, 204 passed, 9 errors,
 10 warnings (next-20170420)
Message-ID: <20170420093348.GD28041@linux-mips.org>
References: <58f869bd.84a0df0a.dc1f9.4547@mx.google.com>
 <CAK8P3a2uZFGXhNq+nwDQmgzNL5WH0VejQmotUZp3=0fKwsU1=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2uZFGXhNq+nwDQmgzNL5WH0VejQmotUZp3=0fKwsU1=w@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57742
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

On Thu, Apr 20, 2017 at 11:23:03AM +0200, Arnd Bergmann wrote:

> On Thu, Apr 20, 2017 at 9:56 AM, kernelci.org bot <bot@kernelci.org> wrote:
> > next/master build: 206 builds: 2 failed, 204 passed, 9 errors, 10 warnings
> 
> > cavium_octeon_defconfig (mips) — FAIL, 8 errors, 0 warnings, 0 section
> > mismatches
> >
> > Errors:
> > arch/mips/cavium-octeon/octeon-usb.c:256:12: error: 'union
> > cvmx_gpio_bit_cfgx' has no member named 'cn73xx'
> > arch/mips/cavium-octeon/octeon-usb.c:261:12: error: 'union
> > cvmx_gpio_bit_cfgx' has no member named 'cn70xx'
> > arch/mips/cavium-octeon/octeon-usb.c:264:33: error: implicit declaration of
> > function 'CVMX_GPIO_XBIT_CFGX' [-Werror=implicit-function-declaration]
> > arch/mips/cavium-octeon/octeon-usb.c:266:12: error: 'union
> > cvmx_gpio_bit_cfgx' has no member named 'cn70xx'
> 
> Apparently caused by
> 23c1c9508364 ("MIPS: Octeon: Remove unused GPIO types and macros.")
> which was merged last week
> 
> > drivers/net/ethernet/cavium/octeon/octeon_mgmt.c:707:20: error:
> > 'CVMX_MIO_PTP_CLOCK_COMP' undeclared (first use in this function)
> > drivers/watchdog/octeon-wdt-main.c:585:18: error: 'CVMX_MIO_BOOT_LOC_ADR'
> > undeclared (first use in this function)
> > drivers/watchdog/octeon-wdt-main.c:586:18: error: 'CVMX_MIO_BOOT_LOC_DAT'
> > undeclared (first use in this function)
> 
> Same for
> 8ed898353e36 ("MIPS: Octeon: Remove unused MIO types and macros.")

I've dropped both commits a few minutes ago.

  Ralf
