Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 10:06:17 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49628 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021867AbZFBJGK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jun 2009 10:06:10 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5295kwa003923;
	Tue, 2 Jun 2009 10:05:46 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5295jZ7003921;
	Tue, 2 Jun 2009 10:05:45 +0100
Date:	Tue, 2 Jun 2009 10:05:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 04/10] bcm63xx: register a fallback SPROM require for
	b43 to work
Message-ID: <20090602090545.GA3527@linux-mips.org>
References: <200905312028.02939.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200905312028.02939.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 31, 2009 at 08:28:02PM +0200, Florian Fainelli wrote:

> In order to get b43 working, we have to register a SPROM
> which provides sane values to calibrate the radio, provide
> GPIO settings and country code. The SSB bus is initialized
> when the PCI bus is registered and expects to find the
> SPROM at init time. Thus we have to move our device
> registration from device_initcall to arch_initcall. The rationale
> behind this comes from Broadcom not providing on-chip
> EEPROM to store such settings, but relying on the main
> system Flash to provide them by software means.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Also folded into the series.

  Ralf
