Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2015 02:09:42 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60858 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010796AbbDIAJgujya7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Apr 2015 02:09:36 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t3909a95023033;
        Thu, 9 Apr 2015 02:09:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t3909YGo023031;
        Thu, 9 Apr 2015 02:09:34 +0200
Date:   Thu, 9 Apr 2015 02:09:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] mips: Fix build if PERF_EVENTS is configured
Message-ID: <20150409000934.GA21107@linux-mips.org>
References: <1428524992-5979-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1428524992-5979-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46840
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

On Wed, Apr 08, 2015 at 01:29:52PM -0700, Guenter Roeck wrote:

> mips builds fail in -next as follows if PERF_EVENTS is configured.
> 
> kernel/built-in.o: In function `perf_sample_regs_user':
> kernel/events/core.c:4828: undefined reference to `perf_get_regs_user'
> 
> The problem is caused by commit 3478e32c1545 ("MIPS: Add user stack and
> registers to perf.") in combination with commit 88a7c26af8da ("perf:
> Move task_pt_regs sampling into arch code"), which introduces
> perf_get_regs_user().
> 
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: David Daney <david.daney@cavium.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I've already applied the same change locally but due to patch ordering
constraints I'm considering to temporarily pull this patch until the
perf stuff and the remainder of the MIPS changes are in 4.1 or so.

Thanks,

  Ralf
