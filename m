Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2004 13:46:54 +0000 (GMT)
Received: from p508B7347.dip.t-dialin.net ([IPv6:::ffff:80.139.115.71]:54891
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224916AbUAYNqy>; Sun, 25 Jan 2004 13:46:54 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0PDkqex018642;
	Sun, 25 Jan 2004 14:46:52 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0PDkpLS018641;
	Sun, 25 Jan 2004 14:46:51 +0100
Date: Sun, 25 Jan 2004 14:46:51 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] 32bit module support
Message-ID: <20040125134651.GA8209@linux-mips.org>
References: <20040123182436.C27362@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123182436.C27362@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 23, 2004 at 06:24:36PM -0800, Jun Sun wrote:

> There is one worrisome "FIXME" in that file, which is not clear
> to me.  Ralf?

That comment was copied over from i386.  It it works for them it must be
good for us ;-)

  Ralf
