Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0903kA05706
	for linux-mips-outgoing; Tue, 8 Jan 2002 16:03:46 -0800
Received: from spinics.net (IDENT:root@vzn1-22.ce.ftel.net [206.24.95.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0903gg05702
	for <linux-mips@oss.sgi.com>; Tue, 8 Jan 2002 16:03:42 -0800
Received: (from ellis@localhost)
	by spinics.net (8.11.6/8.11.6) id g08N4eA29568
	for linux-mips@oss.sgi.com; Tue, 8 Jan 2002 15:04:40 -0800
From: ellis@spinics.net
Message-Id: <200201082304.g08N4eA29568@spinics.net>
Subject: Re: Galileo 64240
To: linux-mips@oss.sgi.com
Date: Tue, 8 Jan 2002 15:04:40 -0800 (PST)
In-Reply-To: <no.id> from "Paul Kasper" at Jan 08, 2002 07:19:58 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>Is there any support code around for the Galileo 64240? A
>>serial driver would be really nice ;)

>I started an MPSC/Uart driver for the 64240/64240A chips. Didn't
>get much of it working when we got fed up with all of the
>Galileo errata about which registers could or could not be read
>at which times and their confusion as to whether or not they
>were planning to ever fix the errata.

>We broke down and added a 162550 UART to the board.

I really wish that option was available. ;)

>The driver code was abandoned in the midst of early debugging
>stages and is in a horrific state. You're welcome to a copy if
>you really can't find something better.

It looks like we have something that works for our in-house
(non-linux) OS. I guess I'll use that code as an example and see
if I can get a real driver working.

--
http://www.spinics.net/linux/
