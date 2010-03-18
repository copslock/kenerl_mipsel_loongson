Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2010 18:48:54 +0100 (CET)
Received: from poutre.nerim.net ([62.4.16.124]:55922 "EHLO poutre.nerim.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492182Ab0CRRsv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Mar 2010 18:48:51 +0100
Received: from localhost (localhost [127.0.0.1])
        by poutre.nerim.net (Postfix) with ESMTP id 7E67339DE93;
        Thu, 18 Mar 2010 18:48:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at nerim.net
Received: from poutre.nerim.net ([127.0.0.1])
        by localhost (poutre.nerim.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1UPixwFqrkFu; Thu, 18 Mar 2010 18:48:46 +0100 (CET)
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
        by poutre.nerim.net (Postfix) with ESMTP id 572A939DE7C;
        Thu, 18 Mar 2010 18:48:46 +0100 (CET)
Date:   Thu, 18 Mar 2010 18:48:48 +0100
From:   Jean Delvare <khali@linux-fr.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Yang Shi <yang.shi@windriver.com>, ddaney@caviumnetworks.com,
        ben-linux@fluff.org, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH V2] MIPS: Octeon: Register EEPROM device on the I2C bus
Message-ID: <20100318184848.4ec62327@hyperion.delvare>
In-Reply-To: <20100318170030.GJ4554@linux-mips.org>
References: <1268026190-18300-1-git-send-email-yang.shi@windriver.com>
        <20100316180946.GC20160@linux-mips.org>
        <20100316200647.3803edf1@hyperion.delvare>
        <20100318170030.GJ4554@linux-mips.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Thu, 18 Mar 2010 18:00:30 +0100, Ralf Baechle wrote:
> On Tue, Mar 16, 2010 at 08:06:47PM +0100, Jean Delvare wrote:
> 
> > The Linux kernel doesn't care, but user-space may. As a matter of fact,
> > there is a script out there (decode-dimms, in the i2c-tools package)
> > decoding the SPD data and presenting it to the user. Some people want
> > to know the details about their memory modules.
> > 
> > > I also wonder how this will work for configurations with multiple memory
> > > modules thus multiple SPD EEPROMS.
> > 
> > The kernel code should instantiate one spd device per memory module
> > (assuming they are all reachable.) Obviously this can't be done in a
> > static way.
> 
> SPD is virtually omnipresent these days so I wonder if maybe there already
> is some probing functionality already available?

Not that I aware of, except for the fact that the "eeprom" driver will
probe all i2c adapters with class bit I2C_CLASS_SPD set for chips at
addresses 0x50-0x57, and it will instantiate a device for each of them.
This will instantiate devices for non-SPD EEPROM, and even non-EEPROMs
living at these addresses, so this can't really be considered a generic
solution.

A generic solution would let the platform (not the eeprom driver) probe
for devices at selected I2C addresses (the ones where SPD EEPROMs can
live of the specific platform) and instantiate spd devices (possibly
after integrity checking). This would avoid false positives.

-- 
Jean Delvare
