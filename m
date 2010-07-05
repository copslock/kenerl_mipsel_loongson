Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 14:56:02 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38121 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492100Ab0GEMz7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jul 2010 14:55:59 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o65CtrbE031228;
        Mon, 5 Jul 2010 13:55:54 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o65Ctj5C030974;
        Mon, 5 Jul 2010 13:55:46 +0100
Date:   Mon, 5 Jul 2010 13:55:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kulikov Vasiliy <segooon@gmail.com>
Cc:     Kernel Janitors <kernel-janitors@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jpirko@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Patrick McHardy <kaber@trash.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-mips@linux-mips.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioc3-eth: Use the instance of net_device_stats from
 net_device.
Message-ID: <20100705125544.GA28849@linux-mips.org>
References: <1278332034-17122-1-git-send-email-segooon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1278332034-17122-1-git-send-email-segooon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 05, 2010 at 04:13:51PM +0400, Kulikov Vasiliy wrote:

> Since net_device has an instance of net_device_stats,
> we can remove the instance of this from the adapter structure.
> 
> Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>

NACK, your patch doesn't compile.  I'll post a fixed patch in a separate
mail.

  Ralf
