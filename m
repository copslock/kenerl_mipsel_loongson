Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 22:48:02 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:15377 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3458400AbWAWWrn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 22:47:43 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B7C7D64D3D; Mon, 23 Jan 2006 22:51:19 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id BFEF48D2D; Mon, 23 Jan 2006 22:50:40 +0000 (GMT)
Date:	Mon, 23 Jan 2006 22:50:40 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: DECstation R3000 boot error
Message-ID: <20060123225040.GA23576@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

We're getting the following boot error on a DECstation with R3K CPU.
It simply hangs after the "high precision timer" message.  Maciej, do
you have some time to look into this issue, or does anyone else have
any idea what's going on there?

This is with current git.


Linux version 2.6.15 (tbm@deprecation) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #2 Mon Jan 23 12:41:27 GMT 2006
This is a DECstation 5000/2x0
CPU revision is: 00000230
FPU revision is: 00000340
Determined physical RAM map:
 memory: 0c000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: rd_start=2154876928 rd_size=
Primary instruction cache 64kB, linesize 4 bytes.
Primary data cache 64kB, linesize 4 bytes.
Synthesized TLB refill handler (17 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (25 instructions).
PID hash table entries: 1024 (order: 10, 16384 bytes)
Using 24.999 MHz high precision timer.�

-- 
Martin Michlmayr
http://www.cyrius.com/
