Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2003 06:58:00 +0100 (BST)
Received: from inspiration-98-179-ban.inspiretech.com ([IPv6:::ffff:203.196.179.98]:16003
	"EHLO smtp.inspirtek.com") by linux-mips.org with ESMTP
	id <S8225193AbTEUF55>; Wed, 21 May 2003 06:57:57 +0100
Received: from mail.inspiretech.com (mail.inspiretech.com [192.168.42.3])
	by smtp.inspirtek.com (8.12.5/8.12.5) with ESMTP id h4L6HqI9006634
	for <linux-mips@linux-mips.org>; Wed, 21 May 2003 11:48:04 +0530
Message-Id: <200305210618.h4L6HqI9006634@smtp.inspirtek.com>
Received: from WorldClient [192.168.42.3] by inspiretech.com [192.168.42.3]
	with SMTP (MDaemon.v3.5.7.R)
	for <linux-mips@linux-mips.org>; Wed, 21 May 2003 11:16:50 +0530
Date: Wed, 21 May 2003 11:16:49 +0530
From: "Ashish anand" <ashish.anand@inspiretech.com>
To: linux-mips@linux-mips.org
Subject: Any complications of using CONFIG_MIPS_UNCACHED..?
X-Mailer: WorldClient Standard 3.5.0e
X-MDRemoteIP: 192.168.42.3
X-Return-Path: ashish.anand@inspiretech.com
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
Return-Path: <ashish.anand@inspiretech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish.anand@inspiretech.com
Precedence: bulk
X-list: linux-mips

Hello,

I saw a good bit of discussion about CONFIG_MIPS_UNCACHED but
still i am yet to know...

If I want to use CONFIG_MIPS_UNCACHED (ignoring performance)
what all the side-effects and any restrictions that linux should
take care in software ?

I observed something surprising on my R4k mips system(virtually indexed
caches), after i use this option my driver never got status updation by
device in transmit and receive decriptors in system memory , Irrespective
of I (flushed+invalidate) caches or not...

if i don't use CONFIG_MIPS_UNCACHED then before checking status I need to 
(flush+invalidate) cache and whole thing works great...

Regards,
Ashish
