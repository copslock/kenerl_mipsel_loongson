Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Feb 2003 10:07:42 +0000 (GMT)
Received: from pop.gmx.net ([IPv6:::ffff:213.165.65.60]:17006 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8224939AbTBCKHm>;
	Mon, 3 Feb 2003 10:07:42 +0000
Received: (qmail 8658 invoked by uid 0); 3 Feb 2003 10:07:33 -0000
Received: from p50819F5C.dip.t-dialin.net (HELO gmx.net) (80.129.159.92)
  by mail.gmx.net (mp003-rz3) with SMTP; 3 Feb 2003 10:07:33 -0000
Message-ID: <3E3E3F80.8080704@gmx.net>
Date: Mon, 03 Feb 2003 11:08:00 +0100
From: Andrew Cannon <ajc@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Indy bootstrap tftp problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ajc@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ajc@gmx.net
Precedence: bulk
X-list: linux-mips


I am trying to install Linux on my Indy using the network boot procedure 
described on the debian site at 
<http://www.linux-debian.de/howto/debian-mips-woody-install.html>

This is not getting very far because the tftp load of the bootblock 
fails with the Indy bootrom reporting "ip fragments error" for each tftp 
reply packet that arrives (with debug enabled). Does anyone know what 
might be happening here? Is this a known bug in the bootrom?

More info - tcpdump on the server shows the tftp reply packets with 
blocksize 512 being sent out so there doesn't actually seem to be any ip 
fragmentation happening. Booting IRIX and running 'tftp get' works ok so 
it's only the rom that fails. Oh and this is quite an early Indy, so it 
may well have a buggy rom.

Any help appreciated. thx

Andrew Cannon
