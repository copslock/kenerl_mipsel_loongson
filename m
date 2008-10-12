Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Oct 2008 13:19:10 +0100 (BST)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:25288 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S21281668AbYJLMTG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 12 Oct 2008 13:19:06 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 46C045BC027;
	Sun, 12 Oct 2008 15:19:01 +0300 (EEST)
Date:	Sun, 12 Oct 2008 15:18:05 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: mips ip27_defconfig defconfig build error
Message-ID: <20081012121805.GG31153@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Commit 2a31b03335e570dce5fdd082e0d71d48b2cb4290
(MIPS: Rewrite spinlocks to ticket locks.) causes
the following build error with ip27_defconfig:

<--  snip  -->

...
  CC      arch/mips/kernel/module.o
{standard input}: Assembler messages:
{standard input}:1405: Error: local label `"2" (instance number 1 of a fb label)' is not defined
make[2]: *** [arch/mips/kernel/module.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
