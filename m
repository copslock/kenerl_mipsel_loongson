Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAAFLEm24819
	for linux-mips-outgoing; Sat, 10 Nov 2001 07:21:14 -0800
Received: from mail.talknet.de (smtp01.talknet.de [195.252.142.71])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAAFLA024816
	for <linux-mips@oss.sgi.com>; Sat, 10 Nov 2001 07:21:10 -0800
Received: from chef-host (a1as12-p163.mch.tli.de [195.252.166.163])
	by mail.talknet.de (8.11.0/8.11.0) with ESMTP id fAAFL0m12814
	for <linux-mips@oss.sgi.com>; Sat, 10 Nov 2001 16:21:02 +0100 (MET)
X-Delivered-To: <<linux-mips@oss.sgi.com>>
Received: from localhost (master@localhost [127.0.0.1])
	by chef-host (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA02511
	for <linux-mips@oss.sgi.com>; Sat, 10 Nov 2001 17:09:47 +0100
Date: Sat, 10 Nov 2001 17:09:47 +0100 (MET)
From: Alexander Reil <master@talknet.de>
X-Sender: master@chef-host
Reply-To: alexreil@talknet.de
To: linux-mips@oss.sgi.com
Subject: RM200 and bootp
Message-ID: <Pine.LNX.4.10.10111101643500.2449-100000@chef-host>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

i try to run my rm200 with linux. I installed bootpd on my
intel-server, but my rm200 can't find my bootp-server. 

--- schnipp ---
Pandora> boot bootp()/vmlinux
pandora: kernel file is `bootp()/vmlinux'
No server for vmlinux
Unable to open kernel file bootp()/vmlinux
--- schnapp ---

Is the command
boot bootp()/vmlinux
correct?

my /etc/bootptab:

.global:sm=255.255.255.0:hd=/tftpboot:
mipsel:tc=.global:ht=ethernet:ha=0000e4040ba5:ip=192.168.1.5:bf=vmlinux:

bootpd is running.

Any hints?
Thanks in advance,

Alexander
