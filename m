Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2004 09:22:08 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:83.104.11.251]:32269 "EHLO
	exterity-serv1.exterity.co.uk") by linux-mips.org with ESMTP
	id <S8225842AbUEXIWF> convert rfc822-to-8bit; Mon, 24 May 2004 09:22:05 +0100
Received: from gillpc ([192.168.0.32]) by exterity-serv1.exterity.co.uk with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 24 May 2004 09:24:03 +0100
From:	"Gill" <gill.robles@exterity.co.uk>
To:	"'Jan-Benedict Glaw'" <jbglaw@lug-owl.de>,
	<linux-mips@linux-mips.org>
Subject: RE: Socket problem?
Date:	Mon, 24 May 2004 09:25:43 +0100
Organization: Exterity
Message-ID: <000501c44168$b4718800$2000a8c0@gillpc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20040522160635.GV1912@lug-owl.de>
X-OriginalArrivalTime: 24 May 2004 08:24:03.0140 (UTC) FILETIME=[78BEF040:01C44168]
Return-Path: <gill.robles@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gill.robles@exterity.co.uk
Precedence: bulk
X-list: linux-mips

Hi -

To clarify, more specifically select() returns a positive value, and a
subsequent call to FD_ISSET() returns TRUE for one of the sockets the app is
listening on.  Then, app calls recvfrom() which returns (sometimes) -1.
Problem occurs sporadically...I'm seeing it every hundred or so packets at
the moment, but it varies.


Thanks,
Gill

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Jan-Benedict Glaw
Sent: 22 May 2004 17:07
To: linux-mips@linux-mips.org
Subject: Re: Socket problem?


On Sat, 2004-05-22 09:02:48 +0100, Gill <gill.robles@exterity.co.uk> wrote
in message <000001c43fd3$2c25a350$2000a8c0@gillpc>:
> Hi -
> 
> Has anyone come across a socket problem where the user app calls 
> select() on a set of sockets, which returns, indicating that data is 
> waiting...then subsequent recvfrom() call returns -1 indicating that 
> there's nothing there??

Read the select() manpage again. Upon successful return, it's guaranteed
that the very next read() on a file descriptor contained in the result set
won't block. Typically, it's the case after data arrived, but returning -1
*immediately* (with no blocking) is okay, too.

> I'm using linux v2.4.2, IPv4, and the ethernet driver is pcnet32.  
> We're receiving a UDP stream.

Quite aged version, though perfectly correct on select() behaviour.

> I'm trying to check for dropped packets.  /proc/net/snmp indicates a 
> number of UDP InErrors (~1 per second).  However, not yet sure whether 
> this is a consequence of the problem above, or cause of it.

Neither - nor. You've got a small thinko in your application. Albeit
that: update your kernel version... It most probably contains a number of
known root exploits.

MfG, JBG

-- 
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier Bürger" | im Internet! |   im Irak!
   ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM |
TCPA));
