Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 17:03:36 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:45010 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S6816069AbaE2PDeQcDcC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2014 17:03:34 +0200
Received: (qmail 8085 invoked by uid 2102); 29 May 2014 11:03:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 May 2014 11:03:31 -0400
Date:   Thu, 29 May 2014 11:03:31 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Alex Smith <alex.smith@imgtec.com>
cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb host/MIPS: Remove hard-coded OCTEON platform
 information.
In-Reply-To: <1401358203-60225-4-git-send-email-alex.smith@imgtec.com>
Message-ID: <Pine.LNX.4.44L0.1405291100320.1285-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+53961a8c@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, 29 May 2014, Alex Smith wrote:

> From: David Daney <david.daney@cavium.com>
> 
> The device tree will *always* have correct ehci/ohci clock
> configuration, so use it.  This allows us to remove a big chunk of
> platform configuration code from octeon-platform.c.

Instead of doing this, how about moving the octeon2_usb_clocks_start() 
and _stop() routines into octeon-platform.c, and then using the 
ehci-platform and ohci-platform drivers instead of special-purpose 
ehci-octeon and ohci-octeon drivers?

Alan Stern
