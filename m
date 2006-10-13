Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 13:43:09 +0100 (BST)
Received: from relay1.mail.uk.clara.net ([80.168.70.141]:20241 "EHLO
	relay1.mail.uk.clara.net") by ftp.linux-mips.org with ESMTP
	id S20038808AbWJMMmh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 13:42:37 +0100
Received: from [149.254.192.195] (helo=[10.35.226.163])
	by relay1.mail.uk.clara.net with esmtpa (Exim 4.46)
	id 1GYMN1-000M1V-JF
	for linux-mips@linux-mips.org; Fri, 13 Oct 2006 13:42:37 +0100
Message-ID: <452F89B6.7080401@drh-consultancy.demon.co.uk>
Date:	Fri, 13 Oct 2006 13:42:30 +0100
From:	Dr Stephen Henson <lists@drh-consultancy.demon.co.uk>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Problems with UPD61130 bootloader...
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Clara-Relay: Message sent using Claranet Relay Service using auth code: drh
Return-Path: <lists@drh-consultancy.demon.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lists@drh-consultancy.demon.co.uk
Precedence: bulk
X-list: linux-mips

There is an effort underway to port linux to the Topfield TF5800 PVR, it
uses the NEC UPD61130 EMMA2 chipset.

This PVR includes support for running external programs under its
proprietary OS.

For the initial experiments a small linux loader program has been
written similar to the old Windows "loadlin" program. The kernel and
ramdisk is loaded into memory, all running operations halted (as far as
possible), interrupts disabled and finally the kernel and ramdisk copied
to appropriate addresses and executed.

This works part of the time but it is prone to crashing when the kernel
is booted. It is suspected that some interrupt or DMA process is still
running which corrupts memory and it isn't clear how to shut it down.

It seems that documents for this chipset are only available under NDA
from NEC: is that correct?

Does anyone have any details how to "disable everything" or any pointers
to public code which might do that?
