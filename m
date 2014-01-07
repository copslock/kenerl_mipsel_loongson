Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jan 2014 22:37:20 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41925 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816841AbaAGVhTNKkr5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jan 2014 22:37:19 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id EE5B68F63;
        Tue,  7 Jan 2014 22:37:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DHRTgdZN2zJ0; Tue,  7 Jan 2014 22:37:10 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:f92d:7ca2:7eaf:38b4] (unknown [IPv6:2001:470:1f0b:447:f92d:7ca2:7eaf:38b4])
        by hauke-m.de (Postfix) with ESMTPSA id F42028F61;
        Tue,  7 Jan 2014 22:37:09 +0100 (CET)
Message-ID: <52CC7383.5050502@hauke-m.de>
Date:   Tue, 07 Jan 2014 22:37:07 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Jean-Yves Avenard <jyavenard@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Patch for the "ug" bug
References: <CANpj82+h1a0qBfaaYpqmuL69JpbB+T_z0pg0iL=5JPBvDE9A2w@mail.gmail.com>        <52CC5B12.8090305@hauke-m.de> <CANpj82Ln1SkOR-DQwK9Dy5E71QVE0PG3fWxOpkzX=B+T7dHU2Q@mail.gmail.com>
In-Reply-To: <CANpj82Ln1SkOR-DQwK9Dy5E71QVE0PG3fWxOpkzX=B+T7dHU2Q@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 01/07/2014 10:25 PM, Jean-Yves Avenard wrote:
> On 7 January 2014 20:52, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> 
>>
>> Hi,
>>
>> this is a little late but I haven't seen this earlier. I just tried your
>> script and had no problems on my Asus RT-N66U running OpenWrt with
>> kernel 3.10.24. This problem was either cause by some other non upstream
>> Broadcom modification or was already fixed in mainline kernel.
>>
> 
> As you wrote, you're a little late.... about 18 months late...
> 
> The issue was in the mips memory management in 2.6.x kernel....
> FWIW; all tomato and dd-wrt firmware include this fix.
> 
> Now the question is more about weither the fix is in your kernel or not...
> 
tomato and dd-wrt are using kernel 2.6.23 is that correct? This kernel
is from October 2007 and EOL some years now, more than 18 months.

I do not think this patch went in as it is still in state new in
patchwork and pretty ugly:
http://patchwork.linux-mips.org/patch/3945/

I just found this by looking at some older patches in state new in
patchwork and just had this device on my desk.

This patch is not in OpenWrt and I am not aware of any similar patch
being in OpenWrt and not in the mainline kernel, so I stay with my
assumption that this problem was caused by some Broadcom modification
not in upstream kernel or it was fixed in the last 5 years by someone
else in a different way in the mainline kernel.

Hauke
