Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2003 07:36:38 +0100 (BST)
Received: from inspiration-98-179-ban.inspiretech.com ([IPv6:::ffff:203.196.179.98]:52130
	"EHLO smtp.inspirtek.com") by linux-mips.org with ESMTP
	id <S8225305AbTF0Ggf>; Fri, 27 Jun 2003 07:36:35 +0100
Received: from mail.inspiretech.com (mail.inspiretech.com [192.168.42.3])
	by smtp.inspirtek.com (8.12.5/8.12.5) with ESMTP id h5R7Cvvo008528
	for <linux-mips@linux-mips.org>; Fri, 27 Jun 2003 12:43:02 +0530
Message-Id: <200306270713.h5R7Cvvo008528@smtp.inspirtek.com>
Received: from WorldClient [192.168.42.3] by inspiretech.com [192.168.42.3]
	with SMTP (MDaemon.v3.5.7.R)
	for <linux-mips@linux-mips.org>; Fri, 27 Jun 2003 11:58:21 +0530
Date: Fri, 27 Jun 2003 11:58:19 +0530
From: "Ashish anand" <ashish.anand@inspiretech.com>
To: linux-mips@linux-mips.org
Subject: migrating from vxworks to linux...
X-Mailer: WorldClient Standard 3.5.0e
X-MDRemoteIP: 192.168.42.3
X-Return-Path: ashish.anand@inspiretech.com
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
Return-Path: <ashish.anand@inspiretech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashish.anand@inspiretech.com
Precedence: bulk
X-list: linux-mips

Hello,

After my firmware+bsp for linux on mips based L2/L3/L4 switch is over , I
have the requirements for porting huge swithching software in linux.

we have decided to go for switching implementation inside kernel space
using kernel_threads .
for this I though of porting application from vxworks to linux without
changing the architect and core design of application.

my linux version is 2.3.99-pre8.
I realised these application are using posix IPC facilities in vxworks
while I can't use any of them inside linux kernel space using kernel
threads.
examplesake i can use raw semaphore opeartions (up/down) but not like 
SEM_Q_FIFO / SEM_Q_PRIORITY without cosiderable kernel code change.

does this situation demands that my application design has to be changed..
or should I go ahead with writing wrappers for everything seems
unimplemented at kernel level..?


Best Regards,
Ashsih Anand
