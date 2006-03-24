Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 10:48:58 +0000 (GMT)
Received: from fri.itea.ntnu.no ([129.241.7.60]:22499 "EHLO fri.itea.ntnu.no")
	by ftp.linux-mips.org with ESMTP id S8133528AbWCXKss (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2006 10:48:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by fri.itea.ntnu.no (Postfix) with ESMTP id 0AD2B83B2;
	Fri, 24 Mar 2006 11:58:46 +0100 (CET)
Received: from invalid.ed.ntnu.no (invalid.ed.ntnu.no [129.241.205.150])
	by fri.itea.ntnu.no (Postfix) with ESMTP;
	Fri, 24 Mar 2006 11:58:44 +0100 (CET)
Received: from invalid.ed.ntnu.no (jonah@localhost.ed.ntnu.no [127.0.0.1])
	by invalid.ed.ntnu.no (8.13.3/8.13.3) with ESMTP id k2OAwe2m015892
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Fri, 24 Mar 2006 11:58:40 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
Received: from localhost (jonah@localhost)
	by invalid.ed.ntnu.no (8.13.3/8.13.3/Submit) with ESMTP id k2OAwZZS015889;
	Fri, 24 Mar 2006 11:58:40 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
X-Authentication-Warning: invalid.ed.ntnu.no: jonah owned process doing -bs
Date:	Fri, 24 Mar 2006 11:58:35 +0100 (CET)
From:	Jon Anders Haugum <jonah@omegav.ntnu.no>
X-X-Sender: jonah@invalid.ed.ntnu.no
To:	Mark Schank <mschank@dcbnet.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Alchemy Au1550 Early Console
In-Reply-To: <5.1.0.14.2.20060322165104.02a32800@205.166.54.3>
Message-ID: <20060324114653.S15728@invalid.ed.ntnu.no>
References: <5.1.0.14.2.20060322165104.02a32800@205.166.54.3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Return-Path: <jonah@omegav.ntnu.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonah@omegav.ntnu.no
Precedence: bulk
X-list: linux-mips

On Wed, 22 Mar 2006, Mark Schank wrote:

> I am working with a Au1550 based system an am trying to upgrade
> from the 2.6.12 kernel to the 2.6.16 kernel .  I have noticed that the
> au1x00_uart.c driver has been remove and replaced with functionality in
> 8250.c and 8250_au1x00.c.  So far, I have been unable to get the early
> console running.  Under this new driver model, what is the proper
> way to bring up an early console on a Au1550 internal serial port?

Have you enabled the console for 8250-based serial ports?
(CONFIG_SERIAL_8250_CONSOLE)

Another issue might be if you have got some PCI-based serial ports in the 
system, because they will be assigned before the internal ones. So you 
might end up having the console on a PCI serial port.

Third: There is a bug in the new driver regarding divisor settings, but 
the console should still be working since the boot loader will init the 
uart properly. (I've posted a patch for this bug earlier: 
http://www.linux-mips.org/archives/linux-mips/2006-03/msg00041.html).


Jon
