Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2006 23:59:47 +0100 (BST)
Received: from web31503.mail.mud.yahoo.com ([68.142.198.132]:41853 "HELO
	web31503.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20038532AbWIFW7p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Sep 2006 23:59:45 +0100
Received: (qmail 55261 invoked by uid 60001); 6 Sep 2006 22:59:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=x0qrWj72UTyWDjeMs9bawOVfV1pA8lTRcLYrkS7DnhoAPgJ+dUP8u/ys0yLp5ngYQ2uk+g4G7gQj1wSgy6nIKBpSQR77WyksZl61wpKq3FrFM7kPgF8gnzxWLHI0s8JrZTNp6Nq6ZxS6La74QLrZvuA9aB2VlH3kKeisX6eRqwY=  ;
Message-ID: <20060906225939.55259.qmail@web31503.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31503.mail.mud.yahoo.com via HTTP; Wed, 06 Sep 2006 15:59:39 PDT
Date:	Wed, 6 Sep 2006 15:59:39 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: Resetting a Broadcom in software
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060906223224.GA12175@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

The Sentosa uses a dual-core Broadcom 1250 processor
with an SB1 version 0.2 core. The board is BCM91250E
Revision 1.

The Swarm also uses a Broadcom 1250 with an SB1
version 0.2 core, but the board is a BCM91250A.

Most of the difference seems to be in the motherboard,
rather than the CPU, but I couldn't tell you what the
difference is between an E and an A, and why the A
seems better-behaved.

--- Ralf Baechle <ralf@linux-mips.org> wrote:
> This is not a problem I know of but given your
> description it sounds very
> much like a hardware issue.  Can you find about the
> exact versions of the
> 1250 on the various board?  With the FPU being on
> chip I would expect
> some correlation between the chip revision and this
> issue.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
