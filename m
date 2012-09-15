Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Sep 2012 00:24:04 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:60846 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903402Ab2IOWX7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Sep 2012 00:23:59 +0200
Received: by lbbgf7 with SMTP id gf7so3441653lbb.36
        for <linux-mips@linux-mips.org>; Sat, 15 Sep 2012 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=+x9faSjHzvy5gI7XXn/+Hp3u80GFlk6pZyOTpUMa1Fw=;
        b=fAv7jg8WyuhcZQN33zmYFyA2eoP6tZCh72JRjWAiNmHMI5Qewe55BC6v0HySdgbWgW
         AvyqmZhb/ll2JQm+cVTTqzvfKd2NavmwP25eyK6Rp5BpebFfAPUHAkIZgqF4vYh1u2WD
         bvg19nr/9uI16wknCpCMtjJZBwSGMhmzjc+fNe98aay48PCYlMrC+uXcRqkwzQKYJ3D/
         Puk7GQl8JSlmMQyDH0qdLA2rrhDYDhU6NSVOQ3bceH+KJiht/lr23ub5GQVKNY2ZNh3W
         gtidxVaNskgh98ZT6AsJ256O9naVtRd7VhWUfqqfnN5xsIkKp2by/VdW9ZplU03lDxNE
         OapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=+x9faSjHzvy5gI7XXn/+Hp3u80GFlk6pZyOTpUMa1Fw=;
        b=BT7+U3d8+NCC3sYShxbCNHuAfB0jyUgK6l9rUhCXukgOEs75xW+pX4DjYZJDXekxIV
         fFHyMMw686rAL4ekv+KnzvL4kfJR0TJiy3t9N7QpXrIH7p08G02n2wmpn0Mhg+cKEXW7
         J9IKxS028DXFP5kvaW8fCjUMoOrMdCb1HgDGtuOw/iEpbCgMIfn18CwzrU+PqzvFKxZT
         Yv0/MzpUuQ4mH0x1pGPeI+Ym1ZnWSQ4X1X6AglI0uEVWF47Kc5HeW9WzSeGj7rUl6iAg
         FffExh/jCJ+3dxmDWfyusQJbBHTnQ7BBLbe/fscaxgVujP0L3CmlVptYzYt3n7JydhF0
         FQug==
Received: by 10.112.26.106 with SMTP id k10mr2521823lbg.100.1347747833588;
        Sat, 15 Sep 2012 15:23:53 -0700 (PDT)
Received: by 10.112.26.106 with SMTP id k10mr2521780lbg.100.1347747833420;
 Sat, 15 Sep 2012 15:23:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.132.73 with HTTP; Sat, 15 Sep 2012 15:23:33 -0700 (PDT)
In-Reply-To: <20120915075301.GA31044@avionic-0098.mockup.avionic-design.de>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <1347655456-2542-2-git-send-email-thierry.reding@avionic-design.de>
 <CAMuHMdWuR_tdMw9iVkaQ3D9p1HVU_L05ap=MzBuo1jLD6YdHHw@mail.gmail.com> <20120915075301.GA31044@avionic-0098.mockup.avionic-design.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Sat, 15 Sep 2012 16:23:33 -0600
Message-ID: <CAErSpo6WaFv=CXtiWeDDvThjZRBRJKfJMgovuMjjZRpQGK-WJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Provide a default pcibios_update_irq()
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Greg Ungerer <gerg@uclinux.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQkj7OFNqjL/srkpisa8dn4WkNfvdBwlIJmfuFB+QgdHM4p43bD15UY2EalD/lNxNY3d4SGgLCThLX1F4RP2G8uUCSdthW6u3jBebXPymsyZ9tfupweiGB6kyw//mKntoOS7HAn2bT1e7G4poFB0l8qQcJIT81eUhlFyx5OL7v7GSp4N7y5UZlMzxrFIbxgnqOiZwJ/M6XZnSTCTBbTU4P2+Eq7UKw==
X-archive-position: 34513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Sat, Sep 15, 2012 at 1:53 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Sat, Sep 15, 2012 at 09:32:10AM +0200, Geert Uytterhoeven wrote:
>> On Fri, Sep 14, 2012 at 10:44 PM, Thierry Reding
>> <thierry.reding@avionic-design.de> wrote:
>> > --- a/drivers/pci/setup-irq.c
>> > +++ b/drivers/pci/setup-irq.c
>> > @@ -17,6 +17,14 @@
>> >  #include <linux/ioport.h>
>> >  #include <linux/cache.h>
>> >
>> > +void __devinit __weak pcibios_update_irq(struct pci_dev *dev, int irq)
>> > +{
>> > +#ifdef CONFIG_PCI_DEBUG
>> > +       printk(KERN_DEBUG "PCI: Assigning IRQ %02d to %s\n", irq,
>> > +              pci_name(dev));
>>
>> pr_debug()?
>> Or even better, dev_dbg()?
>
> The problem with pr_debug() and dev_dbg() is that they will be compiled
> out if DEBUG is not defined. Perhaps we should pass -DDEBUG if PCI_DEBUG
> is configured and make this dev_dbg()?

Sorry, fat-fingered the previous empty response.

We already have this in drivers/pci/Makefile:

    ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG

so dev_dbg() should be perfect.
