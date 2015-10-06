Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 12:51:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45859 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008699AbbJFKvuC3eqc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Oct 2015 12:51:50 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t96ApnIq025753
        for <linux-mips@linux-mips.org>; Tue, 6 Oct 2015 12:51:49 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t96ApnAS025752
        for linux-mips@linux-mips.org; Tue, 6 Oct 2015 12:51:49 +0200
Date:   Tue, 6 Oct 2015 12:51:49 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: Syscall numbers for userfaultfd, membarrier and mlock2
Message-ID: <20151006105148.GA25680@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49444
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

I recently wired up the new syscalls userfaultfd and membarrier.  The
syscall numbers allocated for these do conflict with the syscall number
allocated to mlock2 in the mm tree so today's linux-next tree changes
that allocation.

  Ralf
