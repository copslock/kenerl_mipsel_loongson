Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2012 20:17:46 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:36171 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903594Ab2BSTRm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2012 20:17:42 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id B783F8F61;
        Sun, 19 Feb 2012 20:17:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZQWsLhITrtj8; Sun, 19 Feb 2012 20:17:28 +0100 (CET)
Received: from [192.168.1.220] (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 3005F8F60;
        Sun, 19 Feb 2012 20:17:28 +0100 (CET)
Message-ID: <4F414AC6.90709@hauke-m.de>
Date:   Sun, 19 Feb 2012 20:17:26 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     Larry Finger <Larry.Finger@lwfinger.net>
CC:     linville@tuxdriver.com, zajec5@gmail.com,
        b43-dev@lists.infradead.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, arend@broadcom.com, m@bues.ch
Subject: Re: [PATCH 02/11] ssb: remove 5GHz antenna gain from sprom
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de> <1329676345-15856-3-git-send-email-hauke@hauke-m.de> <4F4149FC.50900@lwfinger.net>
In-Reply-To: <4F4149FC.50900@lwfinger.net>
X-Enigmail-Version: 1.3.5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-archive-position: 32483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/19/2012 08:14 PM, Larry Finger wrote:
> On 02/19/2012 12:32 PM, Hauke Mehrtens wrote:
>> There is no 2.4 GHz or 5GHz antenna gain stored in sprom. The sprom
>> just stores the gain values for antenna 1 and 2 or 1 to 4 for more
>> recent sprom versions. On old devices antenna 2 was used for 5 GHz wifi.
>>
>> Signed-off-by: Hauke Mehrtens<hauke@hauke-m.de>
>> ---
>>   drivers/net/wireless/b43legacy/phy.c |    2 +-
>>   drivers/ssb/pci.c                    |   40
>> ++++++++++++----------------------
>>   drivers/ssb/pcmcia.c                 |   12 +++------
>>   drivers/ssb/sdio.c                   |   12 +++------
>>   include/linux/ssb/ssb.h              |    7 +-----
>>   5 files changed, 24 insertions(+), 49 deletions(-)
> 
> After this patch, I get the warning
> 
> drivers/ssb/pci.c: In function ‘sprom_extract_r123’:
> drivers/ssb/pci.c:334:5: warning: unused variable ‘gain’
> [-Wunused-variable]
> 
> I am still testing, but all other patches compile OK.

Thanks for the info, I haven't see it. I will fix it in the next round.

Hauke
