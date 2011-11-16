Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 20:15:09 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45127 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903858Ab1KPTNF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 20:13:05 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAGJD4bo014496;
        Wed, 16 Nov 2011 19:13:04 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAGJD2sq014493;
        Wed, 16 Nov 2011 19:13:02 GMT
Date:   Wed, 16 Nov 2011 19:13:02 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 09/13] USB: ehci-ath79: add device_id entry for the
 AR933X SoCs
Message-ID: <20111116191302.GI8932@linux-mips.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
 <1308597973-6037-10-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1308597973-6037-10-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13745

On Mon, Jun 20, 2011 at 09:26:09PM +0200, Gabor Juhos wrote:

> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
> The patch should be merged via the MIPS tree.
> ---
>  drivers/usb/host/Kconfig      |    2 +-
>  drivers/usb/host/ehci-ath79.c |    4 ++++
>  2 files changed, 5 insertions(+), 1 deletions(-)

No (N)Ack or comments received and the patch is trivial, so queued for 3.3


Thanks,

  Ralf
