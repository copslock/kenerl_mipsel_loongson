Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 13:22:42 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:35949 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870561Ab2JDLW0PjptQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 13:22:26 +0200
Received: by mail-ee0-f49.google.com with SMTP id c1so300143eek.36
        for <multiple recipients>; Thu, 04 Oct 2012 04:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=I13ichDw/Xl9kARXMJMZDELVNxwwdaSO7+2AP/MhrPI=;
        b=x0SBddbV6/y5v2weLJT72/i6A9Kb0NJ+vebaRU6V0ZxofX0X+TB3L7Di/2gHNNQn1G
         T3DELtaR0pXIyDd/qgggyN2MQpHDzCTlV8LVE/pqFCS/om7eUscSpq0p29AuFlXyTpTf
         CRdqV/pIS8LellGYOBKFx89doYMlfC9PZALHNaPU+B5vY1PBr5rq5mssDJtS5TQJbzXy
         dxzWzbIZTeSmj/CR5UZPfPVggbP162PNw8qYN+jOoelL8BrN6E1wgnTl9HeRonXHOazw
         MvX5ojuOgVpPWYEjR5ae/3i19734Ijlxu3rcwKiSnOXkrlMrsxj+VnZUZUTFufiET2/w
         IDVg==
Received: by 10.14.202.71 with SMTP id c47mr3430989eeo.42.1349280810362;
        Wed, 03 Oct 2012 09:13:30 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id i1sm10500703eeo.8.2012.10.03.09.13.27
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Oct 2012 09:13:29 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/25] USB: ehci: allow need_io_watchdog to be passed to ehci-platform driver
Date:   Wed, 03 Oct 2012 18:12:29 +0200
Message-ID: <16671283.xyEuvTui2M@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.5 (Linux/3.2.0-24-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <Pine.LNX.4.44L0.1210031154400.1441-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1210031154400.1441-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wednesday 03 October 2012 12:01:22 Alan Stern wrote:
> On Wed, 3 Oct 2012, Florian Fainelli wrote:
> 
> > And convert all the existing users of ehci-platform to specify a correct
> > need_io_watchdog value.
> 
> IMO (and I realize that not everybody agrees), the patch description 
> should not be considered an extension of the patch title, as though the 
> title were the first sentence and the description the remainder of the 
> same paragraph.  Descriptions should stand on their own and be 
> comprehensible even to somebody who hasn't read the title.
> 
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> >  arch/mips/ath79/dev-usb.c             |    2 ++
> >  arch/mips/loongson1/common/platform.c |    1 +
> >  arch/mips/netlogic/xlr/platform.c     |    1 +
> >  drivers/usb/host/bcma-hcd.c           |    1 +
> >  drivers/usb/host/ehci-platform.c      |    1 +
> >  drivers/usb/host/ssb-hcd.c            |    1 +
> >  include/linux/usb/ehci_pdriver.h      |    3 +++
> >  7 files changed, 10 insertions(+)
> 
> More importantly...  Nearly every driver will have need_io_watchdog
> set.  Only a few of them explicitly turn it off.  The approach you're 
> using puts an extra burden on most of the drivers.
> 
> > diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-
platform.c
> > index 764e010..08d5dec 100644
> > --- a/drivers/usb/host/ehci-platform.c
> > +++ b/drivers/usb/host/ehci-platform.c
> > @@ -32,6 +32,7 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
> >  	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
> >  	ehci->big_endian_desc = pdata->big_endian_desc;
> >  	ehci->big_endian_mmio = pdata->big_endian_mmio;
> > +	ehci->need_io_watchdog = pdata->need_io_watchdog;
> 
> > --- a/include/linux/usb/ehci_pdriver.h
> > +++ b/include/linux/usb/ehci_pdriver.h
> > @@ -29,6 +29,8 @@
> >   *			initialization.
> >   * @port_power_off:	set to 1 if the controller needs to be powered down
> >   *			after initialization.
> > + * @need_io_watchdog:	set to 1 if the controller needs the I/O 
watchdog to
> > + *			run.
> 
> Instead, how about adding a no_io_watchdog flag?  Then after 
> ehci-platform.c calls ehci_setup(), it can see whether to turn off 
> ehci->need_io_watchdog.

Sounds good, you are right,  this also greatly reduces the chances to miss one 
user of this "feature".

> 
> This way, most of this patch would become unnecessary.
> 
> Alan Stern
> 
