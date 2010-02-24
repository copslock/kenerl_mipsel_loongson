Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 18:42:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45185 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492461Ab0BXRme (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 18:42:34 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1OHfTvd029911;
        Wed, 24 Feb 2010 18:41:30 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1OHfRng029909;
        Wed, 24 Feb 2010 18:41:27 +0100
Date:   Wed, 24 Feb 2010 18:41:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc:     Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Reverting old hack
Message-ID: <20100224174127.GA29565@linux-mips.org>
References: <20100220113134.GA27194@linux-mips.org>
 <20100224090333.44a16d0a.yuasa@linux-mips.org>
 <20100224164100.GD5130@linux-mips.org>
 <201002240959.56706.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201002240959.56706.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 24, 2010 at 09:59:56AM -0700, Bjorn Helgaas wrote:

> > There is another somewhat theoretical correctness issue.  Because the
> > VIA SuperIO chip only decodes 24 bits of address space but port address
> > space currently being configured as 32MB there is the theoretical
> > possibility of I/O port addresses that alias with legacy addresses getting
> > allocated.
> 
> Does this mean my comment:
> 
> +        * but the VT82C586 IDE controller does respond at 0x100001f0 because
> +        * it only decodes the low 16 bits of the address.
> 
> should say "24 bits" instead of "16 bits"?

Yes, afair.

  Ralf
