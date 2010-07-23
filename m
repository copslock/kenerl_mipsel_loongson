Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2010 06:24:38 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53759 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492503Ab0GWEYe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Jul 2010 06:24:34 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o6N4OXRX032761;
        Fri, 23 Jul 2010 05:24:33 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o6N4OXvM032760;
        Fri, 23 Jul 2010 05:24:33 +0100
Date:   Fri, 23 Jul 2010 05:24:32 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] BCM63XX: prevent second enet registration on BCM6338
Message-ID: <20100723042432.GA28551@linux-mips.org>
References: <201007212259.28442.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201007212259.28442.florian@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 21, 2010 at 10:59:26PM +0200, Florian Fainelli wrote:

> This SoC has only one Ethernet MAC, so prevent registration of a second one.

Thanks, applied.

  Ralf
