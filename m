Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2003 08:59:20 +0000 (GMT)
Received: from [IPv6:::ffff:203.145.184.221] ([IPv6:::ffff:203.145.184.221]:53765
	"EHLO naturesoft.net") by linux-mips.org with ESMTP
	id <S8225211AbTAUHAU> convert rfc822-to-8bit; Tue, 21 Jan 2003 07:00:20 +0000
Received: from [192.168.0.15] (helo=krishna.royalchallenge.com)
	by naturesoft.net with esmtp (Exim 3.35 #1)
	id 18asMm-0007BD-00; Tue, 21 Jan 2003 12:28:36 +0530
Content-Type: text/plain;
  charset="iso-8859-1"
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
To: "santosh kumar gowda" <ipv6_san@rediffmail.com>
Subject: Re: Linux kernel for MIPS architecture
Date: Tue, 21 Jan 2003 12:28:47 +0530
User-Agent: KMail/1.4.1
References: <20030121043050.13493.qmail@webmail28.rediffmail.com>
In-Reply-To: <20030121043050.13493.qmail@webmail28.rediffmail.com>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301211228.47766.krishnakumar@naturesoft.net>
Return-Path: <krishnakumar@naturesoft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1195
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krishnakumar@naturesoft.net
Precedence: bulk
X-list: linux-mips

Hi,

Change the following in the top level makefile

CROSS_COMPILE=mipsel-linux-
ARCH=mips


And change the link 
include/asm
of the top directory to point to
the asm-mips there.


Then try configuring and compiling the kernel
as usual.

Hope this helps
Regards
KK








On Tuesday 21 January 2003 10:00 am, you wrote:
> Hi,
> I want to compile the entire Linux Kernel 2.4.20
> for MIPS architecture.
> I have mipsel-linux-gcc cross compiler.
> Is this cross compiler enough or i need something else..??
> Can any one suggest me from where to start with...??
> What changes to be made in the Makefile..???
>
> -San
