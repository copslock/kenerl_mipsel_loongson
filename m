Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 14:02:21 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:44915 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6818020Ab3IRMCPuNsGL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 14:02:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B69698F61;
        Wed, 18 Sep 2013 14:02:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nLwD1U0MK62L; Wed, 18 Sep 2013 14:02:11 +0200 (CEST)
Received: from [IPv6:2001:470:1f0b:447:4ca:e75d:fb06:9711] (unknown [IPv6:2001:470:1f0b:447:4ca:e75d:fb06:9711])
        by hauke-m.de (Postfix) with ESMTPSA id 30DB2857F;
        Wed, 18 Sep 2013 14:02:11 +0200 (CEST)
Message-ID: <52399641.4090901@hauke-m.de>
Date:   Wed, 18 Sep 2013 14:02:09 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: BCM47XX: add board detection
References: <1379503798-9014-1-git-send-email-hauke@hauke-m.de> <CAMuHMdU8V=96fEb9Vrpb2+TEWiD5L2Gh+3xzY9SBDotP2NaQ=g@mail.gmail.com>
In-Reply-To: <CAMuHMdU8V=96fEb9Vrpb2+TEWiD5L2Gh+3xzY9SBDotP2NaQ=g@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37851
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

On 09/18/2013 01:41 PM, Geert Uytterhoeven wrote:
> On Wed, Sep 18, 2013 at 1:29 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> Detect on which board this code is running based on some nvram
>> settings. This is needed to start board specific workarounds and
>> configure the leds and buttons which are on different gpios on every board.
>>
>> This patches add some boards we have seen, but there are many more.
> 
> Can you please make the board database __initconst, and only retain in memory
> a copy of the detected board info?
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
I will change this in a next version of this patch.

Hauke
