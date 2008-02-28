Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Feb 2008 16:10:51 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:27343 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28591555AbYB1QKt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Feb 2008 16:10:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1SGAmmp010745;
	Thu, 28 Feb 2008 16:10:48 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1SGAl0c010744;
	Thu, 28 Feb 2008 16:10:47 GMT
Date:	Thu, 28 Feb 2008 16:10:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"M. Warner Losh" <imp@bsdimp.com>
Cc:	daniel.j.laird@nxp.com, linux-mips@linux-mips.org
Subject: Re: Move arch/mips/philips to arch/mips/nxp
Message-ID: <20080228161047.GA10704@linux-mips.org>
References: <64660ef00802270250sae0cd4of9512f13f400dfc6@mail.gmail.com> <20080228094240.GD2750@linux-mips.org> <20080228.090058.-126817608.imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080228.090058.-126817608.imp@bsdimp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 28, 2008 at 09:00:58AM -0700, M. Warner Losh wrote:

> Are the references to BitKeeper still relevant here?

Vaguely.  A while ago bk was in common use in the Linux community.  The
licenses for bitkeeper were withdrawn around April 2005 so it's probably
time to remove them.

> >> Bear in mind that the Subject: of your email becomes a
> >> globally-unique identifier for that patch. It propagates all the
> >> way into BitKeeper. The Subject: may later be used in developer
> ------------^^^^^^^^^
> >> discussions which refer to the patch. People will want to google
> >> for the patch's Subject: to read discussion regarding that patch.
> 
> and
> 
> >> Do not refer to earlier patches when changelogging a new version of
> >> a patch. It's not very useful to have a bitkeeper changelog which
> -------------------------------------------^^^^^^^^^
> >> says "OK, this fixes the things you mentioned yesterday". Each
> >> iteration of the patch should contain a standalone changelog. This
> >> implies that you need a patch management system which maintains
> >> changelogs. See below.
> 
> and
> 
> >> Don't bother mentioning what version of the kernel the patch
> >> applies to ("applies to 2.6.8-rc1"). This is not interesting
> >> information - once the patch is in bitkeeper, of _course_ it
> --------------------------------------^^^^^^^^^
> >> applied, and it'll probably be merged into a later kernel than the
> >> one which you wrote it for.

Akpm wrote that.  I wonder if he's got an updated version of this.

  Ralf
