Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2010 17:17:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59471 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492660Ab0CQQRs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Mar 2010 17:17:48 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2HGHkGk009086;
        Wed, 17 Mar 2010 17:17:47 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2HGHjWM009084;
        Wed, 17 Mar 2010 17:17:45 +0100
Date:   Wed, 17 Mar 2010 17:17:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 4/4] bcm63xx: fix BCM6338 and BCM6345 gpio count
Message-ID: <20100317161744.GF4554@linux-mips.org>
References: <201003012336.32430.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201003012336.32430.florian@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 01, 2010 at 11:36:32PM +0100, Florian Fainelli wrote:

> The number of GPIOs on BCM6338 is 8, while BCM6345 has only 16 GPIOs
> available.

Thanks, applied.

  Ralf
