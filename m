Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2003 22:14:07 +0100 (BST)
Received: from p508B6C3C.dip.t-dialin.net ([IPv6:::ffff:80.139.108.60]:4246
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225193AbTGUVOF>; Mon, 21 Jul 2003 22:14:05 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6LLE2DB006219;
	Mon, 21 Jul 2003 23:14:02 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6LLE2bA006218;
	Mon, 21 Jul 2003 23:14:02 +0200
Date: Mon, 21 Jul 2003 23:14:02 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030721211402.GC5188@linux-mips.org>
References: <02a701c34f81$4f32ca50$10eca8c0@grendel> <Pine.GSO.3.96.1030721172805.13489C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030721172805.13489C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 21, 2003 at 05:50:08PM +0200, Maciej W. Rozycki wrote:

>  Well, duplication is certainly undesireable, but is it the result of
> separate arch/mips and arch/mips64 trees or is it a side effect only? 
> These separate trees have an advantage of a clear distinction between
> these architectures.  And arch/sparc vs arch/sparc64 were the first case
> of such a split and they seem to feel quite well. 
> 
>  I'd rather keep arch/mips/{lib,mm} and arch/mips64/{lib,mm} where they
> used to be and add, say, arch/mips/{lib,mm}-generic for common stuff. 

Technically these are probably equivalent.  I just felt having mm-32 and
mm-64 makes it more explicit that something can't be shared but really,
that's just directory names and I don't feel strong about them.
I even have some hope that with continuing cleanup mm-32 and mm-64, which
are supposed to contain only things that due to conflicts can't live in
mm, will finally become empty.

  Ralf
