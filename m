Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7HIimRw027670
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 17 Aug 2002 11:44:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7HIimPd027669
	for linux-mips-outgoing; Sat, 17 Aug 2002 11:44:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from columba.www.eur.3com.com (ip-161-71-171-238.corp-eur.3com.com [161.71.171.238])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7HIibRw027658
	for <linux-mips@oss.sgi.com>; Sat, 17 Aug 2002 11:44:43 -0700
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g7HIn3RG014757
	for <linux-mips@oss.sgi.com>; Sat, 17 Aug 2002 19:49:04 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g7HIm4R21212
	for <linux-mips@oss.sgi.com>; Sat, 17 Aug 2002 19:48:04 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256C18.0067B09A ; Sat, 17 Aug 2002 19:52:34 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: linux-mips@oss.sgi.com
Message-ID: <80256C18.0067AFA2.00@notesmta.eur.3com.com>
Date: Sat, 17 Aug 2002 19:47:02 +0100
Subject: Improving /dev/random by using CP0_COUNT
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



The kernel code to support /dev/random on Mips on currently uses 'jiffies' as an
input to random number process. The code has a special case to use the high
precision TSC on x86 when it is availble. (see linux/drivers/char/random.c :
add_timer_randomness() ) It looks like it would only take a few lines of code to
use the CP0_COUNT register on Mips to perform a similar function.

We have a headless embedded system which has none of  tradional sources of
random entropy such as keyboard, mouse or disk activity. Currently our only
option is to use the network interrupt, but I know this is considered a poor
source since an attacker could generating a known sequence of packets. If we
could increase the resolution of the timing then it would make it harder to
exploit.

Has anyone tried this?

     Jon Burgess
