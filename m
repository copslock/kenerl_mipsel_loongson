Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 17:52:06 +0000 (GMT)
Received: from bisque.propagation.net ([IPv6:::ffff:66.221.142.1]:65491 "EHLO
	bisque.propagation.net") by linux-mips.org with ESMTP
	id <S8225211AbTBERwG>; Wed, 5 Feb 2003 17:52:06 +0000
Received: from freehandsystems.com (adsl-64-170-127-190.dsl.snfc21.pacbell.net [64.170.127.190])
	by bisque.propagation.net (8.11.6/8.8.5) with ESMTP id h15Hq1K22727;
	Wed, 5 Feb 2003 11:52:01 -0600
Message-ID: <3E414F48.8A6D5E74@freehandsystems.com>
Date: Wed, 05 Feb 2003 09:52:08 -0800
From: Tibor Polgar <tpolgar@freehandsystems.com>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Bruno Randolf <br1@4g-systems.de>
CC: linux-mips@linux-mips.org
Subject: Re: which kernel tree for Au1500?
References: <200302051234.01252.br1@4g-systems.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <tpolgar@freehandsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpolgar@freehandsystems.com
Precedence: bulk
X-list: linux-mips

> we are developing a board based on the Au1500 SOC and we need to adapt the
> linux kernel for it. since we need something working soon, we will
> concentrate on the 2.4 version.

We are just finishing up an Au1500 project right now.  FCS was yesterday!!!  
What we did was:


1) get from AMD the PB1500 development CD.  It has an "old" 2.4.17 kernel
along with MontaVista's HardHat Linux toolkit that's cross compiled to work on
x86 platforms.  If you have the $$$, MontaVista offers great support for the
Au1500 based stuff.  Their toolkit is top notch.

2) If you didn't already get from AMD a PB1500, do it.  The development
platform is a very nice start and will save you may weeks of code testing
headaches (and cause a few special ones).  At least for us here in USA, AMD
"loaned" a board at no charge, i.e. a purchase order is signed but they never
bill you.  We're projected to buy some 25,000 Au1500s per year from them so
that probably helped.

3) From there, look at the 2.4 latest CVS tree on linux-mips and Pete's own
36-bit mods in ftp://ftp.linux-mips.org/pub/linux/mips/people/ppopov/.   
AMD/MontaVista also released a 2.4.18 "like" linux but its a bit rough.

4) there are lots of other resources and headaches if you plan to cross
compile X, gtk, etc.

5) we are flash based and used the special mods Pete put in to the 2.4.17
kernel to support zImage flash booting.  We're using YAMON as our monitor and
with a few changes have a pretty nice setup - boot wise.

Tibor
