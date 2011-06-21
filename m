Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 20:46:39 +0200 (CEST)
Received: from charlotte.tuxdriver.com ([70.61.120.58]:41576 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491167Ab1FUSqc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jun 2011 20:46:32 +0200
Received: from uucp by smtp.tuxdriver.com with local-rmail (Exim 4.63)
        (envelope-from <linville@tuxdriver.com>)
        id 1QZ5y1-0006Lb-Jz; Tue, 21 Jun 2011 14:46:29 -0400
Received: from linville-8530p.local (linville-8530p.local [127.0.0.1])
        by linville-8530p.local (8.14.4/8.14.4) with ESMTP id p5LIc23l005901;
        Tue, 21 Jun 2011 14:38:03 -0400
Received: (from linville@localhost)
        by linville-8530p.local (8.14.4/8.14.4/Submit) id p5LIc1Aw005900;
        Tue, 21 Jun 2011 14:38:01 -0400
Date:   Tue, 21 Jun 2011 14:38:00 -0400
From:   "John W. Linville" <linville@tuxdriver.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     mb@bu3sch.de, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ssb: add __devinit to some functions
Message-ID: <20110621183800.GB2273@tuxdriver.com>
References: <20110621150227.GB14197@linux-mips.org>
 <1308680889-4217-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1308680889-4217-1-git-send-email-hauke@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linville@tuxdriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17454

On Tue, Jun 21, 2011 at 08:28:09PM +0200, Hauke Mehrtens wrote:
> Two functions in ssb are using register_pci_controller() which is
> __devinit. The functions ssb_pcicore_init_hostmode() and
> ssb_gige_probe() should also be __devinit.
> 
> This fixes the following warning:
> WARNING: vmlinux.o(.text+0x2727b8): Section mismatch in reference from the function ssb_pcicore_init_hostmode() to the function .devinit.text:register_pci_controller()
> The function ssb_pcicore_init_hostmode() references
> the function __devinit register_pci_controller().
> This is often because ssb_pcicore_init_hostmode lacks a __devinit
> annotation or the annotation of register_pci_controller is wrong.
> 
> WARNING: vmlinux.o(.text+0x273398): Section mismatch in reference from the function ssb_gige_probe() to the function .devinit.text:register_pci_controller()
> The function ssb_gige_probe() references
> the function __devinit register_pci_controller().
> This is often because ssb_gige_probe lacks a __devinit
> annotation or the annotation of register_pci_controller is wrong.
> 
> Reported-by: Ralf Baechle <ralf@linux-mips.org>

Signed-off-by??

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
