Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 10:21:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47679 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6870535Ab2JJIVRBhRaK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Oct 2012 10:21:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9A8LGE4008334
        for <linux-mips@linux-mips.org>; Wed, 10 Oct 2012 10:21:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9A8LFWH008333
        for linux-mips@linux-mips.org; Wed, 10 Oct 2012 10:21:15 +0200
Date:   Wed, 10 Oct 2012 10:21:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: [ADMIN] Issues with new linux-mips.org machine
Message-ID: <20121010082115.GA7974@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34667
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

As you probably noticed there were a few kinks after last week's migration
to the new machine, in particular the spam filter was somehow a little
generous in what it allowed through.  This may need more fine tuning but
one of the issues was that spamassassin didn't like it own database files
anymore after the system's OS had been upgraded by 4 releases.

Also during the last night the system crashed twice and required manual
intervention to reboot resulting in some downtime.  The cause of this has
been plugged as well.

  Ralf
