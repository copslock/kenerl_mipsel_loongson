Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 18:29:13 +0200 (CEST)
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42202 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861343AbaGRQ3L6vcRS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 18:29:11 +0200
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B7A508EE1C0;
        Fri, 18 Jul 2014 09:29:03 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fy2sg0992VSy; Fri, 18 Jul 2014 09:29:03 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.46.103.107])
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 05DAD8EE06D;
        Fri, 18 Jul 2014 09:29:01 -0700 (PDT)
Message-ID: <1405700934.605.31.camel@jarvis.lan>
Subject: Re: [PATCH 0/25] Replace DEFINE_PCI_DEVICE_TABLE macro use
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Benoit Taine <benoit.taine@lip6.fr>
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
Date:   Fri, 18 Jul 2014 09:28:54 -0700
In-Reply-To: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41319
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

On Fri, 2014-07-18 at 17:26 +0200, Benoit Taine wrote:
> We should prefer `const struct pci_device_id` over
> `DEFINE_PCI_DEVICE_TABLE` to meet kernel coding style guidelines.
> This issue was reported by checkpatch.

What kernel coding style?  checkpatch isn't the arbiter of style, if
that's the only problem.

The DEFINE_PCI macro was a well reasoned addition when it was added in
2008.  The problem was most people were getting the definition wrong.
When we converted away from CONFIG_HOTPLUG, having this DEFINE_ meant
that only one place needed changing instead of hundreds for PCI tables.

The reason people were getting the PCI table wrong was mostly the init
section specifiers which are now gone, but it has enough underlying
utility (mostly constification) that I don't think we'd want to churn
the kernel hugely to make a change to struct pci_table and then have to
start detecting and fixing misuses.

James
