Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jan 2005 22:07:27 +0000 (GMT)
Received: from pD95623F3.dip.t-dialin.net ([IPv6:::ffff:217.86.35.243]:18036
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225397AbVAHWHX>; Sat, 8 Jan 2005 22:07:23 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j08M7JiD024652;
	Sat, 8 Jan 2005 23:07:19 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j08M7FXv024651;
	Sat, 8 Jan 2005 23:07:15 +0100
Date: Sat, 8 Jan 2005 23:07:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050108220715.GA24597@linux-mips.org>
References: <20050108180025Z8225397-1340+834@linux-mips.org> <41E041BF.1020405@total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E041BF.1020405@total-knowledge.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 08, 2005 at 12:25:35PM -0800, Ilya A. Volynets-Evenbakh wrote:

> >Modified files:
> >	include/asm-mips: bitops.h 
> >
> >Log message:
> >	Fix int vs. long bugs breaking the non-ll/sc case on 64-bit.

Argh.  One of these days ;)

  Ralf
