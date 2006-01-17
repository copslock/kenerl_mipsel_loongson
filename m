Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 15:11:45 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:6162 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133500AbWAQPL2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 15:11:28 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0HFEodO019266;
	Tue, 17 Jan 2006 15:14:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0HFEotR019265;
	Tue, 17 Jan 2006 15:14:50 GMT
Date:	Tue, 17 Jan 2006 15:14:49 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"P. Christeas" <p_christ@hol.gr>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: undefined reference to `__lshrdi3' error with GCC 4.0
Message-ID: <20060117151449.GF3336@linux-mips.org>
References: <20060117134838.GJ27047@deprecation.cyrius.com> <200601171617.16147.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601171617.16147.p_christ@hol.gr>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 17, 2006 at 04:17:14PM +0200, P. Christeas wrote:

> On Tuesday 17 January 2006 3:48 pm, Martin Michlmayr wrote:
> > Has anyone else seen the following error when compiling a kernel with GCC
> > 4.0 (GCC 3.3 works) and knows what to do about it?
> >
> > arch/mips/kernel/built-in.o: In function `time_init':
> > : undefined reference to `__lshrdi3'
> 
> I think I've solved it by copying the files
> ashldi3.c ashrdi3.c lshrdi3.c
> from arch/ppc/lib to arch/mips/lib

No such files in arch/ppc/lib?  Oh well, doesn't matter.

> The patch for 2.6 is:

struct DIstruct seems broken for little endian.

  Ralf
