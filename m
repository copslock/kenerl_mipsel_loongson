Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 06:39:40 +0100 (BST)
Received: from [IPv6:::ffff:203.145.184.221] ([IPv6:::ffff:203.145.184.221]:51461
	"EHLO naturesoft.net") by linux-mips.org with ESMTP
	id <S8225244AbTFDFjh> convert rfc822-to-8bit; Wed, 4 Jun 2003 06:39:37 +0100
Received: from [192.168.0.15] (helo=cork.royalchallenge.com)
	by naturesoft.net with esmtp (Exim 3.35 #1)
	id 19NQvi-0004PA-00; Wed, 04 Jun 2003 11:05:22 +0530
Content-Type: text/plain;
  charset="iso-8859-1"
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Single stepping in mips
Date: Wed, 4 Jun 2003 11:07:55 +0530
User-Agent: KMail/1.4.1
References: <200306040918.01943.krishnakumar@naturesoft.net> <20030604051818.GA2365@linux-mips.org>
In-Reply-To: <20030604051818.GA2365@linux-mips.org>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306041107.55492.krishnakumar@naturesoft.net>
Return-Path: <krishnakumar@naturesoft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krishnakumar@naturesoft.net
Precedence: bulk
X-list: linux-mips

Hi,

> On most MIPS processors there is no singlestepping feature.  You have to
> manual insert a breakpoint into the instruction stream and deal with the
> exception.
>
>   Ralf

But if we insert a Break point into the instruction stream the exception
will be generated before the execution of the real instruction.
That means.
If we have the following set of instructions

addr1: instr1
addr2: instr2
addr3: instr3


if we replace instr1 by break.

addr1: break
addr2: instr2
addr3: instr3

we will get a break point exception as soon as the break
in addr1 is executed (correct me if I have wrongly understood !! )

But the need is to raise an exception after instr1 (at addr1) is executed.
One solution is using a break at instr2 (at addr2).
But suppose instr1 is a jmp then there is no point
in keeping a break at addr2.
(inorder to raise an exception after instr1 is executed).

So is there some other clean way for this ?


Regards and Thanks
KK
