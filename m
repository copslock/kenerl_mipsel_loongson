Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2006 22:57:29 +0000 (GMT)
Received: from firewall.dcbnet.com ([12.96.67.19]:26092 "EHLO
	firewall.dcbnet.com") by ftp.linux-mips.org with ESMTP
	id S8133857AbWCVW5U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Mar 2006 22:57:20 +0000
Received: from mschank.dcbnet.com (mschank.dcbnet.com [205.166.54.128])
	by firewall.dcbnet.com (8.12.10/8.12.10) with ESMTP id k2MN77i7027108
	for <linux-mips@linux-mips.org>; Wed, 22 Mar 2006 17:07:09 -0600
Message-Id: <5.1.0.14.2.20060322165104.02a32800@205.166.54.3>
X-Sender: mschank@205.166.54.3
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date:	Wed, 22 Mar 2006 17:08:29 -0600
To:	linux-mips@linux-mips.org
From:	Mark Schank <mschank@dcbnet.com>
Subject: Alchemy Au1550 Early Console
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-Path: <mschank@dcbnet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschank@dcbnet.com
Precedence: bulk
X-list: linux-mips

Greetings,

I am working with a Au1550 based system an am trying to upgrade
from the 2.6.12 kernel to the 2.6.16 kernel .  I have noticed that the
au1x00_uart.c driver has been remove and replaced with functionality in
8250.c and 8250_au1x00.c.  So far, I have been unable to get the early
console running.  Under this new driver model, what is the proper
way to bring up an early console on a Au1550 internal serial port?

Any guidance would be appreciated.
-Mark
