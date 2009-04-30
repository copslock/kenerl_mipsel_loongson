Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2009 01:00:03 +0100 (BST)
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:61118 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S28573947AbZD3X7g (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2009 00:59:36 +0100
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n3UNrV8C016871;
	Thu, 30 Apr 2009 19:53:32 -0400 (EDT)
Received: from localhost (c-67-186-133-195.hsd1.ma.comcast.net [67.186.133.195])
	(authenticated bits=0)
        (User authenticated as tabbott@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n3UNrUUe011393;
	Thu, 30 Apr 2009 19:53:30 -0400 (EDT)
From:	Tim Abbott <tabbott@MIT.EDU>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Anders Kaseorg <andersk@mit.edu>,
	Waseem Daher <wdaher@mit.edu>,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Jeff Arnold <jbarnold@mit.edu>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Tim Abbott <tabbott@mit.edu>
Subject: [PATCH 0/4] section name cleanup for mips
Date:	Thu, 30 Apr 2009 19:53:26 -0400
Message-Id: <1241135610-9012-1-git-send-email-tabbott@mit.edu>
X-Mailer: git-send-email 1.6.2.1
X-Scanned-By: MIMEDefang 2.42
Return-Path: <tabbott@MIT.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tabbott@MIT.EDU
Precedence: bulk
X-list: linux-mips

This patch series cleans up the section names on the mips
architecture.  It requires the architecture-independent macro
definitions from this patch series:

<http://www.spinics.net/lists/mips/msg33499.html>

The long-term goal here is to add support for building the kernel with
-ffunction-sections -fdata-sections.  This requires renaming all the
magic section names in the kernel of the form .text.foo, .data.foo,
.bss.foo, and .rodata.foo to not have collisions with sections
generated for code like:

static int nosave = 0; /* -fdata-sections places in .data.nosave */
static void head(); /* -ffunction-sections places in .text.head */

Note that these patches have not been boot-tested (aside from testing
the analogous changes on x86), since I don't have access to the
appropriate hardware.

	-Tim Abbott


Tim Abbott (4):
  mips: use NOSAVE_DATA macro for .data.nosave section.
  mips: use new macro for .data.cacheline_aligned section.
  mips: use new macros for .data.init_task.
  mips: use .text, not .text.start, for lasat boot loader.

 arch/mips/kernel/init_task.c           |    5 ++---
 arch/mips/kernel/vmlinux.lds.S         |   19 +++----------------
 arch/mips/lasat/image/head.S           |    2 +-
 arch/mips/lasat/image/romscript.normal |    2 +-
 4 files changed, 7 insertions(+), 21 deletions(-)
