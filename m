Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 21:56:15 +0100 (BST)
Received: from atlrel7.hp.com ([156.153.255.213]:45446 "EHLO atlrel7.hp.com")
	by ftp.linux-mips.org with ESMTP id S20031721AbXJWU4F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 21:56:05 +0100
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel7.hp.com (Postfix) with ESMTP id 24C6534B0E;
	Tue, 23 Oct 2007 16:55:17 -0400 (EDT)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp2.fc.hp.com (Postfix) with ESMTP id E7DC223C6F4;
	Tue, 23 Oct 2007 20:55:16 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id B8398134006;
	Tue, 23 Oct 2007 14:55:16 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at ldl.fc.hp.com
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WVNnxDcdyWJW; Tue, 23 Oct 2007 14:55:15 -0600 (MDT)
Received: from localhost.localdomain (lart.fc.hp.com [15.11.146.31])
	by ldl.fc.hp.com (Postfix) with ESMTP id B6931134002;
	Tue, 23 Oct 2007 14:55:15 -0600 (MDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 72A3C13F7D5; Tue, 23 Oct 2007 14:55:15 -0600 (MDT)
Message-Id: <20071023204843.442608289@ldl.fc.hp.com>
User-Agent: quilt/0.45-1
Date:	Tue, 23 Oct 2007 14:48:43 -0600
From:	Bjorn Helgaas <bjorn.helgaas@hp.com>
To:	Alessandro Zummo <a.zummo@towertech.it>
Cc:	Andrew Morton <akpm@linux-foundation.org>
Cc:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: [patch 0/2] RTC fixes
Return-Path: <helgaas@ldl.fc.hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

Here are two fixes:

  - Minor bugfix on error path for mips.
  - If resource request fails, fall back to requesting only the
    ioports we actually use.  This is not a problem yet, but it
    will be if the PNP core claims resources before drivers attach.

--
