Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0A2G9q24713
	for linux-mips-outgoing; Wed, 9 Jan 2002 18:16:09 -0800
Received: from gw-nl5.philips.com (gw-nl5.philips.com [212.153.235.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0A2G5g24710
	for <linux-mips@oss.sgi.com>; Wed, 9 Jan 2002 18:16:06 -0800
Received: from smtpscan-nl2.philips.com (localhost.philips.com [127.0.0.1])
          by gw-nl5.philips.com with ESMTP id CAA17555
          for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 02:16:01 +0100 (MET)
          (envelope-from balaji.ramalingam@philips.com)
From: balaji.ramalingam@philips.com
Received: from smtpscan-nl2.philips.com(130.139.36.22) by gw-nl5.philips.com via mwrap (4.0a)
	id xma017553; Thu, 10 Jan 02 02:16:01 +0100
Received: from smtprelay-us1.philips.com (localhost [127.0.0.1]) 
	by smtpscan-nl2.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id CAA05105
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 02:16:00 +0100 (MET)
Received: from arj001soh.diamond.philips.com (amsoh01.diamond.philips.com [161.88.79.212]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id TAA01583
	for <linux-mips@oss.sgi.com>; Wed, 9 Jan 2002 19:15:58 -0600 (CST)
Subject: linux on keyboardless system
To: linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF9F3303F0.879E3310-ON08256B3D.00068EEF@diamond.philips.com>
Date: Wed, 9 Jan 2002 17:16:52 -0800
X-MIMETrack: Serialize by Router on arj001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 09/01/2002 19:19:43
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

I'm tried booting linux 2.4.3 on my prototype system which does not have
a keyboard and a monitor. I used the uart as my serial device and passed on
the console=ttyS0(com1 in my pc) to the kernel. I can see the shell prompt after the kernel
bootup but not able to enter anything after that.

So how can I use my pc keyboard to send characters to my uart?
I think I'm missing something here.
Can anyone give me some hint?
Thankyou in advance...


regards,
Balaji
