Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2017 02:25:41 +0100 (CET)
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59245 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdBRBZclJmj8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Feb 2017 02:25:32 +0100
Received: from adku1.ipv4.supernova.orange.pl (79.184.254.1) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.81.2)
 id 22c72dce41af6b05; Sat, 18 Feb 2017 02:25:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <code@mmayer.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: cpufreq: add bmips-cpufreq.c
Date:   Sat, 18 Feb 2017 02:20:28 +0100
Message-ID: <2370147.zGx6MqB346@aspire.rjw.lan>
User-Agent: KMail/4.14.10 (Linux/4.10.0-rc3+; KDE/4.14.9; x86_64; ; )
In-Reply-To: <c7a1f607-6619-445a-db35-902f11569dad@gmail.com>
References: <20170217183050.31889-1-code@mmayer.net> <c7a1f607-6619-445a-db35-902f11569dad@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <rjw@rjwysocki.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@rjwysocki.net
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

On Friday, February 17, 2017 11:24:56 AM Florian Fainelli wrote:
> On 02/17/2017 10:30 AM, Markus Mayer wrote:
> > From: Markus Mayer <mmayer@broadcom.com>
> > 
> > Add maintainer information for bmips-cpufreq.c.
> > 
> > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> 
> Looks great, thanks for adding this, one nit below:
> 
> > ---
> > 
> > This is based on PM's linux-next from today (February 17).
> > 
> > This patch could be squashed into patch 3/4 of the original series if that
> > is acceptable (see [1]) or it can remain separate.
> > 
> > [1] https://lkml.org/lkml/2017/2/7/775
> > 
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 107c10e..db251c0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2692,6 +2692,12 @@ F:	drivers/irqchip/irq-brcmstb*
> >  F:	include/linux/bcm963xx_nvram.h
> >  F:	include/linux/bcm963xx_tag.h
> >  
> > +BROADCOM BMIPS CPUFREQ DRIVER
> > +M:	Markus Mayer <mmayer@broadcom.com>
> > +L:	linux-pm@vger.kernel.org
> 
> Please also include bcm-kernel-feedback-list@broadcom.com here
> 
> With that:
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 

Patch applied.

Thanks,
Rafael
