Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2015 16:36:44 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:56944 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012844AbbBPPgnLSmGG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Feb 2015 16:36:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=2PNRA3R04IO61I9p+OqENL4drKcIES93D9Kefk8/ztI=;
        b=Z6fnwXfNHrrZQC6C4nPVqNm4pHzjVw1fZtLYoBfMm+xEoSCTExOtwREiTAJroka4Psoy+aLiM4XTb+h/tn7mLqRqYKM2X1X2X2jEYkEfSC8aly2ivM8l7WL+8TisPT8jk0UPISVxxYr3164V3JccDwEDoeqGhLAnxPKxXsO03bY=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YNNiu-000RJp-Q0
        for linux-mips@linux-mips.org; Mon, 16 Feb 2015 15:36:36 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:52233 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YNNih-000RB4-DU; Mon, 16 Feb 2015 15:36:23 +0000
Date:   Mon, 16 Feb 2015 07:36:21 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: linux-next: Tree for Jan 16 (mips build errors due to MIPSR6
 patches)
Message-ID: <20150216153621.GA32020@roeck-us.net>
References: <20150116194757.22f54b3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150116194757.22f54b3d@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020205.54E20E84.04F0,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 5
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Fri, Jan 16, 2015 at 07:47:57PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20150115:
> 
> The i2c tree gained a build failure so I used the version from
> next-20150115.
> 
> The wireless-drivers-next tree gained a conflict against the
> wireless-drivers tree.
> 
> The usb-gadget tree gained a conflict against the usb.current tree.
> 
> Non-merge commits (relative to Linus' tree): 3219
>  3111 files changed, 98486 insertions(+), 52594 deletions(-)
> 
> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
> 
Today's tree has a number of new mips related build errors.

Building mips:defconfig ... failed
Building mips:allmodconfig ... failed

Error log:
In file included from ./arch/mips/include/asm/sgiarcs.h:16:0,
                 from ./arch/mips/include/asm/sgialib.h:15,
		 from arch/mips/sgi-ip22/ip22-mc.c:16:
./arch/mips/include/asm/fw/arc/types.h:18:15: error: expected identifier or '(' before '.' token
(more of those)

In file included from ./arch/mips/include/asm/sgialib.h:15:0,
                 from arch/mips/sgi-ip22/ip22-mc.c:16:
./arch/mips/include/asm/sgiarcs.h:89:2: error: unknown type name '_PULONG'
./arch/mips/include/asm/sgiarcs.h:188:2: error: expected specifier-qualifier-list before '.' token
./arch/mips/include/asm/sgiarcs.h:252:2: error: unknown type name '_PLONG'
(more of those)

In file included from arch/mips/sgi-ip22/ip22-mc.c:16:0:
./arch/mips/include/asm/sgialib.h:20:8: error: expected identifier or '(' before '.' token
(more or those)

---
Bisect points to commit 9119e8276d ("MIPS: asm: hazards: Add MIPSR6
definitions"). Looking into the patch, I wonder if the following is correct.

-#if defined(CONFIG_CPU_MIPSR2) && !defined(CONFIG_CPU_CAVIUM_OCTEON)
+#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) && !defined(CONFIG_CPU_CAVIUM_OCTEON)

This change appears to be missing a ( ) around the first two defined()
statements. Fixing that doesn't resolve the problem, though. Reverting
the patch doesn't fix the problem either, so something else must be wrong.

-----------------
Building mips:cavium_octeon_defconfig ... failed

Error log:
arch/mips/kernel/branch.c: In function '__compute_return_epc_for_insn':
arch/mips/kernel/branch.c:785:2: error: duplicate case value
arch/mips/kernel/branch.c:753:2: error: previously used here
arch/mips/kernel/branch.c:808:2: error: duplicate case value
arch/mips/kernel/branch.c:769:2: error: previously used here
arch/mips/kernel/branch.c:818:2: error: duplicate case value
arch/mips/kernel/branch.c:761:2: error: previously used here
arch/mips/kernel/branch.c:826:2: error: duplicate case value
arch/mips/kernel/branch.c:776:2: error: previously used here

----
Bisect points to commit 2f1da3620ff2 ("MIPS: Emulate the new MIPS R6 branch
compact (BC) instruction"). Looking into the code, the patch quite obviously
conflicts with cavium support.

Guenter
