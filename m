Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Feb 2004 18:18:22 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:21931 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225486AbUBSSSU>;
	Thu, 19 Feb 2004 18:18:20 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1Atska-0006Ld-M8; Thu, 19 Feb 2004 13:18:16 -0500
Date: Thu, 19 Feb 2004 13:18:16 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Indigodfw <indigodfw@yahoo.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: question about memory constraint in atomic_add
Message-ID: <20040219181816.GA24189@nevyn.them.org>
References: <20040218134501.GA24330@linux-mips.org> <20040219001132.30180.qmail@web9503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219001132.30180.qmail@web9503.mail.yahoo.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 18, 2004 at 04:11:32PM -0800, Indigodfw wrote:
> Well, is not that what we want?
> That is, we want to load (using ll) from &v->counter.
> 
> Should not the code have been
> ll     %0, 0(%1) 
> where %1 is "=m" (&v->counter)

No, it would be ll %0, %1.  The result of an m constraint will be a
register-and-offset term like 0($13) or 256($13).

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
