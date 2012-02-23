Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 22:27:49 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:47129 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903629Ab2BWV1q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Feb 2012 22:27:46 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 82E278F61;
        Thu, 23 Feb 2012 22:27:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XTQJOohT5keX; Thu, 23 Feb 2012 22:27:31 +0100 (CET)
Received: from [192.168.1.220] (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 3ACFD8F60;
        Thu, 23 Feb 2012 22:27:31 +0100 (CET)
Message-ID: <4F46AF41.6060803@hauke-m.de>
Date:   Thu, 23 Feb 2012 22:27:29 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linville@tuxdriver.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch
Subject: Re: [PATCH 01/11] ssb: sprom fix some sizes / signedness
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de> <1329676345-15856-2-git-send-email-hauke@hauke-m.de> <CACna6rwNEPY3iJCeWV3AmbBy7fQwQrgr9Oji6tro-Dr23y5udQ@mail.gmail.com>
In-Reply-To: <CACna6rwNEPY3iJCeWV3AmbBy7fQwQrgr9Oji6tro-Dr23y5udQ@mail.gmail.com>
X-Enigmail-Version: 1.3.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/23/2012 07:14 PM, Rafał Miłecki wrote:
> 2012/2/19 Hauke Mehrtens <hauke@hauke-m.de>:
>> @@ -53,10 +53,10 @@ struct ssb_sprom {
>>        u8 gpio1;               /* GPIO pin 1 */
>>        u8 gpio2;               /* GPIO pin 2 */
>>        u8 gpio3;               /* GPIO pin 3 */
>> -       u16 maxpwr_bg;          /* 2.4GHz Amplifier Max Power (in dBm Q5.2) */
>> -       u16 maxpwr_al;          /* 5.2GHz Amplifier Max Power (in dBm Q5.2) */
>> -       u16 maxpwr_a;           /* 5.3GHz Amplifier Max Power (in dBm Q5.2) */
>> -       u16 maxpwr_ah;          /* 5.8GHz Amplifier Max Power (in dBm Q5.2) */
>> +       u8 maxpwr_bg;           /* 2.4GHz Amplifier Max Power (in dBm Q5.2) */
>> +       u8 maxpwr_al;           /* 5.2GHz Amplifier Max Power (in dBm Q5.2) */
>> +       u8 maxpwr_a;            /* 5.3GHz Amplifier Max Power (in dBm Q5.2) */
>> +       u8 maxpwr_ah;           /* 5.8GHz Amplifier Max Power (in dBm Q5.2) */
>>        u8 itssi_a;             /* Idle TSSI Target for A-PHY */
>>        u8 itssi_bg;            /* Idle TSSI Target for B/G-PHY */
>>        u8 tri2g;               /* 2.4GHz TX isolation */
> 
> Just a note in case you're going to develop ssb/bcma/b43/brcm code.
> Please note we're trying to switch from properties you modified to
> struct ssb_sprom_core_pwr_info.
These vars are available in sprom 1-3,8,9 and the ones in struct
ssb_sprom_core_pwr_info just for sprom 4,5,8,9. The old are probably not
used by newer chips any more. I just found these because I generated my
parsing code from broadcom open source code and got a compiler warning
because of wrong sizes.
> 
> The patch still looks fine.
> 
