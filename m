Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5EBmLnC003706
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 14 Jun 2002 04:48:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5EBmLXQ003705
	for linux-mips-outgoing; Fri, 14 Jun 2002 04:48:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ws3-3.us4.outblaze.com (205-158-62-93.outblaze.com [205.158.62.93])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5EBmInC003701
	for <linux-mips@oss.sgi.com>; Fri, 14 Jun 2002 04:48:18 -0700
Received: (qmail 16385 invoked by uid 1001); 14 Jun 2002 11:50:49 -0000
Message-ID: <20020614115049.16384.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Received: from [202.140.142.131] by ws3-3.us4.outblaze.com with http for
    domca_psg@email.com; Fri, 14 Jun 2002 06:50:49 -0500
From: "Domcan Sami" <domca_psg@email.com>
To: linux-mips@oss.sgi.com, linux-kernel@vger.kernel.org,
   redhat-list@redhat.com
Date: Fri, 14 Jun 2002 06:50:49 -0500
Subject: Kernel - arch support(mips)
X-Originating-Ip: 202.140.142.131
X-Originating-Server: ws3-3.us4.outblaze.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,

I am trying to compile a program using a MIPS-LINUX cross compiler(gcc). I've set up a connection between my i386 Linux machine and a MIPS(RM7000) processor. This is again connected to a WinNT Terminal where there should be an output from the MIPS processor.

I have 2 kernels in my Linux machine under the directories:
1) /usr/src/linux - kernel version 2.2.14
2) /root/kernels/linux - kernel version 2.4.14

I am using a boot image generated from the older kernel for booting. The problem is the older kernel doesn't support MIPS architecture. What should I do to upgrade my kernel so that it supports MIPS architecture & that I'll be able to cross-compile my programs properly.

Domcan
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8
