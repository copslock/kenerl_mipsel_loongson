Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2010 22:41:50 +0100 (CET)
Received: from cantor.suse.de ([195.135.220.2]:47900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492236Ab0BOVlq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Feb 2010 22:41:46 +0100
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTP id 5920D6CB00;
        Mon, 15 Feb 2010 22:41:46 +0100 (CET)
Date:   Mon, 15 Feb 2010 13:05:58 -0800
From:   Greg KH <gregkh@suse.de>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ralf.baechle@gmail.com, linux-mips <linux-mips@linux-mips.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/4] Improvements to octeon_ethernet.
Message-ID: <20100215210558.GA27325@suse.de>
References: <4B79AAA6.60005@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B79AAA6.60005@caviumnetworks.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Mon, Feb 15, 2010 at 12:12:22PM -0800, David Daney wrote:
> Here are a couple of improvements to the octeon_ethernet in
> drivers/staging/octeon.  The first patch is just cleanup, the rest are
> genuine bug fixes.
>
> I will reply with the four patches.
>
> We may want to merge via Ralf's linux-mips.org tree as Octeon is
> infact a MIPS based SOC and he has a bunch of other patches queued
> there that these depend on.

That's fine with me for them to go through that way.

thanks,

greg k-h
