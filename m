Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Oct 2004 12:10:06 +0100 (BST)
Received: from pD9562C39.dip.t-dialin.net ([IPv6:::ffff:217.86.44.57]:60432
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225262AbUJMLKC>; Wed, 13 Oct 2004 12:10:02 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9DB9mTG007024;
	Wed, 13 Oct 2004 13:09:48 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9DB9llb007023;
	Wed, 13 Oct 2004 13:09:47 +0200
Date: Wed, 13 Oct 2004 13:09:47 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Bjoern Riemer <riemer@fokus.fraunhofer.de>
Cc: ppopov@embeddedalley.com, linux-mips@linux-mips.org
Subject: Re: meshcube patch for au1000 network driver
Message-ID: <20041013110947.GA6992@linux-mips.org>
References: <416BC4D9.2060904@fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416BC4D9.2060904@fokus.fraunhofer.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 12, 2004 at 01:49:45PM +0200, Bjoern Riemer wrote:

> hi
> i fixed the ioctl support in the net driver to support link detection by
>   ifplugd ond maybe netplugd(not tested)
> here my patch for
> drivers/net/au1000.c

Please never ever send ed-style patches, only unified (-u).  They're
totally unreadable and have several technical problems.  And preferbly
inline, not attachment.

  Ralf
