Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 22:55:30 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33222 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025960AbbEAUz2uNPSi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 22:55:28 +0200
Received: from localhost (unknown [87.213.45.130])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A40ECBBC;
        Fri,  1 May 2015 20:55:22 +0000 (UTC)
Date:   Fri, 1 May 2015 22:55:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>,
        devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] MIPS: OCTEON: move all octeon-ethernet code to
 staging
Message-ID: <20150501205519.GA2550@kroah.com>
References: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Fri, May 01, 2015 at 10:37:02PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> In order to octeon-ethernet staging work to proceed, we should have all
> the code in the same tree (staging). Currently, most of the driver code
> actually lives in the MIPS tree in the "cvmx" helper or OS abstraction
> routines and include files. Majority of this code needs refactoring
> (or deletion) for the octeon-ethernet to become a normal Linux driver.
> Since rest of the kernel does not need this code at all, it should
> make sense to move it all into the same place while the driver
> is being developed.
> 
> This series does not make any functional changes, just moves the code.
> Tested on EdgeRouter Lite, EdgeRouter Pro and D-Link DSR-1000N. Also build
> tested with octeon-ethernet as built-in, module and completely disabled.
> Patches are based on staging-next.

I don't object to this, especially if it helps get the octeon code out
of staging sooner.

But I need an ack from the MIPS maintainers before I can accept this into
the staging tree...

thanks,

greg k-h
