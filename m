Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 20:50:34 +0200 (CEST)
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42861 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816676AbaGRSucCfeI7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 20:50:32 +0200
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 447FB8EE1C0;
        Fri, 18 Jul 2014 11:50:24 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9MJpTsRmSTny; Fri, 18 Jul 2014 11:50:24 -0700 (PDT)
Received: from [153.66.254.224] (unknown [50.46.103.107])
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BF2B68EE06D;
        Fri, 18 Jul 2014 11:50:22 -0700 (PDT)
Message-ID: <1405709421.30262.8.camel@dabdike.int.hansenpartnership.com>
Subject: Re: [PATCH 0/25] Replace DEFINE_PCI_DEVICE_TABLE macro use
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg KH <greg@kroah.com>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        Benoit Taine <benoit.taine@lip6.fr>, linux-mips@linux-mips.org,
        linux-fbdev@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ath5k-devel@venema.h4ckr.net, linux-acenic@sunsite.dk,
        linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
        ath10k@lists.infradead.org, linux-hippi@sunsite.dk,
        industrypack-devel@lists.sourceforge.net,
        linux-mmc@vger.kernel.org, MPT-FusionLinux.pdl@avagotech.com,
        virtualization@lists.linux-foundation.org,
        ath9k-devel@venema.h4ckr.net, wil6210@qca.qualcomm.com,
        linux-pcmcia@lists.infradead.org, linux-can@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        platform-driver-x86@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, users@rt2x00.serialmonkey.com,
        e1000-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org,
        devel@linuxdriverproject.org
Date:   Fri, 18 Jul 2014 11:50:21 -0700
In-Reply-To: <20140718181759.GB2193@kroah.com>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
         <20140718162213.GC31114@tuxdriver.com> <20140718164340.GA24960@kroah.com>
         <1405702472.30262.1.camel@dabdike.int.hansenpartnership.com>
         <20140718181759.GB2193@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
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

On Fri, 2014-07-18 at 11:17 -0700, Greg KH wrote:
> On Fri, Jul 18, 2014 at 09:54:32AM -0700, James Bottomley wrote:
> > On Fri, 2014-07-18 at 09:43 -0700, Greg KH wrote:
> > > On Fri, Jul 18, 2014 at 12:22:13PM -0400, John W. Linville wrote:
> > > > On Fri, Jul 18, 2014 at 05:26:47PM +0200, Benoit Taine wrote:
> > > > > We should prefer `const struct pci_device_id` over
> > > > > `DEFINE_PCI_DEVICE_TABLE` to meet kernel coding style guidelines.
> > > > > This issue was reported by checkpatch.
> > > > 
> > > > Honestly, I prefer the macro -- it stands-out more.  Maybe the style
> > > > guidelines and/or checkpatch should change instead?
> > > 
> > > The macro is horrid, no other bus has this type of thing just to save a
> > > few characters in typing
> > 
> > OK, so this is the macro:
> > 
> > #define DEFINE_PCI_DEVICE_TABLE(_table) \
> > 	const struct pci_device_id _table[]
> > 
> > Could you explain what's so horrible?
> > 
> > The reason it's useful today is that people forget the const (and
> > sometimes the [] making it a true table instead of a pointer).  If you
> > use the DEFINE_PCI_DEVICE_TABLE macro, the compile breaks if you use it
> > wrongly (good) and you automatically get the correct annotations.
> 
> We have almost 1000 more uses of the non-macro version than the "macro"
> version in the kernel today:
> $ git grep -w DEFINE_PCI_DEVICE_TABLE | wc -l
> 262
> $ git grep "const struct pci_device_id" | wc -l
> 1254
> 
> My big complaint is that we need to be consistant, either pick one or
> the other and stick to it.  As the macro is the least used, it's easiest
> to fix up, and it also is more consistant with all other kernel
> subsystems which do not have such a macro.

I've a weak preference for consistency, but not at the expense of
hundreds of patches churning the kernel to remove an innocuous macro.
Churn costs time and effort.

> As there is no need for the __init macro mess anymore, there's no real
> need for the DEFINE_PCI_DEVICE_TABLE macro either.  I think checkpatch
> will catch the use of non-const users for the id table already today, it
> catches lots of other uses like this already.
> 
> > > , so why should PCI be "special" in this regard
> > > anymore?
> > 
> > I think the PCI usage dwarfs most other bus types now, so you could turn
> > the question around.  However, I don't think majority voting is a good
> > guide to best practise; lets debate the merits for their own sake.
> 
> Not really "dwarf", USB is close with over 700 such structures:
> $ git grep "const struct usb_device_id" | wc -l
> 725
> 
> And i2c is almost just as big as PCI:
> $ git grep "const struct i2c_device_id" | wc -l
> 1223
> 
> So again, this macro is not consistent with the majority of PCI drivers,
> nor with any other type of "device id" declaration in the kernel, which
> is why I feel it should be removed.
> 
> And finally, the PCI documentation itself says to not use this macro, so
> this isn't a "new" thing.  From Documentation/PCI/pci.txt:
> 
> 	The ID table is an array of struct pci_device_id entries ending with an
> 	all-zero entry.  Definitions with static const are generally preferred.
> 	Use of the deprecated macro DEFINE_PCI_DEVICE_TABLE should be avoided.
> 
> That wording went into the file last December, when we last talked about
> this and everyone in that discussion agreed to remove the macro for the
> above reasons.
> 
> Consistency matters.

In this case, I don't think it does that much ... a cut and paste either
way (from a macro or non-macro based driver) yields correct code.  Since
there's no bug here and no apparent way to misuse the macro, why bother?

Anyway, it's PCI code ... let the PCI maintainer decide.  However, if he
does want this do it as one big bang patch via either the PCI or Trivial
tree (latter because Jiří has experience doing this, but the former
might be useful so the decider feels the pain ...)

James
