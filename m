Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2009 07:12:47 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:8369 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28640899AbZDVGJ5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Apr 2009 07:09:57 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3M69r6d013667;
	Wed, 22 Apr 2009 08:09:53 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3M69pc7013664;
	Wed, 22 Apr 2009 08:09:51 +0200
Date:	Wed, 22 Apr 2009 08:09:51 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Philippe Vachon <philippe@cowpig.ca>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Clean up Lemote Loongson 2E Support
Message-ID: <20090422060951.GA12850@linux-mips.org>
References: <20090422055809.GA1821@cowpig.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090422055809.GA1821@cowpig.ca>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 22, 2009 at 01:58:09AM -0400, Philippe Vachon wrote:

> +static inline void ls2e_writeb(uint8_t value, phys_addr_t addr)
> +{
> +	*(volatile uint8_t *)addr = value;

So is addr a physical addres or a virtual one?  In the first case you
can't dereference it, in the latter the type is wrong.

  Ralf
