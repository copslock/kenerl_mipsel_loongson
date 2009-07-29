Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2009 23:46:16 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50563 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493726AbZG2VqJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Jul 2009 23:46:09 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6TLkZCl008416;
	Wed, 29 Jul 2009 22:46:35 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6TLkXvP008414;
	Wed, 29 Jul 2009 22:46:33 +0100
Date:	Wed, 29 Jul 2009 22:46:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] ar7: fix build failures when CONFIG_SERIAL_8250 is
	not enabled
Message-ID: <20090729214633.GB9440@linux-mips.org>
References: <200907211237.39264.florian@openwrt.org> <20090721150811.GA18826@linux-mips.org> <200907241324.15613.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200907241324.15613.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 24, 2009 at 01:24:15PM +0200, Florian Fainelli wrote:

> > This patch rejects.
> 
> The one I sent previously applies to -queue, the one below applies to -master. Thanks !

Well, you want 2.6.30 to work, no?

Applied.  Thanks!

  Ralf
