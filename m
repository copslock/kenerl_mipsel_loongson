Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2015 18:12:44 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:40881 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012856AbbBPRMmkfS4r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Feb 2015 18:12:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=n9qe+9Nv4L/5ZynE6OpR/bs56nCt7cixNvZ/VEFo01w=;
        b=lEZiUMi7Ceo+BkL7zGvwnMBmsn5x5H0V8W5np/Q+8oD+RVMrDToJIWCCOlF8XHNkleirhIxQBbqJYadNz7939VPNJfU1HdfnrlFQ5TaSJ5gnY5w6F6ykW+UcET3ldg+gqzvZOdml0k0zgW2huapWNV7PEuKVe4+lD1PxqlCcbus=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YNPDo-001NIM-Gr
        for linux-mips@linux-mips.org; Mon, 16 Feb 2015 17:12:36 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:52612 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YNPDT-001N1a-Go; Mon, 16 Feb 2015 17:12:16 +0000
Date:   Mon, 16 Feb 2015 09:12:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        baspeters93@gmail.com
Subject: Re: linux-next: Tree for Feb 16
Message-ID: <20150216171213.GA2804@roeck-us.net>
References: <20120216164144.35e98f5ee8f1b1f545406309@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120216164144.35e98f5ee8f1b1f545406309@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020206.54E22504.01CD,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
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
X-archive-position: 45829
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

On Thu, Feb 16, 2012 at 04:41:44PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20120215:
> 
> The net-net tree gained conflicts against the net and wireless trees.
> 
> The fbdev tree gained a build failure for which I reverted a commit.
> 
> I reverted a commit from the rr tree that causes build failures on some
> PowerPC builds.
> 
> The oprofile tree lost its conflict.
> 
> The staging tree gained a build failure so I used the version from
> next-20120215.
> 
> The akpm tree gained a conflict against the wireless tree.  I also
> reverted a patch that caused boot failures on (at least) some PowerPC
> servers.
> 
> ----------------------------------------------------------------------------
> 
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" as mentioned in the FAQ on the wiki
> (see below).
> 
---
[ Trying again, this time hopefully replying to the correct e-mail.
  Sorry for the earlier noise. ]

---

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
