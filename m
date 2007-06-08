Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jun 2007 08:34:00 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:45067 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20021758AbXFHHd6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Jun 2007 08:33:58 +0100
Received: (qmail 8309 invoked from network); 8 Jun 2007 09:33:56 +0200
Received: from scarran.roarinelk.net (HELO ?192.168.0.242?) (192.168.0.242)
  by wormhole.roarinelk.net with SMTP; 8 Jun 2007 09:33:56 +0200
Message-ID: <4669063A.9030306@roarinelk.homelinux.net>
Date:	Fri, 08 Jun 2007 09:33:14 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
MIME-Version: 1.0
To:	saravanan <sar_van81@yahoo.co.in>
CC:	linux-mips@linux-mips.org
Subject: Re: web browser support for MIPS DBAU1200
References: <308540.91989.qm@web94312.mail.in2.yahoo.com>
In-Reply-To: <308540.91989.qm@web94312.mail.in2.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

saravanan wrote:

> i need to port a web browser into AU1200.can anyone suggest me any browsers ?

you can start with w3m or lynx and if you have X running, "dillo" works really well.

> also if anyone has any docs regarding this can you send me  ?

simply compile the apps/libs of your choice for mips32r1 arch.
At least that's what I do and it has never failed me so far...

Greetings,
	Manuel Lauss
