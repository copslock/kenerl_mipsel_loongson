Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 10:30:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44331 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009413AbbGNIagAx5bx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jul 2015 10:30:36 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6E8UYJt025619;
        Tue, 14 Jul 2015 10:30:34 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6E8UUf8025618;
        Tue, 14 Jul 2015 10:30:30 +0200
Date:   Tue, 14 Jul 2015 10:30:30 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: PCI: ops-emma2rh: drop nonsensical db_assert
Message-ID: <20150714083029.GA25179@linux-mips.org>
References: <1436804062-30041-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436804062-30041-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48258
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

On Mon, Jul 13, 2015 at 05:14:21PM +0100, Paul Burton wrote:

> The db_assert call checks whether the bus_num pointer is non-NULL, but
> does so after said pointer has been dereferenced by the assignment on
> the previous line. Thus the check is pointless & likely to have been
> optimised out by the compiler anyway. The check_args function is static
> & only ever called from the local file with bus_num being a pointer to
> an on-stack variable, so the check seems somewhat overzealous anyway.
> Simply remove it.

Thanks, applied.

Your patch btw. leaves the db_verify() macro as the sole caller of
db_assert() and db_verify() itself is unused and in fact, nothing
includes <asm/debug.h> anymore.  Removing <asm/debug.h> leaves
CONFIG_RUNTIME_DEBUG unused, so I'm removing that one, too.

  Ralf
