Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jul 2014 10:47:03 +0200 (CEST)
Received: from smtp-out-128.synserver.de ([212.40.185.128]:1160 "EHLO
        smtp-out-125.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6859932AbaGFIrA6i1Ov (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Jul 2014 10:47:00 +0200
Received: (qmail 10347 invoked by uid 0); 6 Jul 2014 08:47:00 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 10131
Received: from ppp-46-244-166-46.dynamic.mnet-online.de (HELO ?192.168.178.23?) [46.244.166.46]
  by 217.119.54.96 with AES128-SHA encrypted SMTP; 6 Jul 2014 08:46:59 -0000
Message-ID: <53B90CF6.1000103@metafoo.de>
Date:   Sun, 06 Jul 2014 10:46:46 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.6.0
MIME-Version: 1.0
To:     Apelete Seketeli <apelete@seketeli.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Vinod Koul <vinod.koul@intel.com>, linux-mips@linux-mips.org
CC:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mips: jz4740: rename usb_nop_xceiv to usb_phy_generic
References: <1404588615-14722-1-git-send-email-apelete@seketeli.net> <1404588615-14722-2-git-send-email-apelete@seketeli.net>
In-Reply-To: <1404588615-14722-2-git-send-email-apelete@seketeli.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 07/05/2014 09:30 PM, Apelete Seketeli wrote:
> Rename usb_nop_xceiv to usb_phy_generic in platform data to match the
> name change of the nop transceiver driver in commit 4525bee (usb: phy:
> rename usb_nop_xceiv to usb_phy_generic).
>
> The name change induced a kernel panic due to an unhandled kernel
> unaligned access while trying to dereference musb->xceiv->io_ops in
> musb_init_controller().
>
> Signed-off-by: Apelete Seketeli <apelete@seketeli.net>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Ralf, the commit that caused this regression is in v3.16-rc1, can you queue 
this fix for v3.16-rcX?

Thanks,
- Lars
