Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5H8ZhnC013800
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 01:35:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5H8Zhbn013799
	for linux-mips-outgoing; Mon, 17 Jun 2002 01:35:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from inetmg.sony.com.sg (inetmg.sony.com.sg [202.42.154.66])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5H8ZbnC013794
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 01:35:39 -0700
Received: from seagw01.sony.com.sg (firewall-user@seagw [43.68.8.1])
	by inetmg.sony.com.sg (8.10.2+Sun/8.10.2) with ESMTP id g5H8jXi25445
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 16:45:38 +0800 (SGT)
Received: from sapsgssdibh01.ap.sony.com (localhost [127.0.0.1])
	by seagw01.sony.com.sg (8.11.6+Sun/8.11.6) with ESMTP id g5H8at228321
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 16:36:55 +0800 (SGT)
Received: from sapinsardexc01.sard.in.sony.com.sg (SAPINSARDEXC01 [43.88.102.8]) by sapsgssdibh01.ap.sony.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2650.21)
	id M4YKY3ZT; Mon, 17 Jun 2002 16:36:53 +0800
Received: from Aditya.ap.sony.com (43.88.102.16 [43.88.102.16]) by sapinsardexc01.sard.in.sony.com.sg with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2655.55)
	id JF0D3GDL; Mon, 17 Jun 2002 14:17:53 +0530
Message-Id: <4.3.2.7.0.20020617140608.00b9f640@43.88.102.8>
X-Sender: apinsard/aditya/aditya.ps@43.88.102.8 (Unverified)
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 17 Jun 2002 14:07:46 +0530
To: linux-mips@oss.sgi.com
From: aditya <aditya.ps@ap.sony.com>
Subject: regarding jal instruction in mips
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hello,

I have a doubt w.r.t. Linux on mips.

in mips there is a instruction jal which jumps across 256 MB boundry. 
but this is a restriction as shared text (libraries) and private text (program's text) should be located within 256 MB boundry. Is it true ??

how this problem is solved in linux ???

Thanks
Aditya
