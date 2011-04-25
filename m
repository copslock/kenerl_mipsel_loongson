Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Apr 2011 12:51:28 +0200 (CEST)
Received: from [12.203.210.36] ([12.203.210.36]:2179 "EHLO
        orion5.netlogicmicro.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1490954Ab1DYKvT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Apr 2011 12:51:19 +0200
X-TM-IMSS-Message-ID: <f25364300001a04a@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id f25364300001a04a ; Mon, 25 Apr 2011 03:50:58 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 25 Apr 2011 03:52:14 -0700
Date:   Mon, 25 Apr 2011 16:21:05 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 7/8] USB support for XLS platforms.
Message-ID: <20110425105105.GA14277@jayachandranc.netlogicmicro.com>
References: <cover.1303487516.git.jayachandranc@netlogicmicro.com>
 <21ae06c6f50f7a770b62d61265e6f509f37d1762.1303487516.git.jayachandranc@netlogicmicro.com>
 <BANLkTi=cUHpCQAi9LUjPXfDZL=a2XnfqDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BANLkTi=cUHpCQAi9LUjPXfDZL=a2XnfqDA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 25 Apr 2011 10:52:14.0767 (UTC) FILETIME=[D66FCBF0:01CC0336]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

On Fri, Apr 22, 2011 at 07:03:23PM +0200, Manuel Lauss wrote:
> On Fri, Apr 22, 2011 at 7:02 PM, Jayachandran C
> <jayachandranc@netlogicmicro.com> wrote:
> > update ehci-hcd.c and ohci-hcd.c to add XLS hcds
> > add ehci/ohci devices to XLR/XLS platform driver
> > Kconfig update
> >
> > Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
> > ---
> >  arch/mips/Kconfig                        |    2 +
> >  arch/mips/include/asm/netlogic/xlr/xlr.h |   12 ++
> >  arch/mips/netlogic/xlr/platform.c        |   91 ++++++++++++++++
> >  drivers/usb/host/ehci-hcd.c              |    5 +
> >  drivers/usb/host/ehci-xls.c              |  170 ++++++++++++++++++++++++++++++
> >  drivers/usb/host/ohci-hcd.c              |    5 +
> >  drivers/usb/host/ohci-xls.c              |  160 ++++++++++++++++++++++++++++
> >  7 files changed, 445 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/usb/host/ehci-xls.c
> >  create mode 100644 drivers/usb/host/ohci-xls.c
> > diff --git a/drivers/usb/host/ehci-xls.c b/drivers/usb/host/ehci-xls.c
> > new file mode 100644
> > index 0000000..54467c6
> > --- /dev/null
> > +++ b/drivers/usb/host/ehci-xls.c
> > @@ -0,0 +1,170 @@
> > +/*
> > + * OHCI HCD (Host Controller Driver) for USB.
> > + *
> > + * (C) Copyright 2011 Netlogic Microsystems Inc.
> > + * (C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>
> > + * (C) Copyright 2000-2002 David Brownell <dbrownell@users.sourceforge.net>
> > + * (C) Copyright 2002 Hewlett-Packard Company
> > + *
> > + * Bus Glue for AMD Alchemy Au1xxx
> > + * Written by Christopher Hoover <ch@hpl.hp.com>
> > + * Based on fragments of previous driver by Rusell King et al.
> > + *
> > + * Modified for LH7A404 from ohci-sa1111.c
> > + *  by Durgesh Pattamatta <pattamattad@sharpsec.com>
> > + * Modified for AMD Alchemy Au1xxx
> > + *  by Matt Porter <mporter@kernel.crashing.org>
> > + *
> > + * This file is licenced under the GPL.
> > + */
> 
> Please correct the comments!  I also think that most of the people
> which are attributed
> here should be removed.  Perhaps simply state which file you used for
> inspiration?
> ("derived from ohci-whatever.c").

I will post a new version of the PCI and USB support patches, with this
and another minor change.

Thanks,
JC.
