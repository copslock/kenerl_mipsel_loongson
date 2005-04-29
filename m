Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2005 09:14:35 +0100 (BST)
Received: from [IPv6:::ffff:61.246.180.169] ([IPv6:::ffff:61.246.180.169]:5131
	"EHLO mail.netsity.com") by linux-mips.org with ESMTP
	id <S8225962AbVD2ION>; Fri, 29 Apr 2005 09:14:13 +0100
Received: by mail.netsity.com with Internet Mail Service (5.5.2653.19)
	id <J6SP2J8Y>; Fri, 29 Apr 2005 13:43:59 +0530
Received: from ISINGH ([192.168.103.60]) by mail.netsity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id J6SP2J8X; Fri, 29 Apr 2005 13:43:58 +0530
From:	Inpreet Singh <Singh.Inpreet@netsity.com>
To:	Stuart Longland <stuartl@longlandclan.hopto.org>
Cc:	linux-mips@linux-mips.org
Message-ID: <005201c54c93$64a5fb30$3c67a8c0@netsity.com>
References: <015301c54c01$9b8e4e00$3c67a8c0@netsity.com> <57961.131.181.46.15.1114757462.squirrel@mail.longlandclan.hopto.org>
Subject: Re: GD Library on MIPS Processor
Date:	Fri, 29 Apr 2005 13:43:58 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Return-Path: <Singh.Inpreet@netsity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Singh.Inpreet@netsity.com
Precedence: bulk
X-list: linux-mips

I want to use gd library on MIPS processor. Due to limited memory on mips, I
cannot compile gd library on it. So I need to compile it on linux intel
processor and transfer executable files on MIPS. I have compiled gd library
on intel linux and successfully tested it. But how to compile gd library for
MIPS processor? I tried to configure it with these commands
1. ./configure --host=mips-unknown-linux-gnu
2. ./configure --host=mips-linux
3. ./configure --host=mips-linux --build=mips-linux --target=mips-linux
4. ./configure --host=mips-linux --build=mips-linux

but none of them had worked for me. Whenever after compiling I place my
executables and try to test them, they fails to return results.

gd library after configure command dynamically generates Makefile. Now
method to test your application which you have to write in a c program is so
make this program with this Makefile. Lets suppose you make an example and
name it as test.c so what you have to do is enter test.c in this dynamically
generated Makefile and write command make test this will outputs in test
executable file. Which we can run using command ./test on our command
prompt.

Whenever I perform this task it always shows errors:
**************************************************************
/launchpad # ./gddemo
./gddemo: 1: Syntax error: "(" unexpected
**************************************************************
eval: 1: gcc: not found
**************************************************************
I have used Source-Navigator and tried to compile my project using mips
compiling option but doesn't workout. So please help me. please tell me what
is best procedure to compile and test gd library on MIPS processor when due
to memory limitation I cannot compile project on MIPS itself, on my MIPS
processor I have installed linux with very limited command set.
_____________________________________________________________________
Regards
Inpreet Singh
