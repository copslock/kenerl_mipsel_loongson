Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 23:27:06 +0200 (CEST)
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52914 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861350AbaGRV1EDv6oN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 23:27:04 +0200
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6282A219C3;
        Fri, 18 Jul 2014 17:27:02 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 18 Jul 2014 17:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=j9ynxPzGR5gN+IlqvOUYC2tL03g=; b=TS+UDmBe4V2fRiMLXDJrrDdPvJE7
        23BFtQxA2mJodSGunmNP4x3BUb89H1/ytaQlQ3Zb2XBPs1lwc9NvafPRP3VCwhUZ
        dGBSkqx56NHB9j31yvF6kHDjtWOTNL9qfFkeqLal6zWOkWkrpboSxX8gGiljgxR2
        nwTe6xtMpeiWh4M=
X-Sasl-enc: ayRscQAAsYh6LPllSr6uqXXwZuiYz+/+VllXWeLiVAAH 1405718822
Received: from localhost (unknown [24.22.230.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA8DC68011D;
        Fri, 18 Jul 2014 17:27:01 -0400 (EDT)
Date:   Fri, 18 Jul 2014 14:27:00 -0700
From:   Greg KH <greg@kroah.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Benoit Taine <benoit.taine@lip6.fr>, linux-mips@linux-mips.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath5k-devel@venema.h4ckr.net, linux-acenic@sunsite.dk,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-rdma@vger.kernel.org, ath10k@lists.infradead.org,
        linux-hippi@sunsite.dk, industrypack-devel@lists.sourceforge.net,
        linux-mmc@vger.kernel.org, MPT-FusionLinux.pdl@avagotech.com,
        virtualization@lists.linux-foundation.org,
        ath9k-devel@venema.h4ckr.net, wil6210@qca.qualcomm.com,
        linux-pcmcia@lists.infradead.org, linux-can@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        platform-driver-x86@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        Linux Wireless List <linux-wireless@vger.kernel.org>,
        users@rt2x00.serialmonkey.com, e1000-devel@lists.sourceforge.net,
        linux-crypto@vger.kernel.org, devel@linuxdriverproject.org
Subject: Re: [PATCH 0/25] Replace DEFINE_PCI_DEVICE_TABLE macro use
Message-ID: <20140718212700.GA12121@kroah.com>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
 <20140718162213.GC31114@tuxdriver.com>
 <20140718164340.GA24960@kroah.com>
 <1405702472.30262.1.camel@dabdike.int.hansenpartnership.com>
 <20140718181759.GB2193@kroah.com>
 <CAPM=9tzgWdnv7jc+xjsJUf0EcyGU+V7nFHzzQ16ui1eE0ihyQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzgWdnv7jc+xjsJUf0EcyGU+V7nFHzzQ16ui1eE0ihyQA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Sat, Jul 19, 2014 at 07:14:12AM +1000, Dave Airlie wrote:
> >
> > We have almost 1000 more uses of the non-macro version than the "macro"
> > version in the kernel today:
> > $ git grep -w DEFINE_PCI_DEVICE_TABLE | wc -l
> > 262
> > $ git grep "const struct pci_device_id" | wc -l
> > 1254
> 
> did you check for non-const ones? just to see if we have any of the
> broken case in the tree :-)

I didn't :)

> as for consistency, pci_dev vs usb_device :-P

Read farther down the email...
