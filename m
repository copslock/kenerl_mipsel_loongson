Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g08KohT26805
	for linux-mips-outgoing; Tue, 8 Jan 2002 12:50:43 -0800
Received: from gw-nl4.philips.com (gw-nl4.philips.com [212.153.190.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g08Koeg26802
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 12:50:40 -0800
Received: from smtpscan-nl2.philips.com (localhost.philips.com [127.0.0.1])
          by gw-nl4.philips.com with ESMTP id UAA17869
          for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 20:49:54 +0100 (CET)
          (envelope-from balaji.ramalingam@philips.com)
From: balaji.ramalingam@philips.com
Received: from smtpscan-nl2.philips.com(130.139.36.22) by gw-nl4.philips.com via mwrap (4.0a)
	id xma017867; Tue, 8 Jan 02 20:49:55 +0100
Received: from smtprelay-us1.philips.com (localhost [127.0.0.1]) 
	by smtpscan-nl2.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id UAA16912
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 20:50:35 +0100 (MET)
Received: from arj001soh.diamond.philips.com (amsoh01.diamond.philips.com [161.88.79.212]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id NAA18788
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 13:50:33 -0600 (CST)
Subject: keyboard config with serial console
To: linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFCDD0C848.3B1D3360-ON88256B3B.006C6227@diamond.philips.com>
Date: Tue, 8 Jan 2002 11:51:24 -0800
X-MIMETrack: Serialize by Router on arj001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 08/01/2002 13:54:18
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hello,

I'm trying to boot linux 2.4.3 on mips core.
I'm using a ttyS0 device (uart com 1) as my serial console.
I get a shell prompt but not able to do anything after that because of
my keyboard drivers not configured.
Itseems that in order to configure keyboard drivers one should define
CONSOLE_VT. I just have a serial uart and I dont know if I can use a
CONFIG_SERIAL and CONFIG_SERIAL_CONSOLE and still
configure my keyboard.

I think many keyboard function calls are linked with the virtual terminal
related files. Is it possible to configure the keyboard drivers with a
serial console?

Have anyone tried this before?
Please advice

regards,
Balaji
