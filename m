Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g17IkUR30167
	for linux-mips-outgoing; Thu, 7 Feb 2002 10:46:30 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g17IkSA30161
	for <linux-mips@oss.sgi.com>; Thu, 7 Feb 2002 10:46:28 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id KAA20093
	for <linux-mips@oss.sgi.com>; Thu, 7 Feb 2002 10:46:20 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id KAA18070
	for <linux-mips@oss.sgi.com>; Thu, 7 Feb 2002 10:46:20 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g17IjrA14142
	for <linux-mips@oss.sgi.com>; Thu, 7 Feb 2002 19:45:53 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id TAA27734
	for linux-mips@oss.sgi.com; Thu, 7 Feb 2002 19:46:17 +0100 (MET)
Message-Id: <200202071846.TAA27734@copsun18.mips.com>
Subject: madplay on MIPS
To: linux-mips@oss.sgi.com
Date: Thu, 7 Feb 2002 19:46:17 +0100 (MET)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I seem to recall somebody asking about madplay mp3 player about a week
ago. For what it's worth, we just ran mad-0.14.2b on our Malta board
with the 2.4.3 kernel, and it works without a hitch (so far only LE
tested). CPU utilization is around 25% of a 200 MHz CPU.

The soundcard was a Creative SB card, based on the Ensoniq chip and
using the es1371.c driver.

/Hartvig

-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556
