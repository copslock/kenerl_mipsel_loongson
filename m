Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Apr 2017 00:48:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33320 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993934AbdDLWscd8grP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Apr 2017 00:48:32 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3CMmVMh007927;
        Thu, 13 Apr 2017 00:48:31 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3CMmUQS007926;
        Thu, 13 Apr 2017 00:48:30 +0200
Date:   Thu, 13 Apr 2017 00:48:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, trivial@kernel.org
Subject: Re: [PATCH] MIPS: Remove confusing else statement in
 __do_page_fault()
Message-ID: <20170412224830.GA7899@linux-mips.org>
References: <20170330212703.32066-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330212703.32066-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57683
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

On Thu, Mar 30, 2017 at 02:27:02PM -0700, Paul Burton wrote:

> Commit 41c594ab65fc ("[MIPS] MT: Improved multithreading support.")
> added an else case to an if statement in do_page_fault() (which has
> since gained 2 leading underscores) for some unclear reason. If the
> condition in the if statement evaluates true then we execute a goto &
> branch elsewhere anyway, so the else has no effect. Combined with an #if
> 0 block with misleading indentation introduced in the same commit it
> makes the code less clear than it could be.
> 
> Remove the unnecessary else statement & de-indent the printk within
> the #if 0 block in order to make the code easier for humans to parse.

Yuck ...

Applied.  Thanks!

  Ralf
