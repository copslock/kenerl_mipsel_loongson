Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2006 17:28:53 +0100 (BST)
Received: from mga09.intel.com ([134.134.136.24]:12805 "EHLO
	orsmga102-1.jf.intel.com") by ftp.linux-mips.org with ESMTP
	id S20039250AbWH1Q2u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Aug 2006 17:28:50 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102-1.jf.intel.com with ESMTP; 28 Aug 2006 09:28:38 -0700
Received: from scsmsx331.sc.intel.com (HELO scsmsx331.amr.corp.intel.com) ([10.3.90.4])
  by orsmga001.jf.intel.com with ESMTP; 28 Aug 2006 09:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,176,1154934000"; 
   d="scan'208"; a="116224541:sNHT17283798"
Received: from scsmsx411.amr.corp.intel.com ([10.3.90.30]) by scsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 28 Aug 2006 09:28:37 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions
Date:	Mon, 28 Aug 2006 09:28:35 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A6EA45D@scsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions
Thread-Index: AcbKf1+Osoxfnk1jSIS53JKo+aKT4QAPsuXA
From:	"Luck, Tony" <tony.luck@intel.com>
To:	"Russell King" <rmk+lkml@arm.linux.org.uk>,
	<linux-ia64@vger.kernel.org>, <linux-mips@linux-mips.org>,
	<linuxppc-embedded@ozlabs.org>, <paulkf@microgate.com>,
	<takata@linux-m32r.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Aug 2006 16:28:37.0308 (UTC) FILETIME=[038267C0:01C6CABF]
Return-Path: <tony.luck@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony.luck@intel.com
Precedence: bulk
X-list: linux-mips

> diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c

Acked-by: Tony Luck <tony.luck@intel.com>

[IA-64 part only ... I didn't look at the rest]

-Tony
