Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 19:19:29 +0000 (GMT)
Received: from graphics-muse.com ([198.49.126.30]:57051 "HELO
	graphics-muse.com") by ftp.linux-mips.org with SMTP
	id S8133470AbWAQTTL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 19:19:11 +0000
Received: (qmail 13881 invoked by uid 0); 17 Jan 2006 19:21:58 -0000
Received: from graphics-muse.com (HELO localhost.localdomain) (198.49.126.30)
  by graphics-muse.com (qpsmtpd/0.28) with ESMTP; Tue, 17 Jan 2006 12:21:58 -0700
Subject: Broadcom Bigsur build
From:	"Michael J. Hammel" <mips@graphics-muse.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 17 Jan 2006 12:21:54 -0700
Message-Id: <1137525714.18682.10.camel@europa.cri-dsp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <mips@graphics-muse.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips@graphics-muse.org
Precedence: bulk
X-list: linux-mips

Does anyone have a sample config file for use with 2.6.14.6 that boots a
BigSur board?  I've tried this kernel using the mips patch (via Cross
Linux From Scratch) but the boot locks up right after printing the board
type:

CFE> boot -elf 172.22.251.154:vmlinux-2.6.14.6
Loader:elf Filesys:tftp Dev:eth0 File:172.22.251.154:vmlinux-2.6.14.6
Options:()Loading: 0xffffffff80100000/3596456 0xffffffff8046e0a8/307112
Entry at 0x8043400Closing network.
Starting program at 0x80434000
[RUN!]
Broadcom SiByte BCM1480 S0 (pass1) @ 600 MHz (SB-1A rev 0)
Board type: SiByte BCM91x80A/B (BigSur)

-- 
Michael J. Hammel <mips@graphics-muse.org>
