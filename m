Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 14:48:21 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51286 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992361AbdKNNsOChNd0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 14:48:14 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vAEDmC8o013829;
        Tue, 14 Nov 2017 14:48:12 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vAEDmCVM013828;
        Tue, 14 Nov 2017 14:48:12 +0100
Date:   Tue, 14 Nov 2017 14:48:12 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@mips.com>
Cc:     Matt Redfearn <matt.redfearn@mips.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-mips@linux-mips.org,
        "# 4 . 11 +" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: indydog: Add dependency on SGI_HAS_INDYDOG
Message-ID: <20171114134812.GF13046@linux-mips.org>
References: <1510656774-31464-1-git-send-email-matt.redfearn@mips.com>
 <20171114111737.GB5823@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114111737.GB5823@jhogan-linux.mipstec.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60918
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

On Tue, Nov 14, 2017 at 11:17:38AM +0000, James Hogan wrote:

> On Tue, Nov 14, 2017 at 10:52:54AM +0000, Matt Redfearn wrote:
> > Commit da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> > enabled building the Indy watchdog driver when COMPILE_TEST is enabled.
> > However, the driver makes reference to symbols that are only defined for
> > certain platforms are selected in the config. These platforms select
> > SGI_HAS_INDYDOG. Without this, link time errors result, for example
> > when building a MIPS allyesconfig.
> > 
> > drivers/watchdog/indydog.o: In function `indydog_write':
> > indydog.c:(.text+0x18): undefined reference to `sgimc'
> > indydog.c:(.text+0x1c): undefined reference to `sgimc'
> > drivers/watchdog/indydog.o: In function `indydog_start':
> > indydog.c:(.text+0x54): undefined reference to `sgimc'
> > indydog.c:(.text+0x58): undefined reference to `sgimc'
> > drivers/watchdog/indydog.o: In function `indydog_stop':
> > indydog.c:(.text+0xa4): undefined reference to `sgimc'
> > drivers/watchdog/indydog.o:indydog.c:(.text+0xa8): more undefined
> > references to `sgimc' follow
> > make: *** [Makefile:1005: vmlinux] Error 1
> > 
> > Fix this by ensuring that CONFIG_INDIDOG can only be selected when the
> > necessary dependent platform symbols are built in.
> > 
> > Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
> > Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> > Cc: <stable@vger.kernel.org> # 4.11 +
> > ---
> > 
> >  drivers/watchdog/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index ca200d1f310a..d96e2e7544fc 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -1451,7 +1451,7 @@ config RC32434_WDT
> >  
> >  config INDYDOG
> >  	tristate "Indy/I2 Hardware Watchdog"
> > -	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
> > +	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST && SGI_HAS_INDYDOG)
> 
> (MIPS && COMPILE_TEST && SGI_HAS_INDYDOG) implies SGI_HAS_INDYDOG
> 
> So I think you can just do:
> -	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
> +	depends on SGI_HAS_INDYDOG
> 
> I.e. COMPILE_TEST isn't of any value in this case.

I agree, due to the references to sgimc this driver will only compile for
the platforms which set SGI_HAS_INDYDOG; MIPS as the dependency is too
generic.

Updated patch for the watchdog maintainers' ease below.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Reported-by: Matt Redfearn <matt.redfearn@mips.com>
Suggested-by: James Hogan <james.hogan@mips.com>

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c722cbfdc7e6..3ece1335ba84 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1451,7 +1451,7 @@ config RC32434_WDT
 
 config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
-	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
+	depends on SGI_HAS_INDYDOG
 	help
 	  Hardware driver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second
