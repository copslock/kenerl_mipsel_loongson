Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 16:17:59 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:61464 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133500AbWAQQRm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 16:17:42 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0HGLBS6002413;
	Tue, 17 Jan 2006 16:21:11 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0HGLBb2002412;
	Tue, 17 Jan 2006 16:21:11 GMT
Date:	Tue, 17 Jan 2006 16:21:11 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"P. Christeas" <p_christ@hol.gr>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: undefined reference to `__lshrdi3' error with GCC 4.0
Message-ID: <20060117162111.GG3336@linux-mips.org>
References: <20060117134838.GJ27047@deprecation.cyrius.com> <200601171617.16147.p_christ@hol.gr> <20060117151449.GF3336@linux-mips.org> <200601171750.22746.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601171750.22746.p_christ@hol.gr>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 17, 2006 at 05:50:20PM +0200, P. Christeas wrote:

> > No such files in arch/ppc/lib?  Oh well, doesn't matter.
> It was from m68k  :S 
> 
> > > The patch for 2.6 is:
> >
> > struct DIstruct seems broken for little endian.
> What consequences does that have?

Wrong results of 64-bit shift operations when building with -Os.

  Ralf
