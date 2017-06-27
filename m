Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 01:16:37 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#1000 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23993946AbdF0XQabwbkb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 01:16:30 +0200
Date:   Wed, 28 Jun 2017 01:16:29 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     linux-mips@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: BC47xx build errors
Message-ID: <20170627231629.GA5049@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58837
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

A less than smart build test system has flagged the following build error:

  CC      arch/mips/bcm47xx/irq.o
In file included from arch/mips/bcm47xx/irq.c:32:0:
./arch/mips/include/asm/mach-bcm47xx/bcm47xx.h:34:1: error: expected identifier
+before
+‘}’ token
 };

I don't have any .config or anything for this error.  While trying to
reproduce this error I tried to build bcm47xx_defconfig but with
CONFIG_BCM47XX_SSB and CONFIG_BCM47XX_BCMA disabled.  That resulted in
the following build error:

  CC	  arch/mips/bcm47xx/irq.o
In file included from arch/mips/bcm47xx/irq.c:32:0:
./arch/mips/include/asm/mach-bcm47xx/bcm47xx.h:34:1: error: empty enum is
+invalid
 };
 ^
scripts/Makefile.build:302: recipe for target 'arch/mips/bcm47xx/irq.o' failed
make[1]: *** [arch/mips/bcm47xx/irq.o] Error 1
Makefile:1663: recipe for target 'arch/mips/bcm47xx/irq.o' failed

  Ralf
