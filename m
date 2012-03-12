Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2012 21:48:27 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:46742 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903609Ab2CLUsV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2012 21:48:21 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B8FC58F61;
        Mon, 12 Mar 2012 21:48:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LFUMMMykI914; Mon, 12 Mar 2012 21:47:49 +0100 (CET)
Received: from [192.168.1.220] (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 137BC8F60;
        Mon, 12 Mar 2012 21:47:34 +0100 (CET)
Message-ID: <4F5E60E2.3080203@hauke-m.de>
Date:   Mon, 12 Mar 2012 21:47:30 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     "John W. Linville" <linville@tuxdriver.com>,
        Julian Calaby <julian.calaby@gmail.com>,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-mips@linux-mips.org, ralf@linux-mips.org, m@bues.ch,
        linux-usb@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/7] bcma: scan for extra address space
References: <1331496505-18697-1-git-send-email-hauke@hauke-m.de> <1331496505-18697-4-git-send-email-hauke@hauke-m.de> <CAGRGNgX116dRB03NTL_DFZ4b_PYcdY+Un_cVwt6ZUGR1bwZzHA@mail.gmail.com> <4F5D3679.3090900@hauke-m.de> <CAGRGNgWsO9s2rW1pKBFWd_-0oTAGs9_RXNGyn_y7ic=0Zer=qQ@mail.gmail.com> <20120312174113.GC2778@tuxdriver.com> <4F5E395F.9020603@openwrt.org>
In-Reply-To: <4F5E395F.9020603@openwrt.org>
X-Enigmail-Version: 1.3.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/12/2012 06:58 PM, Florian Fainelli wrote:
> 
> 
> Le 03/12/12 18:41, John W. Linville a écrit :
>> On Mon, Mar 12, 2012 at 12:30:54PM +1100, Julian Calaby wrote:
>>> Hi Hauke,
>>>
>>> On Mon, Mar 12, 2012 at 10:34, Hauke Mehrtens<hauke@hauke-m.de>  wrote:
>>
>>>> I will fix this, should I resend the hole series or just this patch?
>>>
>>> I'm not sure the rest of the series made it to linux-wireless, so
>>> maybe you should resend everything.
>>
>> FWIW, this was the only one I saw...
> 
> For some reasons I received it from linux-mips-bounces using another
> email account, but only patch 3 CC'd linux-wireless.

Sorry for the confusion.
I didn't send all patches to linux-wireless as the others are just
touching usb and mips. The next round will go completely to linux-wireless.

Hauke
