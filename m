Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2007 13:03:41 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:30995 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20021599AbXFUMDP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2007 13:03:15 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1I1LKY-0001UG-00
	for <linux-mips@linux-mips.org>; Thu, 21 Jun 2007 13:00:06 +0100
Received: from hendon.mips.com ([192.168.192.184] helo=localhost.localdomain)
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1I1LKQ-0001Pd-00
	for <linux-mips@linux-mips.org>; Thu, 21 Jun 2007 12:59:58 +0100
From:	chris@mips.com
To:	linux-mips@linux-mips.org
Subject: Timer/Performance interrupt fixups
Date:	Thu, 21 Jun 2007 12:59:56 +0100
Message-Id: <11824271984112-git-send-email-chris@mips.com>
X-Mailer: git-send-email 1.4.3.GIT
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: chris@mips.com
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

There were a couple of problems with the patch you committed last night
