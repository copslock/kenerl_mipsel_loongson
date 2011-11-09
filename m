Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 18:17:35 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42313 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904265Ab1KIRR2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 18:17:28 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9HHHR8001353;
        Wed, 9 Nov 2011 17:17:17 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9HHEED001346;
        Wed, 9 Nov 2011 17:17:14 GMT
Date:   Wed, 9 Nov 2011 17:17:14 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, netdev@vger.kernel.org, gregkh@suse.de,
        devel@driverdev.osuosl.org, ddaney.cavm@gmail.com
Subject: Re: [PATCH] staging: octeon-ethernet: Fix compile error caused by
 changed to struct skb_frag_struct.
Message-ID: <20111109171714.GA31771@linux-mips.org>
References: <1320698970-1854-1-git-send-email-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320698970-1854-1-git-send-email-david.daney@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7901

On Mon, Nov 07, 2011 at 12:49:30PM -0800, David Daney wrote:

> Evidently the definition of struct skb_frag_struct has changed, so we
> need to change to match it.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---

As usual for this drive I've applied this to the MIPS tree and will
send it to Linus in a few days unless somebody objects.

Thanks,

  Ralf
