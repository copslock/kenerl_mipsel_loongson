Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 20:48:19 +0100 (BST)
Received: from p508B5A54.dip.t-dialin.net ([IPv6:::ffff:80.139.90.84]:45220
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224827AbTFJTsQ>; Tue, 10 Jun 2003 20:48:16 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5AJmEbY007899;
	Tue, 10 Jun 2003 12:48:14 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5AJmDxg007898;
	Tue, 10 Jun 2003 21:48:13 +0200
Date: Tue, 10 Jun 2003 21:48:13 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Dennis Castleman <DennisCastleman@oaktech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: MIPS CACHE TESTS
Message-ID: <20030610194813.GB6310@linux-mips.org>
References: <56BEF0DBC8B9D611BFDB00508B5E2634102FAC@tlexposeidon.teralogic-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56BEF0DBC8B9D611BFDB00508B5E2634102FAC@tlexposeidon.teralogic-inc.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 06, 2003 at 11:00:23AM -0700, Dennis Castleman wrote:

(Well, not Dennis but Spamassassin ...)

> This mail is probably spam.  The original message has been attached
> along with this report, so you can recognize or block similar unwanted
> mail in future.  See http://spamassassin.org/tag/ for more details.

Of course it's not been spam, sorry for that faux pas.  This has been the
first false hit since I'm running Spamassassin for the linux-mips.org
mailing lists and so turned out a little bug in the scripts.

In any case, sending HTML to any of the linux-mips.org lists is an almost
certai way to get caught by the spam filter - HTML email on Linux mailing
lists is an almost certain indicator of SPAM ...

Back to the real business ...

> Subject: MIPS CACHE TESTS

> I trying to find a way of test both the instruction and data caches for a
> MIPS 5KC core.
> Does any body have any ideas?  Data cache is easy instruction cache is not
> so easy.

The trick is to run uncached.

> The Magnum pc-50 use to have a monitor called Rx4230 MIPS Monitor.
> This monitor dumped the following on power up

You're the first one to post about using Magnums in quite a while ...

> PONs Complete...
> PON Diagnostics Version 5.05 MIPS OPT Fri May 29 14:22:07 
>  
> YOMAN doesn't have any thing like this.  If any one knows of power on tests
> for a 5KC it would be of great interest to me.

I don't know of any readily available code.  The general strategy is to
run the cache tests in uncached mode and use the Index_Load_Tag_I etc.
commands to manipulate the cache content directly.  The general
strategy is to first verify that there are no dead bits in the cache,
the initialize all cache indices such that the ECC are set correctly to
avoid a later cache error exception.  For some set-way associative caches
the LRU bits may also have to be initialized.

Linux expects all this to already have been done by the firmware before
it's started.

  Ralf
