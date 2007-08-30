Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2007 20:49:58 +0100 (BST)
Received: from sovereign.computergmbh.de ([85.214.69.204]:61620 "EHLO
	sovereign.computergmbh.de") by ftp.linux-mips.org with ESMTP
	id S20023107AbXH3Ttu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Aug 2007 20:49:50 +0100
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 076C418016B83; Thu, 30 Aug 2007 21:49:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id F06E81C012F0A;
	Thu, 30 Aug 2007 21:49:13 +0200 (CEST)
Date:	Thu, 30 Aug 2007 21:49:13 +0200 (CEST)
From:	Jan Engelhardt <jengelh@computergmbh.de>
To:	"J. Scott Kasten" <jscottkasten@yahoo.com>
cc:	Mohamed Bamakhrama <bamakhrama@gmail.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Average number of instructions per line of kernel code
In-Reply-To: <Pine.LNX.4.64.0708301212030.14590@pixie.tetracon-eng.net>
Message-ID: <Pine.LNX.4.64.0708302147450.24730@fbirervta.pbzchgretzou.qr>
References: <40378e40708300600h5837d46ci5266b8ae62bbd46e@mail.gmail.com> 
 <9a8748490708300631o285fd31ch462199ec9535c6c2@mail.gmail.com>
 <40378e40708300648i4f016906v60f821bf182a5633@mail.gmail.com>
 <Pine.LNX.4.64.0708301212030.14590@pixie.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jengelh@computergmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jengelh@computergmbh.de
Precedence: bulk
X-list: linux-mips


On Aug 30 2007 12:29, J. Scott Kasten wrote:
> On Thu, 30 Aug 2007, Mohamed Bamakhrama wrote:
>> > > Hi all,
>> > > I have a question regarding the average number of assembly
>> > > instructions per line of kernel code. I know that this is a difficult
>> > > question since it depends on many factors such as the instruction set
>
> Here's a quick answer, not the best, but quick.
>
> I took a user space flash memory driver I'm doing at work and compiled it on my
> R5000 at home using gcc 4.1 and the MIPS3 abi, stopping with a .o file.  I also
> ran the source through cpp and a couple of grep passes to strip out junk that
> wasn't really code.  This driver may be somewhat typical of what you would run
> into as it has quite a few inline functions and such.
>
> The driver.o was about 23000 bytes.  Forgetting about the symboltables and just
> dividing by 4 to estimate instructions and dividing by about 1650 net lines of
> code, I got about 3.5 instructions per line of C code.

objcopy -j .text input.o output.o
objcopy -O binary output.o output2.o

Then you can objdump -S output.o and count. output2.o has the ELF header
stripped, so provides the raw size, but at the cost of not being able to run
objdump. If you know that every instruction is fixed size, then of course
output2.o is easy.


	Jan
-- 
