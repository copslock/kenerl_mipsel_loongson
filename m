Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2010 15:44:35 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35689 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492220Ab0AKOob (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jan 2010 15:44:31 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0BEiJoF007537;
        Mon, 11 Jan 2010 15:44:20 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0BEiHlA007535;
        Mon, 11 Jan 2010 15:44:17 +0100
Date:   Mon, 11 Jan 2010 15:44:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     "Bozic, Rade (EXT-Other - DE/Ulm)" <rade.bozic.ext@nsn.com>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-i2c@vger.kernel.org,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
        "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
Subject: Re: [PATCH 0/3] Add I2C support for Octeon SOCs.
Message-ID: <20100111144416.GA23157@linux-mips.org>
References: <4B463B1F.6000404@caviumnetworks.com>
 <4B463C71.3080005@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B463C71.3080005@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7070

On Thu, Jan 07, 2010 at 11:56:33AM -0800, David Daney wrote:

> David Daney wrote:
> >This patch set adds I2C driver support for Cavium Networks' Octeon
> >processor family.  The Octeon is a multi-core MIPS64 based SOC.
> >
> >The first patch adds platform devices for the I2C devices.  The second
> >patch is the main driver.  Finally the third patch registers some
> >devices so we have something to control with the fancy new driver.
> >
> >I will reply with the three patches.
> >
> >David Daney (2):
> >  MIPS: Octeon: Add I2C platform driver.
> >  MIPS: Octeon: Register some devices on the I2C bus.
> >
> >Rade Bozic (1):
> >  I2C: Add driver for Cavium OCTEON I2C ports.

Do you want to merge this series through the MIPS tree?

  Ralf
