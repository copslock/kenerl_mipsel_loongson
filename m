Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jan 2005 19:42:30 +0000 (GMT)
Received: from pD95627FC.dip.t-dialin.net ([IPv6:::ffff:217.86.39.252]:788
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224842AbVAOTm0>; Sat, 15 Jan 2005 19:42:26 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0FJgLPn015742;
	Sat, 15 Jan 2005 20:42:21 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j0FJgKcr015741;
	Sat, 15 Jan 2005 20:42:20 +0100
Date: Sat, 15 Jan 2005 20:42:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Michael Stickel <michael.stickel@4g-systems.biz>
Cc: linux-mips@linux-mips.org
Subject: Re: Au1500 PCI-Bus error handler.
Message-ID: <20050115194219.GA15595@linux-mips.org>
References: <200501141819.46601.michael.stickel@4g-systems.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501141819.46601.michael.stickel@4g-systems.biz>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 14, 2005 at 06:19:46PM +0100, Michael Stickel wrote:

> I'm currently implementing an Au1500 PCI-Bus error handler, that printk's PCI 
> Errors. The Au1500 has a PCI error reporting interrupt (AU1500_PCI_ERR_INT = 
> 22). Has someone in the list some experience with that? And, does someone 
> know how I can generate a PCI-Bus error?

Touching a PCI address that doesn't belong to any device is usually a
promising attempt ;-)

  Ralf
