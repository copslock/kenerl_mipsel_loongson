Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2003 22:28:44 +0100 (BST)
Received: from mail.theptrgroup.com ([IPv6:::ffff:209.183.211.17]:37386 "EHLO
	mail.theptrgroup.com") by linux-mips.org with ESMTP
	id <S8225524AbTJUV2M>; Tue, 21 Oct 2003 22:28:12 +0100
Received: from [192.168.180.201] (stargate-tacsat.nrl.navy.mil [132.250.144.104] (may be forged))
	by mail.theptrgroup.com (8.11.6/linuxconf) with ESMTP id h9LLS6T17767;
	Tue, 21 Oct 2003 17:28:11 -0400
Subject: Re: module dependency files
From: Jeff Angielski <jeff@theptrgroup.com>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <Pine.GSO.4.44.0310211717110.14194-100000@ares.mmc.atmel.com>
References: <Pine.GSO.4.44.0310211717110.14194-100000@ares.mmc.atmel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1066771519.3289.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Oct 2003 17:25:20 -0400
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@theptrgroup.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@theptrgroup.com
Precedence: bulk
X-list: linux-mips

>From the Linux kernel Makefile...

#
# INSTALL_MOD_PATH specifies a prefix to MODLIB for module directory
# relocations required by build roots.  This is not defined in the
# makefile but the arguement can be passed to make if needed.
#
                                                                                Just set this to the location of your target filesystem when you do the modules_install.

Jeff Angielski
The PTR Group

On Tue, 2003-10-21 at 17:22, David Kesselring wrote:
> I have now gotten the modules to build but there is one part of the
> process that doesn't work. On my pc I want to build all of the files which
> are to be installed on the mips board. I am trying to create the files
> which can be copied onto (or into) the redhat 7.3 miniport. "make modules"
> works fine. It seems like I need to run "make modules_install" but it
> complains about the .o files being the wrong architecture. So the basic
> question seems to be how can I run depmod on the pc for mips?
> Thanks again.
> 
> David Kesselring
> Atmel MMC
> dkesselr@mmc.atmel.com
> 919-462-6587
> 
