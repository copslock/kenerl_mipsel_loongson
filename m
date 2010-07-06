Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2010 03:31:13 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53946 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491199Ab0GFBbJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jul 2010 03:31:09 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o661V6nu019982;
        Tue, 6 Jul 2010 02:31:06 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o661V6kJ019980;
        Tue, 6 Jul 2010 02:31:06 +0100
Date:   Tue, 6 Jul 2010 02:31:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Configuration changes to go along with simplified
 command line manipulation
Message-ID: <20100706013106.GA19923@linux-mips.org>
References: <20100701203751.GA870@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100701203751.GA870@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 01, 2010 at 01:37:52PM -0700, David VomLehn wrote:

> Additional changes to Youichi Yuasa's command line simplication code
> 
> The PowerTV platform uses a non-standard way to get the kernel command
> line--we insert a built-in command line into arcs_cmdline and to
> get additional command line information from the bootloader via a
> pointer in the a1 register. It is necessary to insert a space between
> to the two strings or the last argument from arcs_cmdline and the first
> argument from the bootloader may be inadvertantly combined.
> 
> It is also necessary to set CONFIG_CMDLINE_BOOL to "y" and to set the
> default command line to an empty string to get the simplified code to
> work properly in the PowerTV environment.

Queued for 2.6.36 - but if absolutely necessary, should
CONFIG_CMDLINE_BOOL not be selected?

  Ralf
