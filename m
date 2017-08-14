Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 15:14:06 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:39885 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993929AbdHNNNz7DVY1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 15:13:55 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id AC46A209E9; Mon, 14 Aug 2017 15:13:48 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 8086F209D8;
        Mon, 14 Aug 2017 15:13:48 +0200 (CEST)
Date:   Mon, 14 Aug 2017 15:13:48 +0200
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <James.Hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v3 2/8] MIPS: ranchu: Add Goldfish RTC driver
Message-ID: <20170814131348.ztdea5kzgiflzlgk@piout.net>
References: <1500656111-9520-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1500656111-9520-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <20170810203430.zgtxvi7uaqmg4dzr@piout.net>
 <232DDC0A2B605E4F9E85F6904417885F015D937238@BADAG02.ba.imgtec.org>
 <EF5FA6C3467F85449672C3E735957B85015D9CC3E1@BADAG02.ba.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EF5FA6C3467F85449672C3E735957B85015D9CC3E1@BADAG02.ba.imgtec.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

On 14/08/2017 at 12:45:55 +0000, Aleksandar Markovic wrote:
> Hello, Alexandre,
> 
> In addition, if you, and everybody else, don't object, I plan to change the title of this patch form:
> 
> "MIPS: ranchu: Add Goldfish RTC driver"
> 
> to
> 
> "rtc: Add Goldfish RTC driver",
> 
> to be more consistent with all commit messages for this kernel source directory.
> 

Yes please, I would have changed it anyway.

> Regards,
> Aleksandar
> 
> ________________________________________
> From: Miodrag Dinic
> Sent: Friday, August 11, 2017 9:46 AM
> To: Alexandre Belloni; Aleksandar Markovic
> Cc: linux-mips@linux-mips.org; Goran Ferenc; Aleksandar Markovic; Alessandro Zummo; Bo Hu; David S. Miller; Douglas Leung; Greg Kroah-Hartman; James Hogan; Jin Qian; linux-kernel@vger.kernel.org; linux-rtc@vger.kernel.org; Mauro Carvalho Chehab; Paul Burton; Petar Jovanovic; Raghu Gandham
> Subject: RE: [PATCH v3 2/8] MIPS: ranchu: Add Goldfish RTC driver
> 
> Hi Alexandre,
> 
> we have this sorted & plan to submit version 4 of this series next week.
> 
> Thank you.
> 
> Kind regards,
> Miodrag
> ________________________________________
> From: Alexandre Belloni [alexandre.belloni@free-electrons.com]
> Sent: Thursday, August 10, 2017 10:34 PM
> To: Aleksandar Markovic
> Cc: linux-mips@linux-mips.org; Miodrag Dinic; Goran Ferenc; Aleksandar Markovic; Alessandro Zummo; Bo Hu; David S. Miller; Douglas Leung; Greg Kroah-Hartman; James Hogan; Jin Qian; linux-kernel@vger.kernel.org; linux-rtc@vger.kernel.org; Mauro Carvalho Chehab; Paul Burton; Petar Jovanovic; Raghu Gandham
> Subject: Re: [PATCH v3 2/8] MIPS: ranchu: Add Goldfish RTC driver
> 
> Hi,
> 
> On 21/07/2017 at 18:53:31 +0200, Aleksandar Markovic wrote:
> > From: Miodrag Dinic <miodrag.dinic@imgtec.com>
> >
> > Add device driver for a virtual Goldfish RTC clock.
> >
> > The driver can be built only if CONFIG_MIPS and CONFIG_GOLDFISH are
> > set. The compatible string used by OS for binding the driver is
> > defined as "google,goldfish-rtc".
> >
> > Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> > Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> > ---
> >  MAINTAINERS                |   1 +
> >  drivers/rtc/Kconfig        |   8 ++
> >  drivers/rtc/Makefile       |   1 +
> >  drivers/rtc/rtc-goldfish.c | 233 +++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 243 insertions(+)
> >  create mode 100644 drivers/rtc/rtc-goldfish.c
> >
> 
> Do you mind fixing the remaining checkpatch --strict issues, the two
> kbuild errors and the warning reported by Julia?
> 
> Thanks!
> 
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
