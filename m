Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2006 03:50:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:4833 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133606AbWCGDuI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2006 03:50:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k273wRa8026956;
	Tue, 7 Mar 2006 03:58:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k273wOlc026954;
	Tue, 7 Mar 2006 03:58:24 GMT
Date:	Tue, 7 Mar 2006 03:58:24 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Francois Romieu <romieu@fr.zoreil.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH, RESEND] Add MWI workaround for Tulip DC21143
Message-ID: <20060307035824.GA24018@linux-mips.org>
References: <20060129230816.GD4094@colonel-panic.org> <20060218220851.GA1601@colonel-panic.org> <20060306225131.GA23327@unjust.cyrius.com> <20060306231530.GB16082@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306231530.GB16082@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 07, 2006 at 12:15:30AM +0100, Francois Romieu wrote:

> [...]
> > Does anyone have comments regarding this patch?  I received
> > confirmation from a number of Debian users that this patch
> > significantly improves the lockup situation on Cobalt, so
> > it would be nice if it could go in.
> 
> I'll queue it with the pending de2104x fix(es ?) during my next
> upkeep.

I'm just not convinced of having such a workaround as a build option.
The average person building a a kernel will probably not know if the
option needs to be enabled or not.

  Ralf
