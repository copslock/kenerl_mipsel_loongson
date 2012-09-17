Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2012 13:34:41 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:40831 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903258Ab2IQLef (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Sep 2012 13:34:35 +0200
Received: by dajq27 with SMTP id q27so2899847daj.36
        for <linux-mips@linux-mips.org>; Mon, 17 Sep 2012 04:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=Jb90C30WpfPy43Af+wGr+Cqydq32MkjWJVv+/wuHIV8=;
        b=DLwVMFcaccX5kf+4/CL95yySE/zTb2YpYJcqIWfj8HqzYqwjCD8yafF9WKGfZpF3hL
         bXCOywzsGj2HzZsFHS1/JXIU/N2oUu678PmYmBcR/lC1YmzyNh2liwR3YrtyTtprWRJN
         CM3WZLbOQ2tkkPHcoVZZgBX0RapI4146Z552K/4LrApEdZ8169uti17FbDbC3f3SvSmO
         1xEXNw0XUDrFOnzKlUPID49LYxHhlQBHF9CktCszbiE9+g5hWGkEHe/aiJMoESivL4qI
         Bt98bbLWl4S7JBAi9fHuPhtH62uULPzlRCukEjiqNKbc8WQuG9aUIl4kLyuNSFc1oR37
         hBaw==
Received: by 10.66.88.198 with SMTP id bi6mr19927640pab.23.1347881668748;
        Mon, 17 Sep 2012 04:34:28 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id gf3sm6785549pbc.74.2012.09.17.04.34.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 04:34:26 -0700 (PDT)
Date:   Mon, 17 Sep 2012 04:34:23 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v2 1/2] PCI: Keep pci_fixup_irqs() around after init
Message-ID: <20120917113423.GA28759@kroah.com>
References: <1347880974-13615-1-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1347880974-13615-1-git-send-email-thierry.reding@avionic-design.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnmW780MY8DYW7Z84Wqv+puoeJN2wlxalQCfm3Cn/gaacjE7xQH4A4FKHA8IXZfkS3xR3vE
X-archive-position: 34522
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

On Mon, Sep 17, 2012 at 01:22:53PM +0200, Thierry Reding wrote:
> Remove the __init annotations in order to keep pci_fixup_irqs() around
> after init (e.g. for hotplug). This requires the same change for the
> implementation of pcibios_update_irq() on all architectures. While at
> it, all __devinit annotations are removed as well, since they will be
> useless now that HOTPLUG is always on.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Changes in v2:
> - remove __init and __devinit annotations altogether

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
