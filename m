Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2010 14:54:05 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49891 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493547Ab0A0NyA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2010 14:54:00 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0RDs8Sv001325;
        Wed, 27 Jan 2010 14:54:08 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0RDs6S8001321;
        Wed, 27 Jan 2010 14:54:06 +0100
Date:   Wed, 27 Jan 2010 14:54:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, Wim Van Sebroeck <wim@iguana.be>,
        netdev@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/4] ar7: implement clock API
Message-ID: <20100127135405.GB18247@linux-mips.org>
References: <201001032117.07022.florian@openwrt.org>
 <201001121015.27867.florian@openwrt.org>
 <201001270910.06224.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201001270910.06224.florian@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17519

On Wed, Jan 27, 2010 at 09:10:06AM +0100, Florian Fainelli wrote:

> This patch makes the ar7 clock code implement the
> Linux clk API. Drivers using the various clocks
> available in the SoC are updated accordingly.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> Acked-by: Wim Van Sebroeck <wim@iguana.be>

Thanks; queued for 2.6.34.

  Ralf
