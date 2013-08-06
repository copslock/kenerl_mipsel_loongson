Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Aug 2013 00:32:47 +0200 (CEST)
Received: from hydra.sisk.pl ([212.160.235.94]:34981 "EHLO hydra.sisk.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865173Ab3HFWcp3tsrr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Aug 2013 00:32:45 +0200
Received: from vostro.rjw.lan (aftv187.neoplus.adsl.tpnet.pl [178.42.255.187])
        by hydra.sisk.pl (Postfix) with ESMTPSA id D80DFE3DC1;
        Wed,  7 Aug 2013 00:27:45 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@sisk.pl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        cpufreq@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Julia Lawall <Julia.Lawall@lip6.fr>, stable@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: loongson2: fix broken cpufreq
Date:   Wed, 07 Aug 2013 00:43:02 +0200
Message-ID: <11577373.HKpXOatP90@vostro.rjw.lan>
User-Agent: KMail/4.9.5 (Linux/3.11.0-rc4+; KDE/4.9.5; x86_64; ; )
In-Reply-To: <20130806144012.GB17633@linux-mips.org>
References: <1375727232-17796-1-git-send-email-aaro.koskinen@iki.fi> <20130806144012.GB17633@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Return-Path: <rjw@sisk.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@sisk.pl
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

On Tuesday, August 06, 2013 04:40:12 PM Ralf Baechle wrote:
> On Mon, Aug 05, 2013 at 09:27:12PM +0300, Aaro Koskinen wrote:
> 
> > Commit 42913c799 (MIPS: Loongson2: Use clk API instead of direct
> > dereferences) broke the cpufreq functionality on Loongson2 boards:
> > clk_set_rate() is called before the CPU frequency table is initialized,
> > and therefore will always fail.
> > 
> > Fix by moving the clk_set_rate() after the table initialization.
> > Tested on Lemote FuLoong mini-PC.
> 
> Seems to make sense.
> 
> Rafael or Virish, this should go to Linus for 3.11.  Do you want to funnel
> this through the cpufreq tree or shall I send this to Linus with the
> next batch of MIPS stuff?

I've taken it already.

Thanks,
Rafael
