Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 01:01:42 +0100 (WEST)
Received: from kroah.org ([198.145.64.141]:46785 "EHLO coco.kroah.org"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20021561AbZFDABg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Jun 2009 01:01:36 +0100
Received: from localhost (c-76-105-230-205.hsd1.or.comcast.net [76.105.230.205])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by coco.kroah.org (Postfix) with ESMTPSA id D2D8448FA4;
	Wed,  3 Jun 2009 17:01:13 -0700 (PDT)
Date:	Wed, 3 Jun 2009 16:54:28 -0700
From:	Greg KH <greg@kroah.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	gregkh@suse.de, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/7] Staging: Octeon-ethernet driver.
Message-ID: <20090603235428.GB19375@kroah.com>
References: <4A00DA84.5040101@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A00DA84.5040101@caviumnetworks.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
Precedence: bulk
X-list: linux-mips

On Tue, May 05, 2009 at 05:32:04PM -0700, David Daney wrote:
> This patch set introduces the octeon-ethernet driver into the
> drivers/staging tree.  The Octeon is a mips64r2 base multi-core SOC
> family.
> 
> The first five patches are small tweaks to the existing octeon support
> that are required by the ethernet driver.  I would expect them to be
> merged via Ralf's linux-mips.org tree.
> 
> The last two are the driver, and would probably be merged via the
> drivers/staging tree.  However since they depend on the first five,
> they probably shouldn't be merged until those five are merged.

Ok, as Ralf doesn't seem to have responded to my previous query, I'll
just merge the last driver, and mark it CONFIG_BROKEN which you can turn
off when the infrastructure portions go in.

Sound reasonable?

thanks,

greg k-h
