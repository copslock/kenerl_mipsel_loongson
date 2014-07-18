Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 17:27:30 +0200 (CEST)
Received: from isis.lip6.fr ([132.227.60.2]:55064 "EHLO isis.lip6.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859949AbaGRP1YrmCgu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Jul 2014 17:27:24 +0200
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.14.7/lip6) with ESMTP id s6IFQ6Wt007448
          ; Fri, 18 Jul 2014 17:26:06 +0200 (CEST)
X-pt:   isis.lip6.fr
Received: from localhost.localdomain (AMontsouris-651-1-237-186.w86-212.abo.wanadoo.fr [86.212.100.186])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by systeme.lip6.fr (Postfix) with ESMTPSA id 9BB6E630E;
        Fri, 18 Jul 2014 17:26:05 +0200 (CEST)
From:   Benoit Taine <benoit.taine@lip6.fr>
To:     linux-pci@vger.kernel.org
Cc:     benoit.taine@lip6.fr, ath5k-devel@venema.h4ckr.net,
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
Subject: [PATCH 0/25] Replace DEFINE_PCI_DEVICE_TABLE macro use
Date:   Fri, 18 Jul 2014 17:26:47 +0200
Message-Id: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
X-Mailer: git-send-email 2.0.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 18 Jul 2014 17:26:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.74 on 132.227.60.2
Return-Path: <benoit.taine@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benoit.taine@lip6.fr
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

We should prefer `const struct pci_device_id` over
`DEFINE_PCI_DEVICE_TABLE` to meet kernel coding style guidelines.
This issue was reported by checkpatch.

A simplified version of the semantic patch that makes this change is as
follows (http://coccinelle.lip6.fr/):

// <smpl>

@@
identifier i;
declarer name DEFINE_PCI_DEVICE_TABLE;
initializer z;
@@

- DEFINE_PCI_DEVICE_TABLE(i)
+ const struct pci_device_id i[]
= z;

// </smpl>

I have 103 patches ready, and will only send a few for you to judge if
it is useful enough, and to prevent from spamming too much.

Thanks.
