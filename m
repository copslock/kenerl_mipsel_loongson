Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Aug 2004 20:25:30 +0100 (BST)
Received: from p508B66F0.dip.t-dialin.net ([IPv6:::ffff:80.139.102.240]:62522
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225211AbUHWTZX>; Mon, 23 Aug 2004 20:25:23 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7NJPKlU030192;
	Mon, 23 Aug 2004 21:25:20 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7NJPKik030191;
	Mon, 23 Aug 2004 21:25:20 +0200
Date: Mon, 23 Aug 2004 21:25:20 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: Daniel Jacobowitz <dan@debian.org>,
	Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
Message-ID: <20040823192520.GC29165@linux-mips.org>
References: <20040804152936.D6269@mvista.com> <16676.46694.564448.344602@arsenal.mips.com> <20040819221646.GC8737@mvista.com> <16678.163.774841.111369@arsenal.mips.com> <20040823132853.GA31354@nevyn.them.org> <20040823173731.GC23004@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823173731.GC23004@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 23, 2004 at 10:37:31AM -0700, Jun Sun wrote:

> Are you implying one can implement TLS support without changing O32
> ABI?  Interesting...
> 
> I know Boris Hu has tried to implemented NPTL with another approach which
> does not rely on TLS support (use "--without-tls").  According to him
> this approach is getting harder these days.

The whole TLS pointer thing is about making TLS more efficient.  If
you wanted to use TLS without any kernel changes you could do that
based on the THREAD result value of pthread_create or something like
that.  It'd work but it'd also not be terribly efficient ...

  Ralf
