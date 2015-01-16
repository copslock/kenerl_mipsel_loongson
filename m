Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 15:47:09 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45177 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010547AbbAPOrGZEf4S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jan 2015 15:47:06 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id t0GEl4v2031554;
        Fri, 16 Jan 2015 15:47:04 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id t0GEl4uW031553;
        Fri, 16 Jan 2015 15:47:04 +0100
Date:   Fri, 16 Jan 2015 15:47:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Daniel Sanders <daniel.sanders@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Behan Webster <behanw@converseincode.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v2] MIPS: Changed current_thread_info() to an equivalent
 supported by both clang and GCC
Message-ID: <20150116144703.GC22296@linux-mips.org>
References: <1420894360-13479-1-git-send-email-daniel.sanders@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1420894360-13479-1-git-send-email-daniel.sanders@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45227
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

On Sat, Jan 10, 2015 at 12:52:40PM +0000, Daniel Sanders wrote:

> The problem is that clang doesn't honour named registers on local variables
> and silently treats them as normal uninitialized variables. However, it
> does honour them on global variables.

Older versions of <asm/unistd.h> which have been copied into some userland
packages are using some local register variables in syscall wrappers.  These
syscall wrappers have historically been a pain because every once in a
while they got broken by a new GCC release or other issues.  If you're
lucky that has been resolved by the maintainers of those external software
packages - the only way to be certain is the review ...

At least the kernel does no longer do syscalls.

  Ralf
