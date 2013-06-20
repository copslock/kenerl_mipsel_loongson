Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 16:48:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56021 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823001Ab3FTOsZQLCxT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jun 2013 16:48:25 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5KEmMkH031398;
        Thu, 20 Jun 2013 16:48:23 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5KEmLtN031397;
        Thu, 20 Jun 2013 16:48:21 +0200
Date:   Thu, 20 Jun 2013 16:48:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jchandra@broadcom.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH UPDATED 4/4] MIPS: Move definition of SMP processor id
 register to header file
Message-ID: <20130620144821.GB30061@linux-mips.org>
References: <1370965298-29210-4-git-send-email-jchandra@broadcom.com>
 <1371559516-4862-1-git-send-email-jchandra@broadcom.com>
 <1371559516-4862-2-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371559516-4862-2-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37059
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

On Tue, Jun 18, 2013 at 06:15:16PM +0530, Jayachandran C wrote:

> The definition of the CP0 register used to save the smp processor
> id is repicated in many files, move them all to thread_info.h.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>

This breaks the ip27_defconfig build:

  AS      arch/mips/kernel/genex.o
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S: Assembler messages:
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:199: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:250: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:334: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:377: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:461: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:462: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:463: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:464: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:465: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:466: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:467: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:468: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:469: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:470: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:471: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:479: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:481: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:482: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:483: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:484: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:546: Error: Illegal operands `dmfc0 $26,$4,0'
/home/ralf/src/linux/upstream-sfr/arch/mips/kernel/genex.S:581: Error: Illegal operands `dmfc0 $26,$4,0'
make[4]: *** [arch/mips/kernel/genex.o] Error 1

So I've removed it again for now.

Maciej, I wonder why does gas in MIPS III/IV mode accept

	dmfc0	$reg1, $cp0reg

but not

	dmfc0	$reg1, $cp0reg, 0

The generated code is the same after all.  Same for MIPS I/II mode and mfc0.

  Ralf
