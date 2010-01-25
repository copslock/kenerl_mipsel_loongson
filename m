Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2010 19:19:21 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10034 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492515Ab0AYSTR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jan 2010 19:19:17 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b5de0a90000>; Mon, 25 Jan 2010 10:19:21 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 25 Jan 2010 10:19:14 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 25 Jan 2010 10:19:14 -0800
Message-ID: <4B5DE0A2.8070405@caviumnetworks.com>
Date:   Mon, 25 Jan 2010 10:19:14 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ben Dooks <ben-linux@fluff.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-i2c@vger.kernel.org, khali@linux-fr.org,
        rade.bozic.ext@nsn.com, ml.lawnick@gmx.de
Subject: Re: [PATCH 2/3] I2C: Add driver for Cavium OCTEON I2C ports.
References: <4B463B1F.6000404@caviumnetworks.com> <1262894061-32613-2-git-send-email-ddaney@caviumnetworks.com> <20100124160017.GF28675@fluff.org.uk>
In-Reply-To: <20100124160017.GF28675@fluff.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jan 2010 18:19:14.0719 (UTC) FILETIME=[E66B72F0:01CA9DEA]
X-archive-position: 25654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16125

Ben Dooks wrote:
> On Thu, Jan 07, 2010 at 11:54:20AM -0800, David Daney wrote:
>> From: Rade Bozic <rade.bozic.ext@nsn.com>
>>
>> Signed-off-by: Rade Bozic <rade.bozic.ext@nsn.com>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>  drivers/i2c/busses/Kconfig      |   10 +
>>  drivers/i2c/busses/Makefile     |    1 +
>>  drivers/i2c/busses/i2c-octeon.c |  579 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 590 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/i2c/busses/i2c-octeon.c
[...]
>> +
>> +#ifndef NO_IRQ
>> +#define NO_IRQ (-1)
>> +#endif
> 
> this does not fill me with a warm joyous feeling... 
> 

Indeed.

[ many other helpful comments deleted for brevity.]

We will improve the driver and resubmit.

Thanks for looking at it.

David Daney
