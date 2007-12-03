Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 17:01:13 +0000 (GMT)
Received: from mga02.intel.com ([134.134.136.20]:35318 "EHLO mga02.intel.com")
	by ftp.linux-mips.org with ESMTP id S20026145AbXLCRBF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Dec 2007 17:01:05 +0000
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 03 Dec 2007 09:00:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.23,244,1194249600"; 
   d="scan'208";a="286035360"
Received: from fmsmsx334.amr.corp.intel.com ([132.233.42.1])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2007 09:00:57 -0800
Received: from scsmsx411.amr.corp.intel.com ([10.3.90.30]) by fmsmsx334.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 3 Dec 2007 09:00:50 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/2] MIPS: vmlinux.lds.S: handle .{init,exit}.bss sections
Date:	Mon, 3 Dec 2007 09:00:49 -0800
Message-ID: <617E1C2C70743745A92448908E030B2A030FE4C2@scsmsx411.amr.corp.intel.com>
In-Reply-To: <1196543586-6698-3-git-send-email-fbuihuu@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] MIPS: vmlinux.lds.S: handle .{init,exit}.bss sections
Thread-Index: Acg0Xwu30WWAvFsLTfOiwZEntWZUcQBblNdw
References: <1196543586-6698-1-git-send-email-fbuihuu@gmail.com> <1196543586-6698-3-git-send-email-fbuihuu@gmail.com>
From:	"Luck, Tony" <tony.luck@intel.com>
To:	"Franck Bui-Huu" <fbuihuu@gmail.com>, <linux-arch@vger.kernel.org>
Cc:	<macro@linux-mips.org>, <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 03 Dec 2007 17:00:50.0677 (UTC) FILETIME=[0EBB9A50:01C835CE]
Return-Path: <tony.luck@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony.luck@intel.com
Precedence: bulk
X-list: linux-mips

+	/*
+	 * We keep init/exit bss sections here to have only one
+	 * segment to load. Note that .bss.exit is also discarded
+	 * at runtime for the same reason as above.
+	 */
+	.exit.bss : {
+		*(.bss.exit)
+	}

This change would also require an audit of the bootloader or early
kernel initialization code (whichever handles zeroing of .bss space)
to make sure that it understands that the kernel will now have an
extra block of memory that needs to be cleared.  Perhaps nothing
needs to be done if the code already handled the general case of
loading an ELF binary with some sections that have an in-memory
size bigger than the on-disk size.  But worth looking at in case
the code makes an assumption about what needs to be zeroed.

-Tony
