Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2012 21:42:30 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:46578 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1903701Ab2DKTm0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Apr 2012 21:42:26 +0200
Received: (qmail 3490 invoked by uid 2102); 11 Apr 2012 15:42:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Apr 2012 15:42:24 -0400
Date:   Wed, 11 Apr 2012 15:42:24 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Steven J. Hill" <sjhill@mips.com>
cc:     linux-mips@linux-mips.org, <ralf@linux-mips.org>,
        <linux-usb@vger.kernel.org>, Chris Dearman <chris@mips.com>
Subject: Re: [PATCH v2 10/10] usb: host: mips: sead3: USB Host controller
 support for SEAD-3 platform.
In-Reply-To: <1334167196-30093-1-git-send-email-sjhill@mips.com>
Message-ID: <Pine.LNX.4.44L0.1204111540420.1351-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 32933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 11 Apr 2012, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Add EHCI driver for MIPS SEAD-3 development platform.
> 
> Signed-off-by: Chris Dearman <chris@mips.com>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

This is better, although I would have preferred you to use 
ehci_setup().

Acked-by: Alan Stern <stern@rowland.harvard.edu>
