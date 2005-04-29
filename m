Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2005 11:08:41 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.187]:26860
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225966AbVD2KI0>; Fri, 29 Apr 2005 11:08:26 +0100
Received: from [213.39.254.68] (helo=tuxator.satorlaser-intern.com)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKxQS-1DRSQ4325s-0007Dj; Fri, 29 Apr 2005 12:08:24 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: GD Library on MIPS Processor
Date:	Fri, 29 Apr 2005 12:09:33 +0200
User-Agent: KMail/1.7.2
References: <015301c54c01$9b8e4e00$3c67a8c0@netsity.com> <57961.131.181.46.15.1114757462.squirrel@mail.longlandclan.hopto.org> <005201c54c93$64a5fb30$3c67a8c0@netsity.com>
In-Reply-To: <005201c54c93$64a5fb30$3c67a8c0@netsity.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504291209.34016.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Inpreet Singh wrote:
> I want to use gd library on MIPS processor. Due to limited memory on mips,
> I cannot compile gd library on it. So I need to compile it on linux intel
> processor and transfer executable files on MIPS. I have compiled gd library
> on intel linux and successfully tested it. But how to compile gd library
> for MIPS processor? I tried to configure it with these commands
> 1. ./configure --host=mips-unknown-linux-gnu
> 2. ./configure --host=mips-linux
> 3. ./configure --host=mips-linux --build=mips-linux --target=mips-linux
> 4. ./configure --host=mips-linux --build=mips-linux

If you're building on Linux/x86, using '--build=mips-linux' is obviously 
completely bogus.

> but none of them had worked for me. Whenever after compiling I place my
> executables and try to test them, they fails to return results.

This could have another reason, see below...

> gd library after configure command dynamically generates Makefile. Now
> method to test your application which you have to write in a c program is
> so make this program with this Makefile. Lets suppose you make an example
> and name it as test.c so what you have to do is enter test.c in this
> dynamically generated Makefile and write command make test this will
> outputs in test executable file. Which we can run using command ./test on
> our command prompt.
>
> Whenever I perform this task it always shows errors:
> **************************************************************
> /launchpad # ./gddemo
> ./gddemo: 1: Syntax error: "(" unexpected

If this program gives this message, then it is running. Why it gives it is a 
totally unrelated thing. 

 Now, what could also be the case is that you didn't grab the executable but a 
script. Autotools usually generate a script in the builddir that setup the 
runtime linker so it finds the (not yet installed) libraries and then calls 
the executable inside the hidden .lib directory.

If this all fails, create a minimal hello-world and compile it with
'mips-linux-gcc -Wall -o hw hello.c' and try that on the host machine.

Uli
