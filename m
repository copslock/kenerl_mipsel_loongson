Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Feb 2003 10:30:55 +0000 (GMT)
Received: from mail.ocs.com.au ([IPv6:::ffff:203.34.97.2]:38162 "HELO
	mail.ocs.com.au") by linux-mips.org with SMTP id <S8224939AbTBCKaz>;
	Mon, 3 Feb 2003 10:30:55 +0000
Received: (qmail 3612 invoked from network); 3 Feb 2003 10:30:46 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 3 Feb 2003 10:30:46 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id AEE03300087; Mon,  3 Feb 2003 21:30:43 +1100 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 2F5C18F; Mon,  3 Feb 2003 21:30:43 +1100 (EST)
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Cannon <ajc@gmx.net>
Cc: linux-mips@linux-mips.org
Subject: Re: Indy bootstrap tftp problem 
In-reply-to: Your message of "Mon, 03 Feb 2003 11:08:00 BST."
             <3E3E3F80.8080704@gmx.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Feb 2003 21:30:37 +1100
Message-ID: <2436.1044268237@ocs3.intra.ocs.com.au>
Return-Path: <kaos@ocs.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@ocs.com.au
Precedence: bulk
X-list: linux-mips

On Mon, 03 Feb 2003 11:08:00 +0100, 
Andrew Cannon <ajc@gmx.net> wrote:
>I am trying to install Linux on my Indy using the network boot procedure 
>described on the debian site at 
><http://www.linux-debian.de/howto/debian-mips-woody-install.html>
>
>This is not getting very far because the tftp load of the bootblock 
>fails with the Indy bootrom reporting "ip fragments error" for each tftp 
>reply packet that arrives (with debug enabled). Does anyone know what 
>might be happening here? Is this a known bug in the bootrom?

Some Indy bootroms do not cope with the "don't fragment" bit (DF) being
set.  If the tftp server is Linux

  echo "1" > /proc/sys/net/ipv4/ip_no_pmtu_disc
