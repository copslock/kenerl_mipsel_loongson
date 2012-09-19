Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2012 18:57:48 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35432 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903296Ab2ISQ5l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2012 18:57:41 +0200
Received: by lbbgf7 with SMTP id gf7so1202826lbb.36
        for <linux-mips@linux-mips.org>; Wed, 19 Sep 2012 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=NcZkJLhJEkiZyo9XfUYupBdttT84j2In1pupDVmRMdw=;
        b=TJxBD1qLVax9WdsnmW86fjX0IGjGyeexW5CsJ/MCwAadbHkfkTvcHO+Vho00nue8nU
         6h+5Z+XNGVqE75Lbc5pZLWxX0LdH/taziXW5WTragdMqDU55KA6coULtO+nhfL674M8u
         2iS+p6nNx+vQ25senO33DlUi/smWJxri5hpvgguesXb9ZaBgpeMNd1FItrNDl3ZdyrlZ
         ZlqZfwpq9IB1pyGgQuZ8G4+xXEdHyV/h0WuhRA6W2mqgXLcTGpUGXlegbahO30G/0T+M
         4ZGJ6Uh4qb8RAWX6mHu8vH8WnmFK0lSwj1H9RsPYRnlfDUztCXVTjnqtQKSjtV6Cu45J
         Mh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=NcZkJLhJEkiZyo9XfUYupBdttT84j2In1pupDVmRMdw=;
        b=UAELFLgC/K8dz+trKL6v8A/GF+tR8T6t9N4fysJPcaWDs7h+c3tOYoexUkskXk+ALo
         5CHAYu85z3xvsvbg9AbcrAOV4OdHqCiy5Pto1HJOI+NrpQaIN36cOj+fKzF5LHQCwRC+
         tKjJUc/bb7tbHBRAsB1+RrJDktW150iFUmJg2xPVYi2xfaZUr4VsuSuj45QIsjGqzfAY
         WaHbhdPj7K2KG2PAAOcQ1t4YxhEPWCodfJ5d8BSD7YqZNgD7hxiKdhpMMWltBz2bHRef
         NP+3ZXX7SqD/YeNcE+0/r9B5qOSfFNyQyBTfKd52MkYurZ3m7kRZH+5rrrhRzCVsSZRq
         SoeA==
Received: by 10.112.85.226 with SMTP id k2mr28081lbz.70.1348073855434;
        Wed, 19 Sep 2012 09:57:35 -0700 (PDT)
Received: by 10.112.85.226 with SMTP id k2mr28022lbz.70.1348073855220; Wed, 19
 Sep 2012 09:57:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.132.73 with HTTP; Wed, 19 Sep 2012 09:57:15 -0700 (PDT)
In-Reply-To: <20120917113423.GA28759@kroah.com>
References: <1347880974-13615-1-git-send-email-thierry.reding@avionic-design.de>
 <20120917113423.GA28759@kroah.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 19 Sep 2012 10:57:15 -0600
Message-ID: <CAErSpo4q7KYn3bvNQ0wAXV=+PRAFH_c=MgOLOTDKgaNCjE_aXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Keep pci_fixup_irqs() around after init
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@avionic-design.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
X-Gm-Message-State: ALoCoQl/rysIUhuLKeNJyXCPb2iaGf1ItXAGLI5Q9XItqaoNRDOJkK0tDQiU1B6NaUwFID1BTdIT0jkQ7cpZc2cm5HtAq2D8JB2S8PtCj1/Us9CZwUeqYRWxz4hH9B4/j3FvNUsFDnMz4s5ejiE7cxRA9+iBZwvQ6yX06qy9slGay2GdIKlxUthM6nLCkI0Lv3XxV3oaiXnjEDdWKeg37kkwz4yBwkw9Hg==
X-archive-position: 34531
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

On Mon, Sep 17, 2012 at 5:34 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Sep 17, 2012 at 01:22:53PM +0200, Thierry Reding wrote:
>> Remove the __init annotations in order to keep pci_fixup_irqs() around
>> after init (e.g. for hotplug). This requires the same change for the
>> implementation of pcibios_update_irq() on all architectures. While at
>> it, all __devinit annotations are removed as well, since they will be
>> useless now that HOTPLUG is always on.
>>
>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>> ---
>> Changes in v2:
>> - remove __init and __devinit annotations altogether
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I applied these (both 1/2 and 2/2) to my "next" branch.  Thanks!

Bjorn
