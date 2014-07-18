Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 18:44:08 +0200 (CEST)
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33113 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861343AbaGRQoG3mwcq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 18:44:06 +0200
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B5CDC217ED;
        Fri, 18 Jul 2014 12:44:04 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 18 Jul 2014 12:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=VndMWQbMNay9+gzbqaOB/k6Vs+8=; b=JpPc22a27uRI/nEY6huoRksngBWy
        MCTA5DyyLryBLd3l7FZA2k0JnPMTx8GoHPxVLkGrJOVnCTSq+oSX5lDtzcZCd3uI
        xt4v+BIlwfe7i257OjuCgVPFC+8ugwOZNgWnhCICsSSCsgD+pwUuHjmNA5m8jEcX
        jukIdEOyS+KiD3c=
X-Sasl-enc: K0ewJdu6/GdZugJhfMaVsREYxgf/5MPe1vpqc2hPjrdS 1405701844
Received: from localhost (unknown [76.28.255.20])
        by mail.messagingengine.com (Postfix) with ESMTPA id E47A1680164;
        Fri, 18 Jul 2014 12:44:03 -0400 (EDT)
Date:   Fri, 18 Jul 2014 09:43:40 -0700
From:   Greg KH <greg@kroah.com>
To:     "John W. Linville" <linville@tuxdriver.com>
Cc:     Benoit Taine <benoit.taine@lip6.fr>, linux-mips@linux-mips.org,
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
Subject: Re: [PATCH 0/25] Replace DEFINE_PCI_DEVICE_TABLE macro use
Message-ID: <20140718164340.GA24960@kroah.com>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
 <20140718162213.GC31114@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140718162213.GC31114@tuxdriver.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41322
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

On Fri, Jul 18, 2014 at 12:22:13PM -0400, John W. Linville wrote:
> On Fri, Jul 18, 2014 at 05:26:47PM +0200, Benoit Taine wrote:
> > We should prefer `const struct pci_device_id` over
> > `DEFINE_PCI_DEVICE_TABLE` to meet kernel coding style guidelines.
> > This issue was reported by checkpatch.
> 
> Honestly, I prefer the macro -- it stands-out more.  Maybe the style
> guidelines and/or checkpatch should change instead?

The macro is horrid, no other bus has this type of thing just to save a
few characters in typing, so why should PCI be "special" in this regard
anymore?

thanks,

greg k-h
