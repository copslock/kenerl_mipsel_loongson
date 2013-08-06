Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Aug 2013 16:40:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53656 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6865259Ab3HFOkWJH-RO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Aug 2013 16:40:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r76EeIE2012116;
        Tue, 6 Aug 2013 16:40:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r76EeCmA012107;
        Tue, 6 Aug 2013 16:40:12 +0200
Date:   Tue, 6 Aug 2013 16:40:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "Rafael J. Wysocki" <rjw@sisk.pl>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        cpufreq@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Julia Lawall <Julia.Lawall@lip6.fr>, stable@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: loongson2: fix broken cpufreq
Message-ID: <20130806144012.GB17633@linux-mips.org>
References: <1375727232-17796-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1375727232-17796-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37436
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

On Mon, Aug 05, 2013 at 09:27:12PM +0300, Aaro Koskinen wrote:

> Commit 42913c799 (MIPS: Loongson2: Use clk API instead of direct
> dereferences) broke the cpufreq functionality on Loongson2 boards:
> clk_set_rate() is called before the CPU frequency table is initialized,
> and therefore will always fail.
> 
> Fix by moving the clk_set_rate() after the table initialization.
> Tested on Lemote FuLoong mini-PC.

Seems to make sense.

Rafael or Virish, this should go to Linus for 3.11.  Do you want to funnel
this through the cpufreq tree or shall I send this to Linus with the
next batch of MIPS stuff?

  Ralf
