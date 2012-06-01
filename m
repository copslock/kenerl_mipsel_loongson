Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2012 19:30:18 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:36446 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903608Ab2FARaN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Jun 2012 19:30:13 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q51HUC9P019914
        for <linux-mips@linux-mips.org>; Fri, 1 Jun 2012 18:30:12 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q51HUBaT019913
        for linux-mips@linux-mips.org; Fri, 1 Jun 2012 18:30:11 +0100
Date:   Fri, 1 Jun 2012 18:30:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: Submitting patches, patchwork
Message-ID: <20120601173010.GG7881@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

As some of you have noticed I've barely merged any patches or answered
emails in the past few months for personal reasons and I'm just digging
myself out from the resulting skyhigh mountain of backlog I'm burried
under.  Many of the patches didn't get the Linus mandated soak time in
linux-next much will missed the 3.5 merge window.

I've worked through some of the backlog earlier this week as usual
sorting everything into fixes and small bits that can go to Linus as
after 3.5-rc1 will be released and the bigger, more dangerous bits that
will need to soak until the merge window for 3.6 opens.  This was harder
by some folks resubmitting their patches, sometimes even several times
unchanged from earlier submissions.

I also still have thousands of unread emails.  If you haven't received an
answer yet, please don't take it personal.

Patch submissions that were sent to linux-mips@linux-mips.org will
automatically have been sucked up by patchworks.  This is _the_ reason why
you really want to cc the mailing list on all patch submissions.  Feel
free to cc to my personal address though.

As long as a patch is still listed in patchwork there is no need to resubmit.
But if you resubmit, please mark older versions of your patches as
superseded.

All this is reuired is a patchwork account.  If you don't have one already
creating one at

  http://patchwork.linux-mips.org/

will only take a minute.  A single account can also handle submissions from
multiple email addresses, for example from your work and a gmail address.
Having patchwork know which email addresses belong to the same person helps
when searching for submissions from a single person that is is going to
make my life a tad easier.

One last request - take care of your password for patchwork.  It seems there
is no facility for a user to change his own password, so only a patchwork
sysadmin can replace it when it's lost.

  Ralf
