Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 15:37:29 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:23430 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8134007AbWFGOhW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2006 15:37:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k57EbMF5031686;
	Wed, 7 Jun 2006 15:37:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k57EbLGQ031685;
	Wed, 7 Jun 2006 15:37:21 +0100
Date:	Wed, 7 Jun 2006 15:37:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Brownell <david-b@pacbell.net>
Cc:	linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
	linux-mips@linux-mips.org
Subject: Re: [linux-usb-devel] [PATCH] Fix OHCI HCD build for PNX 8550
Message-ID: <20060607143721.GA31497@linux-mips.org>
References: <20060607135922.GA26754@linux-mips.org> <200606070727.57618.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606070727.57618.david-b@pacbell.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 07, 2006 at 07:27:56AM -0700, David Brownell wrote:

> On Wednesday 07 June 2006 6:59 am, Ralf Baechle wrote:
> > The PNX8550 OHCI is a platform device so we better include the necessary
> > headers.
> 
> PNX ohci support has not been submitted upstream yet... just merge this
> with that patch before submitting.

Whops.  Well, I discovered alot more breakage that this one so I'll
abstain and leave the fixing to others that actually have hardware ...

  Ralf
