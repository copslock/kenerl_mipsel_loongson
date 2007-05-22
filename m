Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 11:26:23 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:49422 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20022794AbXEVK0T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 May 2007 11:26:19 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id BE2F7D8DA; Tue, 22 May 2007 10:26:04 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 203DD543E0; Tue, 22 May 2007 12:25:39 +0200 (CEST)
Date:	Tue, 22 May 2007 12:25:39 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Chris Dearman <chris@mips.com>, Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: malta broken on mainline
Message-ID: <20070522102538.GY18323@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

malta is broken on mainline.  lmo contain a patch "[MIPS] SOCitSC support"
(which looks okay but mainline has a different change, namely "[MIPS] MT:
Reenable EIC support and add support for SOCit SC" which uses some defines
without updating the header file.

Are you aware of this problem?

http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=d1d5c41425124d5fa4a1ce6a59e13c7da48279c6
vs
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d725cf3818b12a17d78b87a2de19e8eec17126ae


The error I get is:

  CC      arch/mips/mips-boards/malta/malta_int.o
arch/mips/mips-boards/malta/malta_int.c: In function ‘arch_init_irq’:
arch/mips/mips-boards/malta/malta_int.c:314: error: ‘mips_revision_sconid’ undeclared (first use in this function)
arch/mips/mips-boards/malta/malta_int.c:314: error: (Each undeclared identifier is reported only once
arch/mips/mips-boards/malta/malta_int.c:314: error: for each function it appears in.)
arch/mips/mips-boards/malta/malta_int.c:315: error: ‘MIPS_REVISION_SCON_SOCIT’ undeclared (first use in this function)
arch/mips/mips-boards/malta/malta_int.c:316: error: ‘MIPS_REVISION_SCON_ROCIT’ undeclared (first use in this function)
arch/mips/mips-boards/malta/malta_int.c:323: error: ‘MIPS_REVISION_SCON_SOCITSC’ undeclared (first use in this function)
arch/mips/mips-boards/malta/malta_int.c:324: error: ‘MIPS_REVISION_SCON_SOCITSCP’ undeclared (first use in this function)
make[5]: *** [arch/mips/mips-boards/malta/malta_int.o] Error 1

-- 
Martin Michlmayr
http://www.cyrius.com/
