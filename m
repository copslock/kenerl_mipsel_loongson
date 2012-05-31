Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2012 10:29:50 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:58786 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903595Ab2EaI3q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 May 2012 10:29:46 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4V8TjKv027753;
        Thu, 31 May 2012 09:29:45 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4V8Tiu4027752;
        Thu, 31 May 2012 09:29:44 +0100
Date:   Thu, 31 May 2012 09:29:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/5] Add explicit support YAMON firmware.
Message-ID: <20120531082944.GL30086@linux-mips.org>
References: <1338415855-11401-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1338415855-11401-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33500
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, May 30, 2012 at 05:10:50PM -0500, Steven J. Hill wrote:

Now for the nitpicking :-)

ar7_defconfig breaks with:

  CC      arch/mips/ar7/memory.o
/home/ralf/src/linux/upstream-sfr/arch/mips/ar7/memory.c:33:34: fatal error: asm/mips-boards/prom.h: No such file or directory
compilation terminated.
make[4]: *** [arch/mips/ar7/memory.o] Error 1

db1000_defconfig, db1200_defconfig, db1300_defconfig and db1550_defconfig
breaks with:

  CC      arch/mips/alchemy/common/prom.o
/home/ralf/src/linux/upstream-sfr/arch/mips/alchemy/common/prom.c: In function ‘prom_get_ethernet_addr’:
/home/ralf/src/linux/upstream-sfr/arch/mips/alchemy/common/prom.c:73:2: error: implicit declaration of function ‘prom_getenv’ [-Werror=implicit-function-declaration]
/home/ralf/src/linux/upstream-sfr/arch/mips/alchemy/common/prom.c:73:14: error: assignment makes pointer from integer without a cast [-Werror]
cc1: all warnings being treated as errors
make[4]: *** [arch/mips/alchemy/common/prom.o] Error 1


Test build still running - ENEEDMOREHORSEPOWER ;-)  So far
bcm63xx_defconfig, capcella_defconfig and cavium-octeon_defconfig build ok.

>  arch/mips/include/asm/mipsprom.h                   |    2 -

This is the firmware used by the systems built by MIPS Computer Systems Inc.
and a few very old SGI pre-ARC(S) systems, also some by Pyramid,
Siemens-Nixdorf and others.  It has nothing to do with YAMON.

>  .../mips/include/asm/pmc-sierra/msp71xx/msp_prom.h |   26 -------
>  arch/mips/pmc-sierra/msp71xx/msp_prom.c            |   76 +-----------------
>  arch/mips/pmc-sierra/msp71xx/msp_setup.c           |    2 +-

And these use PMON 2000.  That you found possibilities to share code
beyond YAMON's realm is good but infecting non-YAMON platforms with
YAMON headers isn't.  I suggest to gather code that can kind of code
in arch/mips/lib or a new directory arch/mips/fw/lib.

  Ralf
