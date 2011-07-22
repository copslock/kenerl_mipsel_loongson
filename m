Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 17:04:54 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:44134 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491177Ab1GVPEr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jul 2011 17:04:47 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 8AFF58C90;
        Fri, 22 Jul 2011 17:04:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JPTzZmx-pvwc; Fri, 22 Jul 2011 17:04:43 +0200 (CEST)
Received: from [192.168.0.152] (dyndsl-095-033-240-157.ewe-ip-backbone.de [95.33.240.157])
        by hauke-m.de (Postfix) with ESMTPSA id 297618C88;
        Fri, 22 Jul 2011 17:04:42 +0200 (CEST)
Message-ID: <4E299189.7080700@hauke-m.de>
Date:   Fri, 22 Jul 2011 17:04:41 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "John W. Linville" <linville@tuxdriver.com>
CC:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, jonas.gorski@gmail.com, mb@bu3sch.de,
        george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Subject: Re: [PATCH v2 00/11] bcma: add support for embedded devices like
 bcm4716
References: <1310835342-18877-1-git-send-email-hauke@hauke-m.de> <CACna6ryjYGuLc5c88eke=gjgwQyVD+A9afM6zCRhqV1THHgWvA@mail.gmail.com> <4E2933A0.40200@hauke-m.de> <20110722133925.GA10938@tuxdriver.com>
In-Reply-To: <20110722133925.GA10938@tuxdriver.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 30676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16103

On 07/22/2011 03:39 PM, John W. Linville wrote:
> On Fri, Jul 22, 2011 at 10:24:00AM +0200, Hauke Mehrtens wrote:
>> On 07/22/2011 12:30 AM, Rafał Miłecki wrote:
>>> 2011/7/16 Hauke Mehrtens <hauke@hauke-m.de>:
> 
>>>> @Ralf: Could you please merger this into the mips tree so that it will be in linux-3.1.
>>>
>>> ML for bcma is linux-wireless. Should we pass that patches "via" Ralf
>>> or John? Using linux-wireless (and John's tree) makes more sense to
>>> me, as we will work on the same tree and will get less merge
>>> conflicts. However don't take me as Linux development style guru, just
>>> my POV.
> 
>> I talked about this with Florian Fainelli and he said that the patches
>> should rather pass Ralf then John, but merging would be easier when they
>> are passing John. I do not have a problem with both solutions and
>> rebasing it to an other tree is no problem for me.
>> John and Ralf, who wants to take these patches? ;-)
> 
> I don't really care -- I figured Ralf was taking them due to the MIPS arch bits.
> 
> John

Hi John,

yes because of the MIPS arch bits it should go through Ralf, but there
are many changes for bcma in wireless-testing and adding my changes to
mips tree will cause some problems when wireless-testing and mips are
merged together by Linus.

Hauke
