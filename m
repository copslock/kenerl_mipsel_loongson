Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 19:20:44 +0200 (CEST)
Received: from cantor.suse.de ([195.135.220.2]:35019 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491759Ab0FSRUk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Jun 2010 19:20:40 +0200
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.suse.de (Postfix) with ESMTP id 4B18490975;
        Sat, 19 Jun 2010 19:20:40 +0200 (CEST)
Date:   Sat, 19 Jun 2010 10:17:01 -0700
From:   Greg KH <gregkh@suse.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        David Brownell <dbrownell@users.sourceforge.net>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 19/26] USB: Add JZ4740 ohci support
Message-ID: <20100619171701.GA28151@suse.de>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
 <1276924111-11158-20-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1276924111-11158-20-git-send-email-lars@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13571

On Sat, Jun 19, 2010 at 07:08:24AM +0200, Lars-Peter Clausen wrote:
> This patch adds ohci glue code for JZ4740 SoCs ohci module.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: linux-usb@vger.kernel.org

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
