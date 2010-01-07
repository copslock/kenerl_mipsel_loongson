Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2010 20:57:18 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19040 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492686Ab0AGT5O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2010 20:57:14 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b463c9a0002>; Thu, 07 Jan 2010 11:57:14 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 11:56:33 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 7 Jan 2010 11:56:33 -0800
Message-ID: <4B463C71.3080005@caviumnetworks.com>
Date:   Thu, 07 Jan 2010 11:56:33 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     "Bozic, Rade (EXT-Other - DE/Ulm)" <rade.bozic.ext@nsn.com>
CC:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-i2c@vger.kernel.org,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
        "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
Subject: Re: [PATCH 0/3] Add I2C support for Octeon SOCs.
References: <4B463B1F.6000404@caviumnetworks.com>
In-Reply-To: <4B463B1F.6000404@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jan 2010 19:56:33.0523 (UTC) FILETIME=[832EBC30:01CA8FD3]
X-archive-position: 25540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 5187

Bah...  I forgot to include Rade Bozic on the original message.  Now 
included.

David Daney wrote:
> This patch set adds I2C driver support for Cavium Networks' Octeon
> processor family.  The Octeon is a multi-core MIPS64 based SOC.
> 
> The first patch adds platform devices for the I2C devices.  The second
> patch is the main driver.  Finally the third patch registers some
> devices so we have something to control with the fancy new driver.
> 
> I will reply with the three patches.
> 
> David Daney (2):
>   MIPS: Octeon: Add I2C platform driver.
>   MIPS: Octeon: Register some devices on the I2C bus.
> 
> Rade Bozic (1):
>   I2C: Add driver for Cavium OCTEON I2C ports.
> 
>  arch/mips/cavium-octeon/octeon-platform.c |   85 +++++
>  arch/mips/include/asm/octeon/octeon.h     |    5 +
>  drivers/i2c/busses/Kconfig                |   10 +
>  drivers/i2c/busses/Makefile               |    1 +
>  drivers/i2c/busses/i2c-octeon.c           |  579 
> +++++++++++++++++++++++++++++
>  5 files changed, 680 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-octeon.c
> 
> 
