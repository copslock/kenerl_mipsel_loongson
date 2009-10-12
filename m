Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 00:50:53 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41910 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493556AbZJLWuu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Oct 2009 00:50:50 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9CMq4HI014223;
	Tue, 13 Oct 2009 00:52:05 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9CMq24o014221;
	Tue, 13 Oct 2009 00:52:02 +0200
Date:	Tue, 13 Oct 2009 00:52:02 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg KH <gregkh@suse.de>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Staging: octeon-ethernet: Assign proper MAC addresses.
Message-ID: <20091012225202.GA14140@linux-mips.org>
References: <1255374272-32757-1-git-send-email-ddaney@caviumnetworks.com> <20091012190407.GA24524@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091012190407.GA24524@suse.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 12, 2009 at 12:04:09PM -0700, Greg KH wrote:

> 
> On Mon, Oct 12, 2009 at 12:04:32PM -0700, David Daney wrote:
> > Allocate MAC addresses using the same method as the bootloader.  This
> > avoids changing the MAC between bootloader and kernel operation as
> > well as avoiding duplicates and use of addresses outside of the
> > assigned range.
> > 
> > Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> > ---
> > 
> > This could merge via Ralf's tree as Octeon is MIPS based and all the
> > rest of the Octeon patches seem to be going in this way.
> 
> Fine with me.

Thanks, applied.

  Ralf
