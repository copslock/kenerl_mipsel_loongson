Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 18:13:17 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:8433 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225567AbTIXRNG>;
	Wed, 24 Sep 2003 18:13:06 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA13905;
	Wed, 24 Sep 2003 10:12:41 -0700
Subject: RE: How to translate Little to Big endian ?
From: Pete Popov <ppopov@mvista.com>
To: Lyle Bainbridge <lyle@zevion.com>, prabhakark@contechsoftware.com
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <000001c382b6$9e3b6fe0$1400a8c0@radium>
References: <000001c382b6$9e3b6fe0$1400a8c0@radium>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1064423814.13802.15.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Sep 2003 10:16:54 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Prabhakar,

I recently checked-in a patch for CSB250 support, courtesy of Embedded
Edge.  The port is big endian. I assume you haven't seen the bits
because you haven't pulled the latest bits from the linux-mips tree and
that's why you're trying to port it yourself?

Pete

On Wed, 2003-09-24 at 09:12, Lyle Bainbridge wrote:
> Hi,
> 
> I believe that the CSB250 port will support big or small endian. Check
> out the latest mips-linux kernel code first (2.4.22 I beleive). Then you
> need to use a big endian toolchain.  Mips not Mipsel (ie,
> mips-linux-gcc). Then open the arch/mips/defconfig-csb250 file and
> modify the CONFIG_CPU_LITTLE_ENDIAN option.  It should be:
> 
> CONFIG_CPU_LITTLE_ENDIAN=y
> 
> Then continue to build the kernel as you would for little endian. I
> think that's all from the kernel standpoint. But, are you using Micromon
> to boot the kernel?  By default I think the CSB250 and it's monitor are
> built little endian, and you won't be able to use this if you want a BE
> kernel.  You need the boot loader to put the Au1500 into BE mode.
> 
> Email if you need more details.
> 
> Lyle
> 
> 
> 
> > -----Original Message-----
> > From: linux-mips-bounce@linux-mips.org 
> > [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of 
> > Prabhakar Kalasani
> > Sent: Wednesday, September 24, 2003 10:15 AM
> > To: 'linux-mips@linux-mips.org'
> > Subject: How to translate Little to Big endian ?
> > 
> > 
> > Hi all,
> > I'm trying to port linux-2.4.21 on CSB250 , which is Au1500 
> > processor based board, the processor is a Big endian, I have 
> > taken PB1500 board as my prototype, but it's used Au1500 
> > Little endian. anybody could help me out, what are the 
> > changes do i need to change to make a Little endian souce 
> > into Big endian source.
> > 
> > Is anybody worked on Cogent's CSB250 board till.
> > 
> > Thanks in advance
> > Prabhakar
> > 
> 
> 
> 
