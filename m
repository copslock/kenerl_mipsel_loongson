Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2003 09:51:14 +0100 (BST)
Received: from p508B5748.dip.t-dialin.net ([IPv6:::ffff:80.139.87.72]:9131
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225348AbTIJIvM>; Wed, 10 Sep 2003 09:51:12 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8A8p6LT010441;
	Wed, 10 Sep 2003 10:51:06 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8A8p5fS010440;
	Wed, 10 Sep 2003 10:51:05 +0200
Date: Wed, 10 Sep 2003 10:51:04 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030910085104.GA10393@linux-mips.org>
References: <20030909113150Z8225348-1272+5180@linux-mips.org> <Pine.GSO.3.96.1030909153721.18373A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030909153721.18373A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 09, 2003 at 03:40:44PM +0200, Maciej W. Rozycki wrote:

> > 	Avoid conflict with glibc on bigendian platforms when -O or higher
> > 	is specified.  It's already in 2.6, and I'm not sure why it hasn't
> > 	been seen in 2.4.  The symptom is that this program will not compile
> > 	with -O2:
> > 	
> > 	#include <asm/byteorder.h>
> > 	#include <netinet/in.h>
> > 	int main () { }
> 
>  Is <asm/byteorder.h> ever included by glibc headers?  I hope not and user
> programs *must* not include kernel headers.  Your program is buggy.

I'd not have accepted such a patch for exactly that reason if it wasn't
already in 2.6.

  Ralf
