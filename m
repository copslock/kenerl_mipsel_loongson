Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 04:36:18 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:40246 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990407AbeBADgKijmTv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Feb 2018 04:36:10 +0100
Received: from localhost (pool-173-77-163-229.nycmny.fios.verizon.net [173.77.163.229])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 16D681403DF02;
        Wed, 31 Jan 2018 19:36:05 -0800 (PST)
Date:   Wed, 31 Jan 2018 22:36:02 -0500 (EST)
Message-Id: <20180131.223602.362388254047189521.davem@davemloft.net>
To:     jhogan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-mips@linux-mips.org,
        paul.burton@mips.com, ralf@linux-mips.org,
        clabbe.montjoie@gmail.com, sparclinux@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] sparc,leon: Select USB_UHCI_BIG_ENDIAN_{MMIO,DESC}
From:   David Miller <davem@davemloft.net>
In-Reply-To: <fb8ebffece031b246324cef5ad3afd75cf3795dd.1517437177.git-series.jhogan@kernel.org>
References: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
        <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
        <fb8ebffece031b246324cef5ad3afd75cf3795dd.1517437177.git-series.jhogan@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 31 Jan 2018 19:36:05 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62388
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

From: James Hogan <jhogan@kernel.org>
Date: Wed, 31 Jan 2018 22:24:46 +0000

> Now that USB_UHCI_BIG_ENDIAN_MMIO and USB_UHCI_BIG_ENDIAN_DESC are moved
> outside of the USB_SUPPORT conditional, simply select them from
> SPARC_LEON rather than by the symbol's defaults in drivers/usb/Kconfig,
> similar to how it is done for USB_EHCI_BIG_ENDIAN_MMIO and
> USB_EHCI_BIG_ENDIAN_DESC.
> 
> Signed-off-by: James Hogan <jhogan@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
