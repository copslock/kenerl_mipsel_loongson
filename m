Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Feb 2008 09:42:44 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:43911 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28590580AbYB1Jml (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Feb 2008 09:42:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1S9gesl005753;
	Thu, 28 Feb 2008 09:42:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1S9ge1M005752;
	Thu, 28 Feb 2008 09:42:40 GMT
Date:	Thu, 28 Feb 2008 09:42:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Move arch/mips/philips to arch/mips/nxp
Message-ID: <20080228094240.GD2750@linux-mips.org>
References: <64660ef00802270250sae0cd4of9512f13f400dfc6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64660ef00802270250sae0cd4of9512f13f400dfc6@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 27, 2008 at 10:50:53AM +0000, Daniel Laird wrote:

> This patch moves arch/mips/philips to arch/mips/nxp
> It also modifies a couple of places from Philips -> nxp for more consistancy.
> 
> This is in preparation for a new set of chip patches coming soon.
> 
> The patch has no other work in in it is primarily a move of current
> code to a new location.
> Have run checkpatch.pl and there are many problems with the patch.
> However none of these are new and are already existing issues in the code base.
> A new patch (to be posted later) will clean up some of these as well.

That's fine.  It's actually prefered to post large scale code movments
and functional changes or other cleanups as separate changes.  Otherwise
it's hard to spot the functional changes in the amalgated mega-patch.

I didn't apply the patch though because several segments of it reject
when applied to top of the latest tree.  The patch headers suggest you
did create the patch against 2.6.24.2.  With a diff of 48MB between
2.6.24.2 and head of tree such a patch is bound to fail.  Anyway, can
you respin the patch against head?

Other nits - please include a Signed-off-by: header, see
Documentation/SubmittingPatches for what it means.  And unless your
mail client does things such as breaking long lines or converting tabs to
spaces please send patches inline.

The usual pointer here: http://www.linux-mips.org/wiki/The_perfect_patch

  Ralf
