Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 15:33:43 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:34838 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465575AbWAWPd0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 15:33:26 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0NFbG2f020208;
	Mon, 23 Jan 2006 15:37:16 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0NFbFUi020207;
	Mon, 23 Jan 2006 15:37:15 GMT
Date:	Mon, 23 Jan 2006 15:37:15 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"P. Christeas" <p_christ@hol.gr>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
Message-ID: <20060123153715.GC18665@linux-mips.org>
References: <20060123150507.GA18665@linux-mips.org> <200601231718.40581.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601231718.40581.p_christ@hol.gr>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 23, 2006 at 05:18:38PM +0200, P. Christeas wrote:

> On Monday 23 January 2006 5:05 pm, Ralf Baechle wrote:
> 
> > I'd appreciate if somebody with gcc 4.0.1 could test this kernel patch
> > below.
> >
> >   Ralf
> Is that for 2.4? 

2.4 is a no go for all architectures with gcc >= 4.0.0 and in case of MIPS
even gcc 3.4 is somewhat dubious.

> 2.6 doesn't seem to have that problem..

It's probably a matter of configuration then.  Basically with our current
uaccess.h and gcc >= 4.0.1 the attempt to pass a pointer to a const
variable as the pointer argument to get_user or __get_user will blow up.
It's always been a bug - but gcc before 4.0.1 were accepting this
silently.

  Ralf
