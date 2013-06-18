Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 16:42:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46594 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824769Ab3FROmzpngFM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 16:42:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5IEgsig019644;
        Tue, 18 Jun 2013 16:42:54 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5IEgr49019643;
        Tue, 18 Jun 2013 16:42:53 +0200
Date:   Tue, 18 Jun 2013 16:42:53 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Chris Dearman <chris.dearman@imgtec.com>
Subject: Re: [PATCH] mips: fix execution hazard during watchpoint register
 probe
Message-ID: <20130618144253.GA19573@linux-mips.org>
References: <1371314080-48198-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371314080-48198-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36975
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

On Sat, Jun 15, 2013 at 05:34:40PM +0100, Paul Burton wrote:

> Writing a value to a WatchLo* register creates an execution hazard, so
> if its value is then read before that hazard is cleared then said value
> may be invalid. The mips_probe_watch_registers function must therefore
> clear the execution hazard between setting the match bits in a WatchLo*
> register & reading the register back in order to check which are set.
> 
> This fixes intermittent incorrect watchpoint register probing on some
> MIPS cores such as interAptiv & proAptiv.

Obviously correct.  Did somebody once have a tool to test for this kind
of back-to-back cp0 issues?

  Ralf
