Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2011 18:38:16 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:59206 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491180Ab1CBRiN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2011 18:38:13 +0100
Received: by bwz1 with SMTP id 1so396373bwz.36
        for <multiple recipients>; Wed, 02 Mar 2011 09:38:08 -0800 (PST)
Received: by 10.204.45.86 with SMTP id d22mr311812bkf.8.1299087488075;
        Wed, 02 Mar 2011 09:38:08 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id z18sm135552bkf.8.2011.03.02.09.38.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2011 09:38:07 -0800 (PST)
Message-ID: <4D6E8025.2030702@mvista.com>
Date:   Wed, 02 Mar 2011 20:36:37 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org> <1298996006-15960-6-git-send-email-blogic@openwrt.org> <4D6E286D.9050100@mvista.com> <20110302142933.GA18221@linux-mips.org> <4D6E5CA9.5090201@openwrt.org> <20110302162730.GA23666@linux-mips.org>
In-Reply-To: <20110302162730.GA23666@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>> Hi Ralf,
>>> While nitpicking - there should be one space between include and < in
>>> #include <blah.h>.

>> where did you see that ?

>> +#include<linux/module.h>
>> +#include<linux/fs.h>
>> +#include<linux/miscdevice.h>
>> +#include<linux/watchdog.h>
>> +#include<linux/platform_device.h>
>> +#include<linux/uaccess.h>
>> +#include<linux/clk.h>
>> +#include<linux/io.h>
>> +
>> +#include<lantiq.h>

> But that only seems to have happened to the code quoted in Sergei's mail.

    Stupid Thunderbird is to be blamed here. :-)

>   Ralf

WBR, Sergei
