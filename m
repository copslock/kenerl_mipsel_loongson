Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Apr 2004 18:31:59 +0100 (BST)
Received: from p508B578D.dip.t-dialin.net ([IPv6:::ffff:80.139.87.141]:29234
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225788AbUDARb6>; Thu, 1 Apr 2004 18:31:58 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i31HVuoM029524;
	Thu, 1 Apr 2004 19:31:56 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i31HVsWI029522;
	Thu, 1 Apr 2004 19:31:54 +0200
Date: Thu, 1 Apr 2004 19:31:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Brian Murphy <brian@murphy.dk>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org
Subject: Re: BUG in pcnet32.c?
Message-ID: <20040401173154.GA30634@linux-mips.org>
References: <4068809F.8070103@murphy.dk> <4068864D.1020209@realitydiluted.com> <406B2E90.5060307@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406B2E90.5060307@murphy.dk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 31, 2004 at 10:48:16PM +0200, Brian Murphy wrote:

> Not sure what you mean. I get the panic "Break instruction in kernel 
> code" from do_bp
> in traps.c. This seems like a strange "assertion" to me...

The more information BUG or BUG_ON provide the bigger the kernel gets.
Using a simple break instruction was simply the smallest thing.  The
previous, just slightly more verbose BUG() implementation did result
in ~ 87k of bloat ...

  Ralf
