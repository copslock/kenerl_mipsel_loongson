Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jun 2009 16:44:01 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36965 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492844AbZFVOny (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Jun 2009 16:43:54 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5MEeg3v025947;
	Mon, 22 Jun 2009 15:40:42 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5MEegVv025945;
	Mon, 22 Jun 2009 15:40:42 +0100
Date:	Mon, 22 Jun 2009 15:40:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 2/2] octeon: only build flash_setup code when
	CONFIG_MTD is set
Message-ID: <20090622144042.GC25289@linux-mips.org>
References: <200906221116.21621.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200906221116.21621.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 22, 2009 at 11:16:21AM +0200, Florian Fainelli wrote:

> This patch makes the flash_setup code be compiled only when
> CONFIG_MTD is set, it does make sense to register a physmap
> platform driver without the MTD subsystem being enabled.

No.  A user might build the MTD subsystem as a module and then insert it
into a running system so the idea is to always register the devices.  This
also keeps the information in /proc/iomem rsp. /proc/iostat and sysfs
more useful.

  Ralf
