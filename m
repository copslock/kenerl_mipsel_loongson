Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2010 18:23:36 +0100 (CET)
Received: from bamako.nerim.net ([62.4.17.28]:61089 "EHLO bamako.nerim.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492654Ab0AKRXc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jan 2010 18:23:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by bamako.nerim.net (Postfix) with ESMTP id B91C239DE4A;
        Mon, 11 Jan 2010 18:23:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at nerim.net
Received: from bamako.nerim.net ([127.0.0.1])
        by localhost (bamako.nerim.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GvoZROKFlmfw; Mon, 11 Jan 2010 18:23:28 +0100 (CET)
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
        by bamako.nerim.net (Postfix) with ESMTP id 8245439DE57;
        Mon, 11 Jan 2010 18:23:28 +0100 (CET)
Date:   Mon, 11 Jan 2010 18:23:30 +0100
From:   Jean Delvare <khali@linux-fr.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-i2c@vger.kernel.org,
        "Bozic, Rade (EXT-Other - DE/Ulm)" <rade.bozic.ext@nsn.com>,
        linux-mips <linux-mips@linux-mips.org>,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
Subject: Re: [PATCH 0/3] Add I2C support for Octeon SOCs.
Message-ID: <20100111182330.2644e34a@hyperion.delvare>
In-Reply-To: <4B4B5CD3.4040204@caviumnetworks.com>
References: <4B463B1F.6000404@caviumnetworks.com>
        <4B463C71.3080005@caviumnetworks.com>
        <20100111144416.GA23157@linux-mips.org>
        <4B4B5CD3.4040204@caviumnetworks.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 25566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7153

On Mon, 11 Jan 2010 09:16:03 -0800, David Daney wrote:
> Ralf Baechle wrote:
> > On Thu, Jan 07, 2010 at 11:56:33AM -0800, David Daney wrote:
> > 
> >> David Daney wrote:
> >>> This patch set adds I2C driver support for Cavium Networks' Octeon
> >>> processor family.  The Octeon is a multi-core MIPS64 based SOC.
> >>>
> >>> The first patch adds platform devices for the I2C devices.  The second
> >>> patch is the main driver.  Finally the third patch registers some
> >>> devices so we have something to control with the fancy new driver.
> >>>
> >>> I will reply with the three patches.
> >>>
> >>> David Daney (2):
> >>>  MIPS: Octeon: Add I2C platform driver.
> >>>  MIPS: Octeon: Register some devices on the I2C bus.
> >>>
> >>> Rade Bozic (1):
> >>>  I2C: Add driver for Cavium OCTEON I2C ports.
> > 
> > Do you want to merge this series through the MIPS tree?
> 
> Two of the patches touch only arch/mips/cavium-octeon, so it might make 
> sense.  But the I2C maintainers may have other desires, so I would defer 
> to them.

I won't take care of them, so I have no objection if the go through the
MIPS tree. For a platform-specific driver I think it makes a lot of
sense.

-- 
Jean Delvare
