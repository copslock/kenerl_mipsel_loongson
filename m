Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 15:55:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46458 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492848AbZKKOzd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Nov 2009 15:55:33 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nABEtU3F014005
	for <linux-mips@linux-mips.org>; Wed, 11 Nov 2009 15:55:34 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nABEtTTR014003
	for linux-mips@linux-mips.org; Wed, 11 Nov 2009 15:55:29 +0100
Date:	Wed, 11 Nov 2009 15:55:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Patchwork
Message-ID: <20091111145529.GA11567@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Many of you may already have heared about it - I've installed patchwork
on http://patchwork.linux-mips.org.  The system is now running mostly
flawless so time to announce it.

What is patchwork?

Patchwork is a patch tracking system.  It is subscribed to the linux-mips
mailing list and automatically sifts throuogh the list for patches posted.
The web interface allows anybody to see which patches are still pending,
are under review, have been applied or rejected.

Patchwork also keeps track of replies to patches so it's often easier to
follow than by using a mail reader.  Patchworks also collects Acked-by:,
Signed-off-By: lines so when downloading a patch from the web interface
the log messages will have been updated to contain the updated tags.

Why is patchwork a good thing?

It allows a maintainer to keep a good overview over all the pending patches.
Unlike many previous systems that were implemented or suggested it doesn't
get into the way of established patch submission and handling practices
but rather provides a tool to automate a part of necessary procedures.

What does patchworks mean for patch submissions?

Patchwork is subscribed to the linux-mips mailing list.  So it will only
keep track of patches that have been posted to the linux-mips mailing list
but not of patches that have been sent in private to me.  This is a problem
so I'm considering to reject patches that have not been submitted to the
mailing list as a matter of policy.

Beyond that it's largely up to the patch submitter.  For a submitter who
doesn't use patchwork things will work the same way they used to work.

What new advanced features deos patchwork offer to submitters?

Submitters can create an account on patchworks.  They can change the
status of their patches - which are identified as theirs by the submitter's
email address - for example when they wish withdraw a patch because it
was found faulty or are about to send a better revision.

There is also a feature to create patch bundles from several patches which
then can be downloaded as a single download.

Which patches are tracked in patchworks?

I've installed patchworks about four weeks ago.  For testing purposes and
also to ensure I've not dropped anything on the floor I've fed the
mailing list archives back to June 2009 into patchworks, then manually
walked through the hundreds of patches to ensure all patches have been
handled.

If you've sent patches that have not been applied yet and don't show up
in patchworks as new or under review, then please resent your patches.

  Ralf
