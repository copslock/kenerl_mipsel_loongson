Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 23:06:26 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:35086 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133711AbWCAXGQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 23:06:16 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 39A5A64D3D; Wed,  1 Mar 2006 23:14:06 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id D07F986BB; Thu,  2 Mar 2006 00:13:58 +0100 (CET)
Resent-From: tbm@cyrius.com
Resent-Date: Wed, 1 Mar 2006 23:13:58 +0000
Resent-Message-ID: <20060301231358.GR26088@deprecation.cyrius.com>
Resent-To: linux-mips@linux-mips.org
Received: by deprecation.cyrius.com (Postfix, from userid 10)
	id 887B191C2; Thu,  2 Mar 2006 00:12:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sorrow.cyrius.com (Postfix) with ESMTP id D501D64D3E
	for <tbm@cyrius.com>; Wed,  1 Mar 2006 22:40:13 +0000 (UTC)
Received: from nephila.localnet (i-83-67-53-76.freedom2surf.net [83.67.53.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sorrow.cyrius.com (Postfix) with ESMTP id E11F764D3D
	for <tbm@cyrius.com>; Wed,  1 Mar 2006 22:40:04 +0000 (UTC)
Received: from pdh by nephila.localnet with local (Exim 4.50)
	id 1FEZzF-0000Dj-Dx
	for tbm@cyrius.com; Wed, 01 Mar 2006 22:40:01 +0000
Date:	Wed, 1 Mar 2006 22:40:01 +0000
To:	Martin Michlmayr <tbm@cyrius.com>
Subject: Re: Crash on Cobalt with CONFIG_SERIO=y
Message-ID: <20060301224001.GA719@colonel-panic.org>
References: <20060120004208.GA18327@deprecation.cyrius.com> <20060120144710.GA30415@linux-mips.org> <20060121010455.GC3514@colonel-panic.org> <20060228165404.GA8442@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228165404.GA8442@deprecation.cyrius.com>
User-Agent: Mutt/1.5.9i
From:	Peter Horton <pdh@colonel-panic.org>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cyrius.com
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 28, 2006 at 04:54:05PM +0000, Martin Michlmayr wrote:
> * Peter Horton <pdh@colonel-panic.org> [2006-01-21 01:04]:
> > > >  Real Time Clock Driver v1.12a
> > > >  Cobalt LCD Driver v2.10
> > > >  i8042.c: i8042 controller self test timeout.
> > > >  Unhandled kernel unaligned access[#1]:
> > > 
> > > The i8042 error message is a little surprising.  The Cobalt boards afair
> > No SuperIO, but there is a bog standard VIA PCI-ISA bridge which
> > contains a bog standard PS/2 keyboard controller, which you would have
> > thought should just work ...
> 
> That's really interesting.  I tried latest git (2.6.16-rc5) to see if
> this is still there.  First of all, 32-bit is fine, both regarding
> i8042 as well as ALSA with a PCI audio card.  With a 64-bit kernel,
> i8042 appears to be okay now.  I get:
> 
> Cobalt LCD Driver v2.10
> i8042.c: i8042 controller self test timeout.
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> 
> and the kernel boots fine.
> 
> I then built ALSA support into the kernel to see whether
> http://www.linux-mips.org/archives/linux-mips/2006-01/msg00325.html
> disappeared too.  I got almost the same oops as the one I got before
> because of i8042.
> 
> Peter, does that make any sense to you?  I assume your recent PCI fix
> may be related.
> 

Those addresses that begin 9b640000 (including the fault address) look
very strange. The low 32-bits look like a valid physical address in the
PCI space but the top bits definitely don't look right (unless the
kernel's playing tricks with unused address bits; I'll have to check the
RM523x data sheet to see if they have any effect). Have any of the MIPs
experts commented ?

> 
> BadVA : 9b64000001014c87
>

P.
