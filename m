Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2014 06:18:20 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:33128 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859939AbaGUESRpSXDm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Jul 2014 06:18:17 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0B8455818A7;
        Sun, 20 Jul 2014 21:18:14 -0700 (PDT)
Date:   Sun, 20 Jul 2014 21:18:13 -0700 (PDT)
Message-Id: <20140720.211813.942862864883062133.davem@davemloft.net>
To:     benoit.taine@lip6.fr
Cc:     linux-pci@vger.kernel.org, ath5k-devel@venema.h4ckr.net,
        ath9k-devel@venema.h4ckr.net, linux-hippi@sunsite.dk,
        dri-devel@lists.freedesktop.org, linux-acenic@sunsite.dk,
        wil6210@qca.qualcomm.com, platform-driver-x86@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, users@rt2x00.serialmonkey.com,
        linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        industrypack-devel@lists.sourceforge.net,
        linux-can@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-fbdev@vger.kernel.org, ath10k@lists.infradead.org,
        linux-crypto@vger.kernel.org, MPT-FusionLinux.pdl@avagotech.com,
        devel@linuxdriverproject.org, xen-devel@lists.xenproject.org,
        linux-pcmcia@lists.infradead.org, e1000-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/25] Replace DEFINE_PCI_DEVICE_TABLE macro use
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.7 (shards.monkeyblade.net [149.20.54.216]); Sun, 20 Jul 2014 21:18:15 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Benoit Taine <benoit.taine@lip6.fr>
Date: Fri, 18 Jul 2014 17:26:47 +0200

> We should prefer `const struct pci_device_id` over
> `DEFINE_PCI_DEVICE_TABLE` to meet kernel coding style guidelines.
> This issue was reported by checkpatch.
> 
> A simplified version of the semantic patch that makes this change is as
> follows (http://coccinelle.lip6.fr/):
> 
> // <smpl>
> 
> @@
> identifier i;
> declarer name DEFINE_PCI_DEVICE_TABLE;
> initializer z;
> @@
> 
> - DEFINE_PCI_DEVICE_TABLE(i)
> + const struct pci_device_id i[]
> = z;
> 
> // </smpl>
> 
> I have 103 patches ready, and will only send a few for you to judge if
> it is useful enough, and to prevent from spamming too much.

I'm fine with this wrt. the networking changes, but I don't think this should
be merged via my tree.
