Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Aug 2004 10:28:31 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.130] ([IPv6:::ffff:145.253.187.130]:52231
	"EHLO proxy.baslerweb.com") by linux-mips.org with ESMTP
	id <S8224922AbUHYJ20>; Wed, 25 Aug 2004 10:28:26 +0100
Received: from comm1.baslerweb.com (proxy.baslerweb.com [172.16.13.2])
          by proxy.baslerweb.com (Post.Office MTA v3.5.3 release 223
          ID# 0-0U10L2S100V35) with ESMTP id com
          for <linux-mips@linux-mips.org>; Wed, 25 Aug 2004 11:28:11 +0200
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id RPG51AMP; Wed, 25 Aug 2004 11:28:24 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: ioremap() and CONFIG_SWAP_IO_SPACE
Date: Wed, 25 Aug 2004 11:30:53 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408251130.53865.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi,

my platform (PMC-Sierra Yosemite in big endian mode),
like many others, uses ioremap() to map device
registers, such as the RM9000's OCD registers.
To access those registers, the return value of
ioremap() is casted to a suitable pointer type and
dereferenced. This of course works, but the return
value of ioremap() is documented not to be a
directly dereferenceable pointer value, and accesses
to ioremapped addresses should be performed using
the readx/writex APIs.

I therefore decided to straighten this out and use those
APIs throughout, but that did not work. The platform
defines 'CONFIG_SWAP_IO_SPACE=y', which causes all
accesses through readx/writex to be byte-swapped. That
is not really appropriate, as the registers are in big
endian order. I therefore tried to change that setting
in yosemite_defconfig, only to find that every time
I do 'make oldconfig' it returns to its original
value of 'y'.

So here are my questions:

1. Am I right to conclude that the platform configuration
   should not set CONFIG_SWAP_IO_SPACE, or am I missing
   something?

2. What is the mechanism that causes that setting to
   always revert to enabled when doing 'make oldconfig'?
   How do I avoid that?

thanks,
Thomas
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
