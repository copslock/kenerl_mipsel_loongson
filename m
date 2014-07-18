Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 23:14:20 +0200 (CEST)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:54879 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859949AbaGRVOSFb5ue (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 23:14:18 +0200
Received: by mail-lb0-f178.google.com with SMTP id c11so2432149lbj.9
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T7v1Rc4IWRyVfhLIKpyJbDdKPVq4lIJlJPy+6M+wtJw=;
        b=aDZ7b5h3L57JnAfp8MI1xS8w7b2+oMY4P4qoFqKD7xf/b59SPm6rGQni0PFEnl8CxC
         +lzHtLMIz3DGX8JXG5+TWfcMQ3hvYcUgFSfo8sJ3a9UgtiSiPxApZKGU1UHplFuwl4s+
         KyE240cmaW2JWBPZQs4yTUcdXJVVMPD27psuPMpG/noopORcHfLmHKCPHAB9oIULb4SV
         duQJO1Tf13T03zxtuY+G2ZtggmIL3tXujE1mqNHoygaX7Xqh40d5fWuKtqUZ+1zgRrep
         whe/WSjspm8ild5B9ZFNDQ7izBxGj8UEFYKGvnVI5HBjevcAz2Dd2FURaMlsx69vbPpt
         KMBA==
MIME-Version: 1.0
X-Received: by 10.152.203.134 with SMTP id kq6mr5397949lac.62.1405718052198;
 Fri, 18 Jul 2014 14:14:12 -0700 (PDT)
Received: by 10.112.52.193 with HTTP; Fri, 18 Jul 2014 14:14:12 -0700 (PDT)
In-Reply-To: <20140718181759.GB2193@kroah.com>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
        <20140718162213.GC31114@tuxdriver.com>
        <20140718164340.GA24960@kroah.com>
        <1405702472.30262.1.camel@dabdike.int.hansenpartnership.com>
        <20140718181759.GB2193@kroah.com>
Date:   Sat, 19 Jul 2014 07:14:12 +1000
Message-ID: <CAPM=9tzgWdnv7jc+xjsJUf0EcyGU+V7nFHzzQ16ui1eE0ihyQA@mail.gmail.com>
Subject: Re: [PATCH 0/25] Replace DEFINE_PCI_DEVICE_TABLE macro use
From:   Dave Airlie <airlied@gmail.com>
To:     Greg KH <greg@kroah.com>
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
Content-Type: text/plain; charset=UTF-8
Return-Path: <airlied@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: airlied@gmail.com
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

>
> We have almost 1000 more uses of the non-macro version than the "macro"
> version in the kernel today:
> $ git grep -w DEFINE_PCI_DEVICE_TABLE | wc -l
> 262
> $ git grep "const struct pci_device_id" | wc -l
> 1254

did you check for non-const ones? just to see if we have any of the
broken case in the tree :-)

as for consistency, pci_dev vs usb_device :-P

Dave.
