Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2013 01:01:51 +0200 (CEST)
Received: from mail-we0-f176.google.com ([74.125.82.176]:36062 "EHLO
        mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827303Ab3JOXBsrFVfB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Oct 2013 01:01:48 +0200
Received: by mail-we0-f176.google.com with SMTP id w62so9160099wes.35
        for <linux-mips@linux-mips.org>; Tue, 15 Oct 2013 16:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=sG/FoKzM2bS53EXaJBf+TXnQWWCuBY3g7spN/JZHdds=;
        b=jjWxy6Z9DW3Ao/oMyfsJlLaKaOnPItDxdODvNHY4IrrpwhytDAJ6eeOulGrSMBMrUN
         z7vV+tH2ACffXsdRAeschrIqgnsV1EeuRGChZCAPo8FI4hR3An6+eE7yh/Bq0i6V/gVi
         gbyPBJ3lPdsUuKaM7Gaep+PlGkCWn5ZaIerdp8tdkLt1BAqOP+i8aY56t+bMUMQMlq+X
         /dPUkR1fJnXQkJdZzvrCZrDSgSH0by046umqSoIrcolBMXSo+X29rl/L0K+VG3m9csIR
         /Nip//ZGPMMTSfx0QN6JeagKuQxzbZTVfdUnJwFtz4OKGCp0Rp6so9s80qTLJ3Y378Me
         cMRw==
X-Gm-Message-State: ALoCoQnK1WVBiWP3S83Y1k9BgFkyyuUDqXvzZarmI5ch2qjpoKnC1a8Ut2Qdr2rg6fMs70rcvBaB
X-Received: by 10.194.78.78 with SMTP id z14mr36450304wjw.32.1381878103436;
        Tue, 15 Oct 2013 16:01:43 -0700 (PDT)
Received: from trevor.secretlab.ca (host86-141-177-155.range86-141.btcentralplus.com. [86.141.177.155])
        by mx.google.com with ESMTPSA id b13sm71943wic.9.2013.10.15.16.01.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 16:01:42 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id E9FBFC40099; Wed, 16 Oct 2013 00:01:39 +0100 (BST)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 04/10] irqdomain: Return errors from irq_create_of_mapping()
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robherring2@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Rob Herring <rob.herring@calxeda.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20130923081337.GB11881@ulmo>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com> <1379510692-32435-5-git-send-email-treding@nvidia.com> <CAL_JsqLQeAQD460f8Lk9eDE2dCzLusC1mXZ-_uaKVFLfhJNryg@mail.gmail.com> <20130923081337.GB11881@ulmo>
Date:   Wed, 16 Oct 2013 00:01:39 +0100
Message-Id: <20131015230139.E9FBFC40099@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Mon, 23 Sep 2013 10:13:38 +0200, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Sun, Sep 22, 2013 at 04:14:43PM -0500, Rob Herring wrote:
> > On Wed, Sep 18, 2013 at 8:24 AM, Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > > Instead of returning 0 for all errors, allow the precise error code to
> > > be propagated. This will be used in subsequent patches to allow further
> > > propagation of error codes.
> > >
> > > The interrupt number corresponding to the new mapping is returned in an
> > > output parameter so that the return value is reserved to signal success
> > > (== 0) or failure (< 0).
> > >
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > 
> > One comment below, otherwise:
> > 
> > Acked-by: Rob Herring <rob.herring@calxeda.com>
> > 
> > > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > > index 905a24b..ae71b14 100644
> > > --- a/arch/powerpc/kernel/pci-common.c
> > > +++ b/arch/powerpc/kernel/pci-common.c
> > > @@ -230,6 +230,7 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
> > >  {
> > >         struct of_irq oirq;
> > >         unsigned int virq;
> > > +       int ret;
> > >
> > >         pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
> > >
> > > @@ -266,8 +267,10 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
> > >                          oirq.size, oirq.specifier[0], oirq.specifier[1],
> > >                          of_node_full_name(oirq.controller));
> > >
> > > -               virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
> > > -                                            oirq.size);
> > > +               ret = irq_create_of_mapping(oirq.controller, oirq.specifier,
> > > +                                           oirq.size, &virq);
> > > +               if (ret)
> > > +                       virq = NO_IRQ;
> > >         }
> > >         if(virq == NO_IRQ) {
> > >                 pr_debug(" Failed to map !\n");
> > 
> > Can you get rid of NO_IRQ usage here instead of adding to it.
> 
> I was trying to stay consistent with the remainder of the code. PowerPC
> is a pretty heavy user of NO_IRQ. Of all 348 references, more than half
> (182) are in arch/powerpc, so I'd rather like to get a go-ahead from
> Benjamin on this.
> 
> That said, perhaps we should just go all the way and get rid of NO_IRQ
> for good. Things could get somewhat messy, though. There are a couple of
> these spread through the code:
> 
> 	#ifndef NO_IRQ
> 	#define NO_IRQ (-1)
> 	#endif

And all of them are wrong and need to be removed.  :-)  We're /slowly/
getting rid of the -1 and the usage of NO_IRQ. A global search and
replace of s/NO_IRQ/0/g can be very safely done on arch/powerpc since
powerpc has had NO_IRQ set correctly to '0' for a very long time now.

So, yes, if you're keen to do it I'd love to see a series getting rid of
more NO_IRQ users.

g.
