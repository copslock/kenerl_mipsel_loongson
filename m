Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2010 07:24:15 +0100 (CET)
Received: from imr4.ericy.com ([198.24.6.8]:39062 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491057Ab0LGGYK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Dec 2010 07:24:10 +0100
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id oB76rDnk027372;
        Tue, 7 Dec 2010 00:53:15 -0600
Received: from localhost (147.117.20.213) by eusaamw0711.eamcs.ericsson.se
 (147.117.20.179) with Microsoft SMTP Server id 8.2.234.1; Tue, 7 Dec 2010
 01:23:44 -0500
Date:   Mon, 6 Dec 2010 22:23:44 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Matt Turner <mattst88@gmail.com>
CC:     Jean Delvare <khali@linux-fr.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Message-ID: <20101207062344.GA20673@ericsson.com>
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
X-archive-position: 28622
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

[ .. ] 
> 
> -static struct i2c_algo_sibyte_data sibyte_board_data[2] = {
> -       { NULL, 0, (void *) (CKSEG1+A_SMB_BASE(0)) },
> -       { NULL, 1, (void *) (CKSEG1+A_SMB_BASE(1)) }
> +static struct i2c_algo_sibyte_data i2c_sibyte_board_data[2] = {
> +       {
> +               .name   = "sb1250-smbus-0",
> +               .base   = A_SMB_0,
> +               .irq    = K_INT_SMB_0,
> +       },
> +       {
> +               .name   = "sb1250-smbus-1",
> +               .base   = A_SMB_1,
> +               .irq    = K_INT_SMB_1,

Found my problem. The .irq settings don't work for BCM1480.
It needs K_BCM1480_INT_SMB_0 and K_BCM1480_INT_SMB_1 from asm/sibyte/bcm1480_int.h.

For a clean fix, i2c_sibyte_board_data[] should probably be defined in a platform file, 
not in the i2c bus driver.

Guenter
