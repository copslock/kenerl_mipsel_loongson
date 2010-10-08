Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Oct 2010 00:13:50 +0200 (CEST)
Received: from cantor.suse.de ([195.135.220.2]:39984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491201Ab0JHWNq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 9 Oct 2010 00:13:46 +0200
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTP id E94FA74609;
        Sat,  9 Oct 2010 00:13:45 +0200 (CEST)
Date:   Fri, 8 Oct 2010 15:00:13 -0700
From:   Greg KH <gregkh@suse.de>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org, dbrownell@users.sourceforge.net
Subject: Re: [PATCH 0/3] usb: Add OCTEON II USB support.
Message-ID: <20101008220013.GA14533@suse.de>
References: <1286574473-23098-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286574473-23098-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Fri, Oct 08, 2010 at 02:47:50PM -0700, David Daney wrote:
> The OCTEON II (CN63XX) is a new member of Cavium Networks' family of
> mips64 based SOCs.  These parts have an integrated EHCI/OHCI USB host
> controller.  As implied in the subject, this patch set adds the
> necessary glue code to connect this hardware to the standard EHCI and
> OHCI drivers.
> 
> There are two sets of prerequisite patches that are pending that
> should be merged via Ralf's linux-mips.org tree.  If these are OK, it
> might make sense to either merge via Ralf's tree, or coordinate with
> him as to maintain the dependencies between the various patches.

No objection from me to take this through Ralf's tree, feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to these patches.

thanks,

greg k-h
