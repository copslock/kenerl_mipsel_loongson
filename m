Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2014 13:50:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57075 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6816676AbaBDMu1hhvmM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Feb 2014 13:50:27 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s14CoPQi008823;
        Tue, 4 Feb 2014 13:50:25 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s14CoOXV008822;
        Tue, 4 Feb 2014 13:50:24 +0100
Date:   Tue, 4 Feb 2014 13:50:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Wire up sched_setattr/sched_getattr syscalls
Message-ID: <20140204125024.GG9390@linux-mips.org>
References: <1391516941-20260-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1391516941-20260-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39206
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

On Tue, Feb 04, 2014 at 12:29:01PM +0000, James Hogan wrote:

> Wire up for MIPS the new sched_setattr and sched_getattr system calls
> added in commit d50dde5a10f3 (sched: Add new scheduler syscalls to
> support an extended scheduling parameters ABI) merged in v3.14-rc1.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

Lookin' good, applied.

  Ralf
