Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2010 19:09:58 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44124 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492429Ab0CPSJy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Mar 2010 19:09:54 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2GI9oJT005527;
        Tue, 16 Mar 2010 19:09:50 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2GI9kX9005524;
        Tue, 16 Mar 2010 19:09:46 +0100
Date:   Tue, 16 Mar 2010 19:09:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yang Shi <yang.shi@windriver.com>
Cc:     ddaney@caviumnetworks.com, ben-linux@fluff.org, khali@linux-fr.org,
        linux-mips@linux-mips.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V2] MIPS: Octeon: Register EEPROM device on the I2C bus
Message-ID: <20100316180946.GC20160@linux-mips.org>
References: <1268026190-18300-1-git-send-email-yang.shi@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1268026190-18300-1-git-send-email-yang.shi@windriver.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 08, 2010 at 01:29:50PM +0800, Yang Shi wrote:

> An SPD resides on 0x50 of the I2C bus on CN56xx/57xx board,
> register this device.

I wonder what the use case for this patch is?  Normally Linux doesn't care
about SPD.

I also wonder how this will work for configurations with multiple memory
modules thus multiple SPD EEPROMS.

  Ralf
