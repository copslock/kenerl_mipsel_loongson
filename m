Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 11:01:09 +0100 (BST)
Received: from inspiration-98-179-ban.inspiretech.com ([IPv6:::ffff:203.196.179.98]:9354
	"EHLO smtp.inspirtek.com") by linux-mips.org with ESMTP
	id <S8225241AbTFEKBH>; Thu, 5 Jun 2003 11:01:07 +0100
Received: from mail.inspiretech.com (mail.inspiretech.com [192.168.42.3])
	by smtp.inspirtek.com (8.12.5/8.12.5) with ESMTP id h55ARnI9031919
	for <linux-mips@linux-mips.org>; Thu, 5 Jun 2003 15:57:56 +0530
Message-Id: <200306051027.h55ARnI9031919@smtp.inspirtek.com>
Received: from WorldClient [192.168.42.3] by inspiretech.com [192.168.42.3]
	with SMTP (MDaemon.v3.5.7.R)
	for <linux-mips@linux-mips.org>; Thu, 05 Jun 2003 15:16:43 +0530
Date: Thu, 05 Jun 2003 15:16:41 +0530
From: "Ashish anand" <ashish.anand@inspiretech.com>
To: linux-mips@linux-mips.org
Subject: low ram as source of good parity data..?
X-Mailer: WorldClient Standard 3.5.0e
X-MDRemoteIP: 192.168.42.3
X-Return-Path: ashish.anand@inspiretech.com
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
Return-Path: <ashish.anand@inspiretech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish.anand@inspiretech.com
Precedence: bulk
X-list: linux-mips

Hello,

I have seen it a common practice to assume low RAM as source 
of good parity data and use it to fill the caches with good parity 
data in firmware during elementary hardware initialisation process.

why it is always safe to assume that low RAM contains good parity data .?
Is it always true..?
this question came in picture after I got cacheparity error sometimes.

Best Regards,
Ashish Anand
