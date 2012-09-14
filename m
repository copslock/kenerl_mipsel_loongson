Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2012 00:35:47 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:54742 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903400Ab2INWfn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2012 00:35:43 +0200
Received: by dajq27 with SMTP id q27so1422327daj.36
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2012 15:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=QQPqKVcFXiZQc9S7EC9X4a9KvEqgrapKZDAnkrz3wmg=;
        b=O9fCQhWUrtYZDEoE44sk0kprzB4HWoGHZ51K5R/WGJzprxT7TDlHfaJCfhejLjLqQd
         5HIwcILkPLp5CcDqgX61LpXHqz64S/u6NC8PjT3D34z11Mfd3jUJ8zkrIslC939xVGDr
         uuCoULiRfa+Yhq6jwAawYnDSgzUSshQTPIDek92TSa12zNLxwxku73qlYtjQinYS/7oF
         9oAyo8Z9WguGdZQ+ej/j2wO8NNZJ/IFq39hQCCpNjtgSeuCUZBF2NIHI1ibDG+tMLp/n
         7uZ2dfwnUmZru1yAHHz70CBibFEIiqB5Sau5JnczQOjmmBEnsEg89wZchEt9X4aBxpRT
         GHiA==
Received: by 10.68.242.164 with SMTP id wr4mr7073308pbc.41.1347662136386;
        Fri, 14 Sep 2012 15:35:36 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id ho7sm1707972pbc.3.2012.09.14.15.35.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 15:35:35 -0700 (PDT)
Date:   Fri, 14 Sep 2012 15:35:31 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
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
Subject: Re: [PATCH 1/2] PCI: Annotate pci_fixup_irqs with __devinit
Message-ID: <20120914223531.GA8771@kroah.com>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo6BqPUEpMmh2+FuEi-mHFK0U1XCmdCpJfo6V2XcNxzMNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAErSpo6BqPUEpMmh2+FuEi-mHFK0U1XCmdCpJfo6V2XcNxzMNg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQmrqfD/EuigwgrftzoBa6Tumut7fZw8UJMz8rhk+URe2mpxU3wNyfBlSboNZ8ZVHUxzr7wz
X-archive-position: 34508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Fri, Sep 14, 2012 at 02:53:11PM -0600, Bjorn Helgaas wrote:
> +cc Greg KH
> 
> On Fri, Sep 14, 2012 at 2:44 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > In order to keep pci_fixup_irqs() around after init (e.g. for hotplug),
> > mark it __devinit instead of __init. This requires the same change for
> > the implementation of the pcibios_update_irq() function on all
> > architectures.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Note: Ideally these annotations should go away completely in order to
> > be independent of the HOTPLUG symbol. However, there is work underway
> > to get rid of HOTPLUG altogether, so I've kept the __devinit for now.

No, just take away the __init marking completly.  For 3.7,
CONFIG_HOTPLUG will always be enabled, making it be the same thing.
That way this saves me the time and energy from deleting the __devinit
markings when I get to that point in the patch series :)

thanks,

greg k-h
