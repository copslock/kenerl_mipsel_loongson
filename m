Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2005 23:56:49 +0000 (GMT)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:64964 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225241AbVBQX4d>;
	Thu, 17 Feb 2005 23:56:33 +0000
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Thu, 17 Feb 2005 15:56:33 -0800
Received: by miles.echelon.com with Internet Mail Service (5.5.2653.19)
	id <19FLM0PK>; Thu, 17 Feb 2005 15:56:30 -0800
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB59016544F9@miles.echelon.com>
From:	Prashant Viswanathan <vprashant@echelon.com>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: dbAu1550: booting linux from flash
Date:	Thu, 17 Feb 2005 15:56:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips

Hi All,

I have a dbAu1550 board running Linux. The way it works now, I have YAMON
booting the kernel via tftp. The kernel itself mounts the root file system
from NAND flash (JFFS2).

How can I use YAMON to copy the kernel image to flash (so that I don't have
to tftp every time)? And what changes would I have to make to the way I
build the "falsh-resident-kernel" (if any)?

Thank you in advance,
Prashant
