Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2011 22:03:30 +0200 (CEST)
Received: from imr3.ericy.com ([198.24.6.13]:50601 "EHLO imr3.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492062Ab1HVUDZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Aug 2011 22:03:25 +0200
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
        by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id p7MK333F010401
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 22 Aug 2011 15:03:04 -0500
Received: from [155.53.96.104] (147.117.20.214) by
 eusaamw0707.eamcs.ericsson.se (147.117.20.92) with Microsoft SMTP Server id
 8.3.137.0; Mon, 22 Aug 2011 16:03:02 -0400
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: guenter.roeck@ericsson.com
To:     Matt Turner <mattst88@gmail.com>
CC:     Jean Delvare <khali@linux-fr.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: Ericsson
Date:   Mon, 22 Aug 2011 13:02:56 -0700
Message-ID: <1314043376.3235.105.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.32.2 
Content-Transfer-Encoding: 7bit
X-archive-position: 30947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 2011-08-18 at 19:43 -0400, Matt Turner wrote:
> From: Maciej W. Rozycki <macro@linux-mips.org>
> 
> This is a rewrite of large parts of the driver mainly so that it uses
> SMBus interrupts to offload the CPU from busy-waiting on status inputs.
> As a part of the overhaul of the init and exit calls, all accesses to the
> hardware got converted to use accessory functions via an ioremap() cookie.
> 
> [mattst88] Added BCM1480 interrupts and rebased minimally.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

Patch works fine on our target, and shows significant speed improvements
for i2c accesses.

Linux version 3.0.3-428-g17c1f3f (groeck@rbos-pc-13) (gcc version 4.4.1
(Debian 4.4.1-1) ) #2 SMP Mon Aug 22 12:56:41 PDT 2011
bootconsole [early0] enabled
CPU revision is: 01041100 (SiByte SB1A)
FPU revision is: 000f0103
Checking for the multiply/shift bug... no.
Checking for the daddiu bug... no.
Broadcom SiByte BCM1480 B1 (pass2) @ 900 MHz (SB-1A rev 0)

Tested-by: Guenter Roeck <guenter.roeck@ericsson.com>

Guenter
