Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Apr 2006 06:54:55 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:35548 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133355AbWDNFyn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Apr 2006 06:54:43 +0100
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 16ED6C052;
	Fri, 14 Apr 2006 08:06:39 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id 250381BC091;
	Fri, 14 Apr 2006 08:06:39 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 5DFC21A18BC;
	Fri, 14 Apr 2006 08:06:39 +0200 (CEST)
Date:	Fri, 14 Apr 2006 08:06:41 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Freddy Spierenburg <freddy@dusktilldawn.nl>
Cc:	linux-mips@linux-mips.org
Subject: Re: UART trouble on the DBAu1100
Message-ID: <20060414060640.GE29489@domen.ultra.si>
References: <20060413131117.GP11097@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413131117.GP11097@dusktilldawn.nl>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

On 13/04/06 15:11 +0200, Freddy Spierenburg wrote:
> Hi,
> 
> I have a problem and yet am not sure where to look. It's a
> problem in the serial driver for the internal UART's of the
> AU1100. It appeared ever since 2.6.15. 2.6.14 is working like a
> charm, but 2.6.15 gives me the trouble.
> 
> When I open a tty with the open(2) system call (see attached open.c)
> I see that the UART sends a 0x36 byte on the line.

We had the same problem on Au1200, applying
http://www.linux-mips.org/archives/linux-mips/2006-03/msg00259.html
(or maybe a different version of this patch) fixed it.

> 
> But that's not the only trouble. I also do not receive any
> bytes received by the UART. All the received bytes stay
> in the input buffer of the UART only to be send up to userland
> as soon as the UART is asked to send a byte on the line itself.
> Then in one take all the bytes are received by the application
> listening.

I may be way off, but maybe it's just flow control that needs
to be turned off.


	Domen
