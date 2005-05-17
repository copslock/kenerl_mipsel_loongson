Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2005 12:21:25 +0100 (BST)
Received: from cygnus.izmiran.rssi.ru ([IPv6:::ffff:193.232.24.21]:15796 "EHLO
	cygnus.izmiran.rssi.ru") by linux-mips.org with ESMTP
	id <S8226198AbVEQLVK>; Tue, 17 May 2005 12:21:10 +0100
Received: from [127.0.0.1] (IDENT:10003@localhost [127.0.0.1])
	by cygnus.izmiran.rssi.ru (8.12.4/8.12.4) with ESMTP id j4HBKscs019966
	for <linux-mips@linux-mips.org>; Tue, 17 May 2005 15:20:59 +0400
Date:	Tue, 17 May 2005 14:22:17 +0300
From:	"Ruslan V.Pisarev" <jerry@izmiran.rssi.ru>
X-Mailer: The Bat! (v3.0.1.33) Professional
Reply-To: "Ruslan V.Pisarev" <jerry@izmiran.rssi.ru>
Organization: Home
X-Priority: 3 (Normal)
Message-ID: <1547700103.20050517142217@izmiran.rssi.ru>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: au1200 status
MIME-Version: 1.0
Content-Type: text/plain; charset=Windows-1251
Content-Transfer-Encoding: 8bit
Return-Path: <jerry@izmiran.rssi.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerry@izmiran.rssi.ru
Precedence: bulk
X-list: linux-mips

  Hello all

  Dealing with my new DBau1200 board and last 2.6 kernel I found that
there's a few things came into from 2.4 kernel, which is distributed
by AMD with this board. In 2.6 we have no ethernet driver (thanks to
Pete I solved this issue (temporarily?)), furthermore we have no LCD
driver, no sound driver, etc... What status of it? Will these drivers
migrate from 2.4 to 2.6 tree (and how soon?)  Or there's something
different politics?

  Some time ago I saw a old report for some au1* boards usability and
patches for them - maybe I should look for them?

  In addition, somewhere I met the info that such things like MAE,
AES, MTD drivers must be done (by AMD?) in 1st quarter 2005. Anyhow, I
see no any info about them.. Did I missed something?



   ()_()
--( °,° )---[21398845]-[jerry¤wicomtechnologies.com]-
  (") (")                 -<The Bat! 3.0.1.33>- -<17/05/2005 14:05>-
