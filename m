Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 11:06:26 +0000 (GMT)
Received: from alpha-bit.de ([217.160.213.225]:2470 "EHLO
	p15137410.pureserver.info") by ftp.linux-mips.org with ESMTP
	id S23261154AbYKFLGX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Nov 2008 11:06:23 +0000
Received: from Porsche (DSL01.83.171.174.98.ip-pool.NEFkom.net [83.171.174.98])
	by p15137410.pureserver.info (Postfix) with ESMTP id 260F580DA12
	for <linux-mips@linux-mips.org>; Thu,  6 Nov 2008 12:06:21 +0100 (CET)
X-KENId: 00002871KEN0FDC4CF3
X-KENRelayed: 00002871KEN0FDC4CF3@Porsche
Received: from [192.168.0.160]
   by KEN (4.00.93-v070725) with SMTP
   ; Thu, 6 Nov 2008 12:06:27 +0100
Date:	Thu, 06 Nov 2008 12:06:15 +0100
From:	Martin Gebert <martin.gebert@alpha-bit.de>
Subject: AU1000: SSI0 naming inconsistency
To:	linux-mips@linux-mips.org
Message-Id: <4912CFA7.9000508@alpha-bit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KENRecTime: 1225969587
Content-Transfer-Encoding: 7bit
User-Agent: Thunderbird 2.0.0.17 (X11/20080929)
Return-Path: <martin.gebert@alpha-bit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.gebert@alpha-bit.de
Precedence: bulk
X-list: linux-mips

Hi!

Working on a 2.6.22 kernel for a AU1100 board, I came across the
following inconsistency in register naming in
include/asm/mach-au1x00/au1000.h, which still exists in 2.6.27.4 (lines 
1334-1389). There's no register SSI0_CONTROL, it should be named
SSI0_ENABLE, as it is for SSI1:

--8><--
#define SSI0_CONTROL               0xB1600100
  #define SSI_CONTROL_CD             (1<<1)
  #define SSI_CONTROL_E              (1<<0)

/* SSI1 */
[...]
#define SSI1_ENABLE                0xB1680100

[...]
#define SSI_ENABLE_CD               (1<<1)
#define SSI_ENABLE_E                (1<<0)
--><8--

As I'm not working on a current kernel repo I don't dare to provide a
patch. Would fixing this be desirable?

Martin
