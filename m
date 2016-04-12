Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 14:32:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54810 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026406AbcDLMcjdIR4C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Apr 2016 14:32:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u3CCWaoZ017744;
        Tue, 12 Apr 2016 14:32:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u3CCWWWa017743;
        Tue, 12 Apr 2016 14:32:32 +0200
Date:   Tue, 12 Apr 2016 14:32:32 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>, linux-pm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V1 1/5] cpufreq: Loongson1: Rename the file to
 loongson1-cpufreq.c
Message-ID: <20160412123232.GA17598@linux-mips.org>
References: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
 <20160412104319.GA17650@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160412104319.GA17650@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52965
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

On Tue, Apr 12, 2016 at 04:13:19PM +0530, Viresh Kumar wrote:

> On 12-04-16, 18:40, Keguang Zhang wrote:
> > From: Kelvin Cheung <keguang.zhang@gmail.com>
> > 
> > This patch renames the file to loongson1-cpufreq.c,
> > and also includes some minor updates.
> > 
> > Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> > 
> > ---
> > V1:
> >    Merge the minor updates into this patch.
> > ---
> >  drivers/cpufreq/Makefile                                |  2 +-
> >  drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} | 10 +++++-----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >  rename drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} (96%)
> 
> For the entire series.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!  Whole series queued for 4.7.

  Ralf
