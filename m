Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 18:44:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42296 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835182Ab3FQQohz0qWO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jun 2013 18:44:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5HGiXcg018293;
        Mon, 17 Jun 2013 18:44:33 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5HGiSRi018292;
        Mon, 17 Jun 2013 18:44:28 +0200
Date:   Mon, 17 Jun 2013 18:44:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, sibyte-users@bitmover.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/7] MIPS: sibyte: Add missing sched.h header
Message-ID: <20130617164427.GE10408@linux-mips.org>
References: <1371477641-7989-1-git-send-email-markos.chandras@imgtec.com>
 <1371477641-7989-4-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371477641-7989-4-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36954
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

On Mon, Jun 17, 2013 at 03:00:37PM +0100, Markos Chandras wrote:

> It's needed for the TASK_INTERRUPTIBLE definition.
> 
> Fixes the following build problem:
> arch/mips/sibyte/common/sb_tbprof.c:235:4: error: 'TASK_INTERRUPTIBLE'
> undeclared (first use in this function)

Ideally sched.h should be included into the actual user of
TASK_INTERRUPTIBLE, the wake_up_interruptible macro in <linux/wait.h> but
that seems way too risky that close to a release.

  Ralf
