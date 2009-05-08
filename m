Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 07:31:38 +0100 (BST)
Received: from sitar.i-cable.com ([203.83.115.100]:47903 "HELO
	sitar.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S20023603AbZEHGap (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2009 07:30:45 +0100
Received: (qmail 803 invoked by uid 508); 8 May 2009 06:30:36 -0000
Received: from 203.83.114.121 by sitar (envelope-from <r0bertz@gentoo.org>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/8786.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.066473 secs); 08 May 2009 06:30:36 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 8 May 2009 06:30:35 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n486UVwi000812;
	Fri, 8 May 2009 14:30:35 +0800 (HKT)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH 0/3] Added uncached accelerated CPU feature
Date:	Fri,  8 May 2009 14:30:00 +0800
Message-Id: <cover.1241764064.git.r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.2.3
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

This patchset adds uncached accelerated CPU feature and handles write_combine
parameter in pci_mmap_page_range function.

Zhang Le (3):
  MIPS: added cpu_has_uncached_accelerated feature
  MIPS: Loongson 2 has cpu_has_uncached_accelerated feature
  MIPS: handle write_combine in pci_mmap_page_range

 arch/mips/include/asm/cpu-features.h               |    4 ++++
 arch/mips/include/asm/cpu.h                        |    1 +
 .../asm/mach-lemote/cpu-feature-overrides.h        |    1 +
 arch/mips/kernel/cpu-probe.c                       |    4 ++--
 arch/mips/pci/pci.c                                |    8 ++++++--
 5 files changed, 14 insertions(+), 4 deletions(-)
