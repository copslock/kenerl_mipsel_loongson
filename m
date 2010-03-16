Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2010 20:06:54 +0100 (CET)
Received: from poutre.nerim.net ([62.4.16.124]:60343 "EHLO poutre.nerim.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492315Ab0CPTGt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Mar 2010 20:06:49 +0100
Received: from localhost (localhost [127.0.0.1])
        by poutre.nerim.net (Postfix) with ESMTP id BFF8439DFE0;
        Tue, 16 Mar 2010 20:06:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at nerim.net
Received: from poutre.nerim.net ([127.0.0.1])
        by localhost (poutre.nerim.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7KvgxTmKmJqe; Tue, 16 Mar 2010 20:06:44 +0100 (CET)
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
        by poutre.nerim.net (Postfix) with ESMTP id 860B939DFE6;
        Tue, 16 Mar 2010 20:06:44 +0100 (CET)
Date:   Tue, 16 Mar 2010 20:06:47 +0100
From:   Jean Delvare <khali@linux-fr.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Yang Shi <yang.shi@windriver.com>, ddaney@caviumnetworks.com,
        ben-linux@fluff.org, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V2] MIPS: Octeon: Register EEPROM device on the I2C bus
Message-ID: <20100316200647.3803edf1@hyperion.delvare>
In-Reply-To: <20100316180946.GC20160@linux-mips.org>
References: <1268026190-18300-1-git-send-email-yang.shi@windriver.com>
        <20100316180946.GC20160@linux-mips.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Tue, 16 Mar 2010 19:09:46 +0100, Ralf Baechle wrote:
> On Mon, Mar 08, 2010 at 01:29:50PM +0800, Yang Shi wrote:
> 
> > An SPD resides on 0x50 of the I2C bus on CN56xx/57xx board,
> > register this device.
> 
> I wonder what the use case for this patch is?  Normally Linux doesn't care
> about SPD.

The Linux kernel doesn't care, but user-space may. As a matter of fact,
there is a script out there (decode-dimms, in the i2c-tools package)
decoding the SPD data and presenting it to the user. Some people want
to know the details about their memory modules.

> I also wonder how this will work for configurations with multiple memory
> modules thus multiple SPD EEPROMS.

The kernel code should instantiate one spd device per memory module
(assuming they are all reachable.) Obviously this can't be done in a
static way.

-- 
Jean Delvare
