Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 12:03:07 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42688 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990765AbdJEKC7tznhE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Oct 2017 12:02:59 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v95A2uex025195;
        Thu, 5 Oct 2017 12:02:56 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v95A2rie025192;
        Thu, 5 Oct 2017 12:02:53 +0200
Date:   Thu, 5 Oct 2017 12:02:53 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Jeff Dike <jdike@addtoit.com>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] mm, arch: remove empty_bad_page*
Message-ID: <20171005100253.GD31821@linux-mips.org>
References: <20171004150045.30755-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004150045.30755-1-mhocko@kernel.org>
User-Agent: Mutt/1.9.0 (2017-09-02)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60281
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

On Wed, Oct 04, 2017 at 05:00:45PM +0200, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> empty_bad_page and empty_bad_pte_table seems to be a relict from old
> days which is not used by any code for a long time. I have tried to find
> when exactly but this is not really all that straightforward due to many
> code movements - traces disappear around 2.4 times.
> 
> Anyway no code really references neither empty_bad_page nor
> empty_bad_pte_table. We only allocate the storage which is not used by
> anybody so remove them.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: <uclinux-h8-devel@lists.sourceforge.jp>
> Cc: <linux-mips@linux-mips.org>
> Cc: <linux-sh@vger.kernel.org>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

On MIPS the empty_bad_page_table definition was deleted in 2549fa57708d
("Small cleanups including deletion of two variables 4k each ...") in the
MIPS git tree on 2003-07-29, so

Acked-by: Ralf Baechle <ralf@linus-mips.org>

for getting rid of the rest a mere 14 years later.

Thanks,

  Ralf
