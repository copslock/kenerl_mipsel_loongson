Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2006 21:06:26 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:59106 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133434AbWBGVGP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2006 21:06:15 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k17LB3TR031424;
	Tue, 7 Feb 2006 15:11:14 -0600
Received: from 163.181.22.101 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 07 Feb 2006 15:11:04 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Tue, 7 Feb 2006 13:11:04 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id D71272028; Tue, 7 Feb 2006
 14:11:03 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k17LF0Rw008619; Tue, 7 Feb 2006 14:15:00
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k17LF0tN008618; Tue, 7 Feb 2006 14:15:00 -0700
Date:	Tue, 7 Feb 2006 14:15:00 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	rmk+serial@arm.linux.org.uk
cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] Fix compile error in 8250_au1x00.c
Message-ID: <20060207211500.GC5227@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 07 Feb 2006 21:11:04.0332 (UTC)
 FILETIME=[01478CC0:01C62C2B]
X-WSS-ID: 6FF7D3620BO3597395-01-01
Content-Type: multipart/mixed;
 boundary=YZ5djTAD1cGYuMQK
Content-Disposition: inline
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips


--YZ5djTAD1cGYuMQK
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This patch fixes a compile error when building the 8250_au1x00 driver
for the DB1550, which doesn't have a UART2 defined, resulting in a 
compile error.

There are additional rumors of strangeness on the DB1550, but those
are unsubstantiated at this point.  At least with this patch, it will
compile.

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--YZ5djTAD1cGYuMQK
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=8250_fixup.patch
Content-Transfer-Encoding: 7bit

[PATCH]:  Fixup for the AU1X00 8250 driver

The DB1550 actually doesn't have a UART2.  Remove it from the list.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/serial/8250_au1x00.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250_au1x00.c b/drivers/serial/8250_au1x00.c
index 06ae8fb..8d8d7a7 100644
--- a/drivers/serial/8250_au1x00.c
+++ b/drivers/serial/8250_au1x00.c
@@ -56,7 +56,6 @@ static struct plat_serial8250_port au1x0
 #elif defined(CONFIG_SOC_AU1550)
 	PORT(UART0_ADDR, AU1550_UART0_INT),
 	PORT(UART1_ADDR, AU1550_UART1_INT),
-	PORT(UART2_ADDR, AU1550_UART2_INT),
 	PORT(UART3_ADDR, AU1550_UART3_INT),
 #elif defined(CONFIG_SOC_AU1200)
 	PORT(UART0_ADDR, AU1200_UART0_INT),

--YZ5djTAD1cGYuMQK--
