Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 21:35:14 +0100 (BST)
Received: from p508B6E02.dip.t-dialin.net ([IPv6:::ffff:80.139.110.2]:56102
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226083AbUEZUdr>; Wed, 26 May 2004 21:33:47 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i4QKXk6q008768;
	Wed, 26 May 2004 22:33:46 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i4QKXkn2008767;
	Wed, 26 May 2004 22:33:46 +0200
Date: Wed, 26 May 2004 22:33:46 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Emmanuel Michon <em@realmagic.fr>
Cc: linux-mips@linux-mips.org
Subject: Re: down_trylock() implementation for MIPS 4KEc CPU implies 64bit arithmetics?
Message-ID: <20040526203346.GA8430@linux-mips.org>
References: <1085589315.2306.49.camel@avalon.france.sdesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085589315.2306.49.camel@avalon.france.sdesigns.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5198
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 26, 2004 at 06:35:16PM +0200, Emmanuel Michon wrote:

Semaphores can be implemented using just a single 32-bit variable which
would mean the same code could be used for 32-bit and 64-bit processors
as long as only they support ll/sc.  Maybe somebody has the time at his
hands, *hint*, *hint* :-)

  Ralf
