Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA71BYD19208
	for linux-mips-outgoing; Tue, 6 Nov 2001 17:11:34 -0800
Received: from gw-us4.philips.com (gw-us4.philips.com [63.114.235.90])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA71BW019205
	for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 17:11:32 -0800
Received: from smtpscan-us1.philips.com (localhost.philips.com [127.0.0.1])
          by gw-us4.philips.com with ESMTP id TAA29484
          for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 19:11:31 -0600 (CST)
          (envelope-from balaji.ramalingam@philips.com)
From: balaji.ramalingam@philips.com
Received: from smtpscan-us1.philips.com(167.81.233.25) by gw-us4.philips.com via mwrap (4.0a)
	id xma029481; Tue, 6 Nov 01 19:11:31 -0600
Received: from smtprelay-us1.philips.com (localhost [127.0.0.1]) 
	by smtpscan-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id TAA14579
	for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 19:11:35 -0600 (CST)
Received: from arj001soh.diamond.philips.com (amsoh01.diamond.philips.com [161.88.79.212]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id TAA02639
	for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 19:11:34 -0600 (CST)
Subject: kernel bug in linux2.4.3
To: linux-mips@oss.sgi.com
Date: Tue, 6 Nov 2001 17:12:08 -0800
Message-ID: <OFAC4A18E3.D2E86AAC-ON88256AFD.00051578@diamond.philips.com>
X-MIMETrack: Serialize by Router on arj001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 06/11/2001 19:15:38
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hello,

I took the linux kernel 2.4.3 from ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/src/.
This kernel was ported for MIPS32 ISA and its supposed to work with all the
mips 4kc core. I took the kernel and ported for our Philips processor PR3950,
which is based on a mips 4kc core.

I have some issues in the reserve_bootmem() & the paging_init() in the
arch/mips/kernel/setup.c. Itseems that they fail in the alloc_bootmem ().
I commented these functions and got till console_init() to get the print messages
on my screen. I got the message as Kernel Bug in bootmem.c

Itseems that the functions BUG() has been executed.
So is this a kernel bug? I mean is there some problem in the kernel which has been
ported or is it something related to improper memory initialization?.


regards,
Balaji
