Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jan 2010 01:49:18 +0100 (CET)
Received: from mail.lysator.liu.se ([130.236.254.3]:40220 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492203Ab0AMAtN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jan 2010 01:49:13 +0100
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
        by mail.lysator.liu.se (Postfix) with ESMTP id 8C03740015;
        Wed, 13 Jan 2010 01:47:51 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
        id 8121440018; Wed, 13 Jan 2010 01:47:51 +0100 (CET)
Received: from [192.168.10.105] (c-9fb8e555.035-105-73746f38.cust.bredbandsbolaget.se [85.229.184.159])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.lysator.liu.se (Postfix) with ESMTP id 3515540015;
        Wed, 13 Jan 2010 01:47:51 +0100 (CET)
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-i2c@vger.kernel.org,
        "Bozic, Rade (EXT-Other - DE/Ulm)" <rade.bozic.ext@nsn.com>,
        linux-mips <linux-mips@linux-mips.org>,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
        "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
Message-Id: <F5F1F5D1-6057-49CF-A5B3-A921E1C0EEEB@lysator.liu.se>
From:   Markus Gothe <nietzsche@lysator.liu.se>
To:     David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <4B4B5CD3.4040204@caviumnetworks.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 0/3] Add I2C support for Octeon SOCs.
Date:   Wed, 13 Jan 2010 01:49:08 +0100
References: <4B463B1F.6000404@caviumnetworks.com> <4B463C71.3080005@caviumnetworks.com> <20100111144416.GA23157@linux-mips.org> <4B4B5CD3.4040204@caviumnetworks.com>
X-Mailer: Apple Mail (2.936)
X-Virus-Scanned: ClamAV using ClamSMTP
X-archive-position: 25576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nietzsche@lysator.liu.se
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8147

Methinks this goes to I2C...

//Markus
On 11 Jan 2010, at 18:16, David Daney wrote:

> Ralf Baechle wrote:
>> On Thu, Jan 07, 2010 at 11:56:33AM -0800, David Daney wrote:
>>> David Daney wrote:
>>>> This patch set adds I2C driver support for Cavium Networks' Octeon
>>>> processor family.  The Octeon is a multi-core MIPS64 based SOC.
>>>>
>>>> The first patch adds platform devices for the I2C devices.  The  
>>>> second
>>>> patch is the main driver.  Finally the third patch registers some
>>>> devices so we have something to control with the fancy new driver.
>>>>
>>>> I will reply with the three patches.
>>>>
>>>> David Daney (2):
>>>> MIPS: Octeon: Add I2C platform driver.
>>>> MIPS: Octeon: Register some devices on the I2C bus.
>>>>
>>>> Rade Bozic (1):
>>>> I2C: Add driver for Cavium OCTEON I2C ports.
>> Do you want to merge this series through the MIPS tree?
>
> Two of the patches touch only arch/mips/cavium-octeon, so it might  
> make sense.  But the I2C maintainers may have other desires, so I  
> would defer to them.
>
> David Daney
>
