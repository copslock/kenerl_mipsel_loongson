Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2010 18:16:23 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19667 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492659Ab0AKRQT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jan 2010 18:16:19 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b4b5cd90000>; Mon, 11 Jan 2010 09:16:09 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 11 Jan 2010 09:16:05 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 11 Jan 2010 09:16:05 -0800
Message-ID: <4B4B5CD3.4040204@caviumnetworks.com>
Date:   Mon, 11 Jan 2010 09:16:03 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, linux-i2c@vger.kernel.org
CC:     "Bozic, Rade (EXT-Other - DE/Ulm)" <rade.bozic.ext@nsn.com>,
        linux-mips <linux-mips@linux-mips.org>,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
        "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
Subject: Re: [PATCH 0/3] Add I2C support for Octeon SOCs.
References: <4B463B1F.6000404@caviumnetworks.com> <4B463C71.3080005@caviumnetworks.com> <20100111144416.GA23157@linux-mips.org>
In-Reply-To: <20100111144416.GA23157@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jan 2010 17:16:05.0135 (UTC) FILETIME=[C1DE51F0:01CA92E1]
X-archive-position: 25565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7149

Ralf Baechle wrote:
> On Thu, Jan 07, 2010 at 11:56:33AM -0800, David Daney wrote:
> 
>> David Daney wrote:
>>> This patch set adds I2C driver support for Cavium Networks' Octeon
>>> processor family.  The Octeon is a multi-core MIPS64 based SOC.
>>>
>>> The first patch adds platform devices for the I2C devices.  The second
>>> patch is the main driver.  Finally the third patch registers some
>>> devices so we have something to control with the fancy new driver.
>>>
>>> I will reply with the three patches.
>>>
>>> David Daney (2):
>>>  MIPS: Octeon: Add I2C platform driver.
>>>  MIPS: Octeon: Register some devices on the I2C bus.
>>>
>>> Rade Bozic (1):
>>>  I2C: Add driver for Cavium OCTEON I2C ports.
> 
> Do you want to merge this series through the MIPS tree?
> 

Two of the patches touch only arch/mips/cavium-octeon, so it might make 
sense.  But the I2C maintainers may have other desires, so I would defer 
to them.

David Daney
