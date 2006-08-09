Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 22:06:58 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:24506 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20042657AbWHIVG4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 22:06:56 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GAuH4-0002d0-Ay
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 22:03:30 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GAvHS-0000lG-9F
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 23:07:58 +0200
Date:	Wed, 9 Aug 2006 23:07:58 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060809210758.GB13145@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] 1/7 AU1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bug in SD/MMC command building for the controller fixed.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-mmc-cmd-build-fix

diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index fb60616..b0dc1d0 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -205,6 +205,9 @@ static int au1xmmc_send_command(struct a
 	case MMC_RSP_R3:
 		mmccmd |= SD_CMD_RT_3;
 		break;
+	case MMC_RSP_R6:
+		mmccmd |= SD_CMD_RT_6;
+		break;
 	}
 
 	switch(cmd->opcode) {

--LZvS9be/3tNcYl/X--
