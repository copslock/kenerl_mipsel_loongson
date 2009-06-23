Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jun 2009 23:29:42 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:60659 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493112AbZFWV3g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jun 2009 23:29:36 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5NLQ1wh009508;
	Tue, 23 Jun 2009 22:26:02 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5NLQ0Tq009506;
	Tue, 23 Jun 2009 22:26:00 +0100
Date:	Tue, 23 Jun 2009 22:25:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, gregkh@suse.de
Subject: Re: [PATCH] Staging: octeon-ethernet: Convert to use
	net_device_ops.
Message-ID: <20090623212559.GA9358@linux-mips.org>
References: <1245782048-24058-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1245782048-24058-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 23, 2009 at 11:34:08AM -0700, David Daney wrote:

> Convert the driver to use net_device_ops as it is now mandatory.
> 
> Also compensate for the removal of struct sk_buff's dst field.
> 
> The changes are mostly mechanical, the content of ethernet-common.c
> was moved to ethernet.c and ethernet-common.{c,h} are removed.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
> 
> Although it is a staging driver, we may want to merge it via Ralf's
> tree as Octeon is a MIPS SOC.

Yes, this way it'll receive most testing.

Greg, I assume you're ok with me merging this patch to Linus so I've
commited it into the linux-mips.org repository.

  Ralf
