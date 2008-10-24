Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 01:57:39 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3686 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251717AbYJXA53 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:57:29 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d630000>; Thu, 23 Oct 2008 20:57:07 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:06 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:06 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v168005561
	for <linux-mips@linux-mips.org>; Thu, 23 Oct 2008 17:57:01 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v1vW005559
	for linux-mips@linux-mips.org; Thu, 23 Oct 2008 17:57:01 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Subject: [PATCH 00/37] Add Cavium OCTEON processor support.
Date:	Thu, 23 Oct 2008 17:56:24 -0700
Message-Id: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
X-OriginalArrivalTime: 24 Oct 2008 00:57:06.0501 (UTC) FILETIME=[6F810F50:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This patch set introduces preliminary support for Cavium Networks'
OCTEON processor family.  More information about these processors may
be obtained here:

http://www.caviumnetworks.com/OCTEON_MIPS64.html

This initial patch set adds support for booting an initramfs to a
serial console.  Follow-on patch sets will add support for the on-chip
ethernet, USB, PCI, PCIe, I2c and other peripherals.

Patches:
	 1  - 6  add OCTEON specific files.
	 7       generic support for booting processors other than CPU0
	 14      generic cpu_to_name improvements.
	 29 - 32 generic 8250 serial port changes.
	 33      OCTEON serial port additions.
	 34      generic mips dma changes to support these patches.
	 37	 defconfig
	 
The remainder just hook things up.


Feedback certainly welcome,
David Daney
