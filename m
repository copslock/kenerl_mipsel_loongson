Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 17:11:28 +0100 (CET)
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59620 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493538AbZKRQLW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2009 17:11:22 +0100
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DEF1BC0CDD;
	Wed, 18 Nov 2009 11:11:18 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Wed, 18 Nov 2009 11:11:18 -0500
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=4rCjDeUUq98XIca6rLk8zB0ydBU=; b=d+Bz8o7oSxeMMvqeVRKTzVi8PAUdRL4NnvaazSO5oKe8Kx6ajN99bOiE4qiBJBDJej4jrRSULYA7J4tbcl6WKQ/mFaHqwaBzhyykevs97i0hQNsHxl6KrXGfZM5U/0JLG2RrYeJ8bbo4CgjMbb+NciridvGm2+RncOVgL7odnF4=
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id BBB1310565B; Wed, 18 Nov 2009 11:11:18 -0500 (EST)
Message-Id: <1258560678.3739.1345870183@webmail.messagingengine.com>
X-Sasl-Enc: DsaM8jiznorPVziJtpV4yRZkj8d88ZVMJsKl5WURCJUp 1258560678
From:	myuboot@fastmail.fm
To:	"David VomLehn" <dvomlehn@cisco.com>
Cc:	"Florian Fainelli" <florian@openwrt.org>,
	"Chris Dearman" <chris@mips.com>,
	"linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4B031B78.5030204@mips.com>
 <1258504293.3627.1345755107@webmail.messagingengine.com>
 <200911180139.29283.florian@openwrt.org>
 <1258505915.7077.1345760963@webmail.messagingengine.com>
 <20091118010351.GA21728@dvomlehn-lnx2.corp.sa.net>
Subject: Re: problem bring up initramfs and busybox
In-Reply-To: <20091118010351.GA21728@dvomlehn-lnx2.corp.sa.net>
Date:	Wed, 18 Nov 2009 10:11:18 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips



On Tue, 17 Nov 2009 20:03 -0500, "David VomLehn" <dvomlehn@cisco.com>
wrote:
> On Tue, Nov 17, 2009 at 06:58:35PM -0600, myuboot@fastmail.fm wrote:
> > 
> > On Wed, 18 Nov 2009 01:39 +0100, "Florian Fainelli"
> > <florian@openwrt.org> wrote:
> > > -------------------------------
> > Actually I already got this patch for the board in little endian mode,
> > and it is still there for the big endian mode. And this is one of the
> > place I have been wondering if that needs to be changed for big endian. 
> 
> It sounds like you've done a good job getting the bootloader and kernel
> to work, so this may be a silly suggestion, but are you sure your root
> filesystem and busybox are little-endian? It would be an easy mistake to
> make...
> 
> > thanks. Andrew
> 
> David VL

I am pretty sure the filesystem and busybox are big endian. I can see
the following print out when the filesystem is built for big endian
mode. 
"Swapping filesystem endian-ness"
Though I don't know if there is a command to check the endianess of a
filesystem directly.

And below is the header info of the busybox showing it is a big endian
object.
readelf -h busybox-1.14.3/busybox
ELF Header:
  Magic:   7f 45 4c 46 01 02 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, big endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x4001b0
  Start of program headers:          52 (bytes into file)
  Start of section headers:          926564 (bytes into file)
  Flags:                             0x50001007, noreorder, pic, cpic,
  o32, mips32
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         3
  Size of section headers:           40 (bytes)
  Number of section headers:         19
  Section header string table index: 18
Thanks, Andrew
