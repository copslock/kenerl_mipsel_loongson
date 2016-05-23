Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 17:20:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55480 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27033472AbcEWPUOX-zVu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 May 2016 17:20:14 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4NFK8Gi032154;
        Mon, 23 May 2016 17:20:08 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4NFK75p032153;
        Mon, 23 May 2016 17:20:07 +0200
Date:   Mon, 23 May 2016 17:20:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        Joshua Kinard <kumba@gentoo.org>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Subject: Re: THP broken on OCTEON?
Message-ID: <20160523152007.GB28729@linux-mips.org>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53614
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

On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:

> I'm getting kernel crashes (see below) reliably when building Perl in
> parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
> Linux 4.6.
> 
> It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
> issue - disabling it makes build go through fine.
> 
> Any ideas?

I thought it was working except on SGI Origin 200/2000 aka IP27 where
Joshua Kinard (added to cc) was hitting issues as well.

Joshua, does that similar to the issues you were hitting?

  Ralf
