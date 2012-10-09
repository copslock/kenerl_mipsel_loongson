Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2012 19:45:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45602 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6870450Ab2JIRpUtfCkD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Oct 2012 19:45:20 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q99HjJ72031489;
        Tue, 9 Oct 2012 19:45:19 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q99HjHBW031486;
        Tue, 9 Oct 2012 19:45:17 +0200
Date:   Tue, 9 Oct 2012 19:45:17 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Cc:     Chris Dearman <chris@mips.com>,
        "Steven J. Hill" <sjhill@realitydiluted.com>,
        John Crispin <blogic@openwrt.org>
Subject: Kill kspd?
Message-ID: <20121009174517.GB29104@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34662
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

Kspd is executing syscalls from inside kernel space, something that is
fraud with all sorts of problems as identified by Al and anyway, executing
syscalls from kernel space has been something that's been frowned upon
if not deprecated for a long time.  Al may want to elaborate on the issues
but suffice to say it's not pretty.

So I'm wondering, is anybody still using kspd?  Much of kspd's knowledge
of the ABI on the client processor (which might not even be based on SDE!)
should vanish along with the use of syscalls.  If somebody wants to
reengineer kspd I think I'd favor a userspace daemon that just uses a
small kernel communication facility (think of a pipe or socket) for
communication unless somebody finds a good argument (performance?) against
that.  Or and I'd be perfectly fine with that, we could just nuke the
bloody thing.  I receive no feedback on it which makes me assume that
nobody's using it so I'm all in favor for the nuclear solution.

  Ralf
