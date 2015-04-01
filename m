Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 14:17:42 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41516 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014911AbbDAMRlcK8Yo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Apr 2015 14:17:41 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 6E7E128C911;
        Wed,  1 Apr 2015 14:17:00 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com [209.85.192.44])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 7CA5228BF5F;
        Wed,  1 Apr 2015 14:16:57 +0200 (CEST)
Received: by qgf60 with SMTP id 60so40076706qgf.3;
        Wed, 01 Apr 2015 05:17:36 -0700 (PDT)
X-Received: by 10.229.192.199 with SMTP id dr7mr1509160qcb.8.1427890656578;
 Wed, 01 Apr 2015 05:17:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.42.229 with HTTP; Wed, 1 Apr 2015 05:17:16 -0700 (PDT)
In-Reply-To: <CAGVrzcbgds+zHbTJWnUi48Nn1xPiEjGV7PGRmUX46da2CD+G=g@mail.gmail.com>
References: <20140624153959.GA19564@google.com> <1403624918.29061.16.camel@joe-AO725>
 <CAGVrzcbgds+zHbTJWnUi48Nn1xPiEjGV7PGRmUX46da2CD+G=g@mail.gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 1 Apr 2015 14:17:16 +0200
Message-ID: <CAOiHx==91cquJ0OAf-n40HB39HbtLw-5RrxhxtsJXbTyNgit8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] ar7: replace mac address parsing
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Joe Perches <joe@perches.com>, Daniel Walter <dwalter@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, Jun 24, 2014 at 9:26 PM, Florian Fainelli <florian@openwrt.org> wrote:
> 2014-06-24 8:48 GMT-07:00 Joe Perches <joe@perches.com>:
>> On Tue, 2014-06-24 at 16:39 +0100, Daniel Walter wrote:
>>> Replace sscanf() with mac_pton().
>> []
>>> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
>> []
>>> @@ -307,10 +307,7 @@ static void __init cpmac_get_mac(int instance, unsigned char *dev_addr)
>>>       }
>>>
>>>       if (mac) {
>>> -             if (sscanf(mac, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
>>> -                                     &dev_addr[0], &dev_addr[1],
>>> -                                     &dev_addr[2], &dev_addr[3],
>>> -                                     &dev_addr[4], &dev_addr[5]) != 6) {
>>> +             if (!mac_pton(mac, dev_addr)) {
>>
>> There is a slight functional change with this conversion.
>>
>> mac_pton is strict about leading 0's and requires a 17 char strlen.
>
> I do not have my devices handy, but I am fairly positive the use of
> sscanf() was exactly for that, we may or may not have leading zeroes.
> I am feeling a little uncomfortable with random code changes like that
> without being actually able to test on real hardware that has a
> variety of bootloaders and environment variables.

One of my two devices has a mac address with one of the numbers being
< 16, and it uses a fixed length mac:

(psbl) printenv
...
HWA_0           00:16:B6:2A:A4:3B

Also looking at the history[1] of this code, it looks like this was
just an optimization of an earlier code which did expect 17 char len:

       for (i = 0; i < 6; i++)
               dev_addr[i] = (char2hex(mac[i * 3]) << 4) +
                       char2hex(mac[i * 3 + 1]);


So I'm tempted to say it should not cause any issues. But my sample
size is rather small.


Regards
Jonas


[1] d16f7093b6eb4f3859856f6ee4ab504cbeeea0b9
