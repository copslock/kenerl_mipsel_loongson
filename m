Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2006 23:37:37 +0000 (GMT)
Received: from xrelay03.mail2web.com ([168.144.1.54]:42963 "EHLO
	xrelay03.mail2web.com") by ftp.linux-mips.org with ESMTP
	id S8133813AbWCBXh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2006 23:37:28 +0000
Received: from [168.144.251.152] (helo=M2W046.mail2web.com)
	by xrelay03.mail2web.com with smtp (Exim 4.50)
	id 1FExTz-0005Pu-Ih
	for linux-mips@linux-mips.org; Thu, 02 Mar 2006 18:45:20 -0500
Message-ID: <380-22006342234519512@M2W046.mail2web.com>
X-Priority: 3
Reply-To: dan.mcgee@ntsoc.com
X-Originating-IP: 64.241.199.88
X-URL:	http://mail2web.com/
From:	"dan.mcgee@ntsoc.com" <dan.mcgee@ntsoc.com>
To:	linux-mips@linux-mips.org
Date:	Thu, 2 Mar 2006 18:45:19 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Subject: nfs network timeout on bcm1480 BigSur
Return-Path: <dan.mcgee@ntsoc.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.mcgee@ntsoc.com
Precedence: bulk
X-list: linux-mips

With kernel 2.6.15 from linux-mips respository. I'm seeing a nfs server
timeout error, during heavy network traffic. Example make -j 5 will lock
the system up anywhere from 3 to 15 minutes after start the make process.
I built the kernel with the default arch/mips/configs/bigsur_defconfig. I
have tried to increase the RPC timeout, which didn't help. The following is
the output from the console 
before the network locks up.


172.22.250.195 login: [4295020.091000] nfs: server 172.22.250.78 not
respondingg[4295021.251000] nfs: server 172.22.250.78 not responding, still
trying
[4295038.852000] nfs: server 172.22.250.78 not responding, still trying
[4295056.452000] nfs: server 172.22.250.78 not responding, still trying

Thanks Dan McGee.

--------------------------------------------------------------------
mail2web - Check your email from the web at
http://mail2web.com/ .
