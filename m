Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2007 17:31:06 +0100 (BST)
Received: from smtp110.plus.mail.re1.yahoo.com ([69.147.102.73]:17324 "HELO
	smtp110.plus.mail.re1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022858AbXH3Qa4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Aug 2007 17:30:56 +0100
Received: (qmail 12656 invoked from network); 30 Aug 2007 16:30:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=24jq95gGiVL+sPJiS282h6PaMTFeaKXHXn+Dda0SOBSPRvcD3awOJXDKxDy6mf19EOz4L+bW21pAUcQheNPJVozbreWa2dxzi/wf0pDrULEFkXZ04r3XNW085gjW79gmrXen6OZVpksfuqDukyUBQ+j+XtnvmTjvsKRWZmbppqw=  ;
Received: from unknown (HELO ?192.168.254.6?) (jscottkasten@72.185.69.24 with login)
  by smtp110.plus.mail.re1.yahoo.com with SMTP; 30 Aug 2007 16:30:50 -0000
X-YMail-OSG: 0c35F3sVM1n.Y9KvAz4FgoPYVy1Bs5CAVBmFtevaa0D6mT4_Pc057jFY6KuZMB2W8wK168hzsw--
Date:	Thu, 30 Aug 2007 12:29:38 -0400 (EDT)
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@pixie.tetracon-eng.net
To:	Mohamed Bamakhrama <bamakhrama@gmail.com>
cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Average number of instructions per line of kernel code
In-Reply-To: <40378e40708300648i4f016906v60f821bf182a5633@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0708301212030.14590@pixie.tetracon-eng.net>
References: <40378e40708300600h5837d46ci5266b8ae62bbd46e@mail.gmail.com> 
 <9a8748490708300631o285fd31ch462199ec9535c6c2@mail.gmail.com>
 <40378e40708300648i4f016906v60f821bf182a5633@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips


On Thu, 30 Aug 2007, Mohamed Bamakhrama wrote:
>>> Hi all,
>>> I have a question regarding the average number of assembly
>>> instructions per line of kernel code. I know that this is a difficult
>>> question since it depends on many factors such as the instruction set

Here's a quick answer, not the best, but quick.

I took a user space flash memory driver I'm doing at work and compiled it 
on my R5000 at home using gcc 4.1 and the MIPS3 abi, stopping with a .o 
file.  I also ran the source through cpp and a couple of grep passes to 
strip out junk that wasn't really code.  This driver may be somewhat 
typical of what you would run into as it has quite a few inline functions 
and such.

The driver.o was about 23000 bytes.  Forgetting about the symboltables and 
just dividing by 4 to estimate instructions and dividing by about 1650 
net lines of code, I got about 3.5 instructions per line of C code.

I'm guessing that ball park, you're looking at 3-5 average - 10 seems high 
except in sections with lots and lots of inlines.

Regards,

-S-
