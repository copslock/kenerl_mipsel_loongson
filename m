Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 16:50:43 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:38669 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20038550AbWJRPuf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Oct 2006 16:50:35 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E343064D3E; Wed, 18 Oct 2006 15:50:23 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id C4ADD54C3F; Wed, 18 Oct 2006 16:50:09 +0100 (BST)
Date:	Wed, 18 Oct 2006 16:50:09 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: start_kernel(): bug: interrupts were enabled early
Message-ID: <20061018155009.GA22031@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I see the following message when I boot a 2.6.18 kernel on a SWARM
board:

PID hash table entries: 4096 (order: 12, 32768 bytes)
Using 512.000 MHz high precision timer.
start_kernel(): bug: interrupts were enabled early <--
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)

Has anyone else seen this?
-- 
Martin Michlmayr
http://www.cyrius.com/
