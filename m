Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 21:26:40 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:52760 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827534Ab3FRT0hxPKSq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 21:26:37 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 942DF97E;
        Tue, 18 Jun 2013 19:26:31 +0000 (UTC)
Date:   Tue, 18 Jun 2013 12:26:31 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>, Jiri Slaby <jslaby@suse.cz>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/5] MIPS/tty/8250: Use standard 8250 drivers for OCTEON
Message-ID: <20130618192631.GB21038@kroah.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36996
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

On Tue, Jun 18, 2013 at 12:12:50PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Get rid of the custom OCTEON UART probe code and use 8250_dw instead.
> 
> The first patch just gets rid of Ralf's Kconfig workarounds for the
> real problem, which is OCTEON's inclomplete serial support.
> 
> Then we just make minor patches to 8250_dw, and rip out all this
> OCTEON code.
> 
> Since the patches are all interdependent, we might want to merge them
> via a single tree (perhaps Ralf's MIPS tree).

That's fine with me, I've acked the tty driver changes so feel free to
take all of these through the mips tree.

thanks,

greg k-h
