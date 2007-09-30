Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2007 10:54:42 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:42751 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20025704AbXI3Jyd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2007 10:54:33 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id l8U9sNWq009223;
	Sun, 30 Sep 2007 02:54:23 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 02:54:23 -0700
Received: from [128.224.162.179] ([128.224.162.179]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 02:54:22 -0700
Message-ID: <46FF723E.10408@windriver.com>
Date:	Sun, 30 Sep 2007 17:54:06 +0800
From:	Mark Zhan <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5.0.13 (X11/20070824)
MIME-Version: 1.0
To:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
CC:	ralf@linux-mips.org, a.zummo@towertech.it,
	rongkai.zhan@windriver.com
Subject: [PATCH 0/4] Sibyte 1250/1x80 I2C and RTC cleanup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2007 09:54:22.0597 (UTC) FILETIME=[E09C7350:01C80347]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

These four patches are related with MIPS Sibyte 1250/1x80 I2C and RTC:

1) i2c-sibyte.diff: rework the sibyte i2c adapter driver with 2.6.x style binding model
2) rtc-m41t80.diff: This patch makes m41t80 RTC driver also can work with the SMBus adapters (such as: sibyte i2c 
adapter), which doesn't i2c_transfer() method.
3) rtc-xicor1241.diff: The xicor 1241 RTC driver.
4) swarm-rtc-cleanup: Remove the legacy RTC codes of MIPS sibyte boards, which are replaced by new RTC class drivers. 
And a board init routine is added to register sibyte platform devices
