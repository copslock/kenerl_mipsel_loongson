Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3MElJqf031266
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Apr 2002 07:47:19 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3MElJ6u031265
	for linux-mips-outgoing; Mon, 22 Apr 2002 07:47:19 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3MElFqf031260
	for <linux-mips@oss.sgi.com>; Mon, 22 Apr 2002 07:47:15 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id HAA04236
	for <linux-mips@oss.sgi.com>; Mon, 22 Apr 2002 07:47:37 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA05701
	for <linux-mips@oss.sgi.com>; Mon, 22 Apr 2002 07:47:38 -0700 (PDT)
Received: from copsun17.mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g3MEklA04371
	for <linux-mips@oss.sgi.com>; Mon, 22 Apr 2002 16:46:47 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun17.mips.com (8.9.1/8.9.0) id QAA23835
	for linux-mips@oss.sgi.com; Mon, 22 Apr 2002 16:46:45 +0200 (MET DST)
Message-Id: <200204221446.QAA23835@copsun17.mips.com>
Subject: Problems with H.J's latest RPM 4.0.4 binary packages
To: linux-mips@oss.sgi.com (user alias)
Date: Mon, 22 Apr 2002 16:46:45 +0200 (MET DST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have started to update our 7.1 RH/MIPS installation images with all the
latest packages from H.J's collection.

The latest RPM package gives an up-front error no matter what one does, but
the command seems to work:

[hartvige@copmalt13 /bin]$ rpm --version
error: Macro %__id_u has empty body
RPM version 4.0.4
[hartvige@copmalt13 /bin]$

Before I start digging any deeper, has anybody else seen this and found the
explanation?

(Note that I have not yet finished compiling the glibc RPM natively as
required - this is currently ongoing).

/Hartvig

-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556
