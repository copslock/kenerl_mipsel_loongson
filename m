Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2013 00:55:33 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:49138 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827335Ab3JOWzbpLQN1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Oct 2013 00:55:31 +0200
Received: by mail-wi0-f177.google.com with SMTP id h11so1583902wiv.4
        for <linux-mips@linux-mips.org>; Tue, 15 Oct 2013 15:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=WkJx9Ll0Qi2FEIGNj5ujbXVFkh0ip38XviQU6VRdzK4=;
        b=Q8e/XPAyHiLWsmU3D+5gHhKhGUzcEctE8d1iPdvNT7DVbAhceB61hFOeogez7E3niO
         Le7GneBdYgARwOW6e2SuJqMBRiOtWCrE/3UxMdK4K1HGRmbpncRNHZn/mLhSQ/yVkkf2
         4pmAX457J0QBOZm/J4pY0RUFU08nR1DQHbkF1NfJzxERnPUs4eJm7yI37smlyOWitTMx
         tstIKV5xmVwEWINL5TiELQ7WgK7u735escqkkoN3zLxIesJLwnMWcHdEe6bvDeYRFY1a
         Hbbepp0tS9ZKSdykmk3yTEi4a2Gu8tKqb1SzSH6YY5X5Z7f0pYNwYXRr98sUsBa283aX
         kZBw==
X-Gm-Message-State: ALoCoQnhFOXajYtPqubYnB/8+vFq5pTjLT0LeMX8OGvB0eZ7syyCoFkoYC+m0ME5ZQsc9aDUNlc2
X-Received: by 10.194.109.68 with SMTP id hq4mr36748862wjb.12.1381877726141;
        Tue, 15 Oct 2013 15:55:26 -0700 (PDT)
Received: from trevor.secretlab.ca (host86-141-177-155.range86-141.btcentralplus.com. [86.141.177.155])
        by mx.google.com with ESMTPSA id s4sm72935wiy.1.2013.10.15.15.55.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 15:55:25 -0700 (PDT)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 2A9C1C40099; Tue, 15 Oct 2013 23:55:23 +0100 (BST)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 01/10] of/irq: Rework of_irq_count()
To:     Rob Herring <robherring2@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <rob.herring@calxeda.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <CAL_JsqLE8aj511oF-gK7Gu5QfmHsQO3+oJ0KFkv0wmuo7i6eiw@mail.gmail.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com> <1379510692-32435-2-git-send-email-treding@nvidia.com> <CAL_JsqLE8aj511oF-gK7Gu5QfmHsQO3+oJ0KFkv0wmuo7i6eiw@mail.gmail.com>
Date:   Tue, 15 Oct 2013 23:55:23 +0100
Message-Id: <20131015225523.2A9C1C40099@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38349
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

On Sun, 22 Sep 2013 16:19:27 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Sep 18, 2013 at 8:24 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > The of_irq_to_resource() helper that is used to implement of_irq_count()
> > tries to resolve interrupts and in fact creates a mapping for resolved
> > interrupts. That's pretty heavy lifting for something that claims to
> > just return the number of interrupts requested by a given device node.
> >
> > Instead, use the more lightweight of_irq_map_one(), which, despite the
> > name, doesn't create an actual mapping. Perhaps a better name would be
> > of_irq_translate_one().
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Applied, thanks.

g.

> 
> > ---
> >  drivers/of/irq.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index 1752988..5f44388 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -368,9 +368,10 @@ EXPORT_SYMBOL_GPL(of_irq_to_resource);
> >   */
> >  int of_irq_count(struct device_node *dev)
> >  {
> > +       struct of_irq irq;
> >         int nr = 0;
> >
> > -       while (of_irq_to_resource(dev, nr, NULL))
> > +       while (of_irq_map_one(dev, nr, &irq) == 0)
> >                 nr++;
> >
> >         return nr;
> > --
> > 1.8.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
