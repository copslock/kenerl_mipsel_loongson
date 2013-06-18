Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 21:26:15 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:52757 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823114Ab3FRT0OJ5IlG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 21:26:14 +0200
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4EB5997E;
        Tue, 18 Jun 2013 19:26:06 +0000 (UTC)
Date:   Tue, 18 Jun 2013 12:26:05 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>, Jiri Slaby <jslaby@suse.cz>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/5] tty/8250_dw: Add support for OCTEON UARTS.
Message-ID: <20130618192605.GA21038@kroah.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
 <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371582775-12141-4-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36995
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

On Tue, Jun 18, 2013 at 12:12:53PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> A few differences needed by OCTEON:
> 
> o These are DWC UARTS, but have USR at a different offset.
> 
> o OCTEON must have 64-bit wide register accesses, so we have OCTEON
>   specific register accessors.
> 
> o No UCV register, so we hard code some properties.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 45 +++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
