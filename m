Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 10:12:17 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49728 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009731AbbCYJMPyHCMf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Mar 2015 10:12:15 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2P9C9qs031796;
        Wed, 25 Mar 2015 10:12:09 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2P9C881031795;
        Wed, 25 Mar 2015 10:12:08 +0100
Date:   Wed, 25 Mar 2015 10:12:08 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Valentin Rothberg <valentinrothberg@gmail.com>
Cc:     david.daney@cavium.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, lrosenboim@caviumnetworks.com,
        aleksey.makarov@auriga.com
Subject: Re: Enable little endian kernel: misspelled Kconfig item
Message-ID: <20150325091208.GG1385@linux-mips.org>
References: <20150325075720.GA18552@station.rsr.lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150325075720.GA18552@station.rsr.lip6.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46516
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

On Wed, Mar 25, 2015 at 08:57:20AM +0100, Valentin Rothberg wrote:

> Hi David,
> 
> your commit 9861908f081f ("MIPS: OCTEON: Enable little endian kernel.")
> adds the following conditional select to arch/mips/Kconfig:
> 
> +       select SYS_SUPPORTS_HOTPLUG_CPU if CONFIG_CPU_BIG_ENDIAN
> 
> The problem is the 'CONFIG_' prefix for 'CPU_BIG_ENDIAN'.  The item is
> always off since the prefix does not work as we are in a Kconfig file.
> Hence, the if-statement never evaluates to true.
> 
> It can be fixed by simply removing the 'CONFIG_' prefix.
> 
> I detected this commit with ./scripts/checkkconfigsymbols.py.  Commit
> b1a3f243485f ("checkkconfigsymbols.py: make it Git aware") added support
> to check (and compare) undefined Kconfig symbols in Git commits.

I've folded in a fix for the issue.

  Ralf
