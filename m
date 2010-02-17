Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2010 05:59:27 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:59179 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491187Ab0BQE7X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Feb 2010 05:59:23 +0100
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by mx2.suse.de (Postfix) with ESMTP id B8CDA4844E;
        Wed, 17 Feb 2010 05:59:22 +0100 (CET)
Date:   Tue, 16 Feb 2010 20:58:44 -0800
From:   Greg KH <gregkh@suse.de>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/2] Staging: Clean up octeon Ethernet some.
Message-ID: <20100217045844.GB18306@suse.de>
References: <4B7B4540.1010700@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B7B4540.1010700@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Tue, Feb 16, 2010 at 05:24:16PM -0800, David Daney wrote:
> These two patches clean up some comments and get rid of the code that
> creates a non-standard file in /proc
> 
> As with the previous octeon_ethernet patches, these can probably go
> via Ralf's linux-mips.org tree.

Going through Ralf's tree is fine for me.

thanks,

greg k-h
