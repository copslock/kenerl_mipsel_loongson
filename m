Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2010 18:31:16 +0100 (CET)
Received: from imr4.ericy.com ([198.24.6.8]:36566 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492036Ab0LFRbH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Dec 2010 18:31:07 +0100
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id oB6I02vJ007644;
        Mon, 6 Dec 2010 12:00:06 -0600
Received: from localhost (147.117.20.213) by eusaamw0706.eamcs.ericsson.se
 (147.117.20.91) with Microsoft SMTP Server id 8.2.234.1; Mon, 6 Dec 2010
 12:30:40 -0500
Date:   Mon, 6 Dec 2010 09:30:40 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Matt Turner <mattst88@gmail.com>
CC:     Jean Delvare <khali@linux-fr.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Message-ID: <20101206173040.GA18372@ericsson.com>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1291617494-18430-1-git-send-email-mattst88@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <groeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Mon, Dec 06, 2010 at 01:38:14AM -0500, Matt Turner wrote:
> From: Maciej W. Rozycki <macro@linux-mips.org>
> 
> This is a rewrite of large parts of the driver mainly so that it uses
> SMBus interrupts to offload the CPU from busy-waiting on status inputs.
> As a part of the overhaul of the init and exit calls, all accesses to the
> hardware got converted to use accessory functions via an ioremap() cookie.
> 
> Minimally rebased by Matt Turner.
> 
> Tested-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>


I applied the patch to my 1480 tree. Unfortunately, it doesn't work with my system.
As far as I can see, the driver does not get any interrupts.

My tree is 2.6.32, though. Do you know if I might be missing some other relevant patch ?

Thanks,
Guenter
