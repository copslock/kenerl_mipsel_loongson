Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 21:11:59 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:60902 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493333AbZJLTLw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Oct 2009 21:11:52 +0200
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	by mx2.suse.de (Postfix) with ESMTP id 055D379727;
	Mon, 12 Oct 2009 21:11:52 +0200 (CEST)
Date:	Mon, 12 Oct 2009 12:04:09 -0700
From:	Greg KH <gregkh@suse.de>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Staging: octeon-ethernet: Assign proper MAC addresses.
Message-ID: <20091012190407.GA24524@suse.de>
References: <1255374272-32757-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255374272-32757-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Mon, Oct 12, 2009 at 12:04:32PM -0700, David Daney wrote:
> Allocate MAC addresses using the same method as the bootloader.  This
> avoids changing the MAC between bootloader and kernel operation as
> well as avoiding duplicates and use of addresses outside of the
> assigned range.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
> 
> This could merge via Ralf's tree as Octeon is MIPS based and all the
> rest of the Octeon patches seem to be going in this way.

Fine with me.

thanks,

greg k-h
