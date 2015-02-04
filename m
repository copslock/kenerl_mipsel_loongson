Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 15:00:05 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:54495 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011669AbbBDOACn2xwA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 15:00:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=aSyQrwy6XJLDH00cGCshoVgyaaQddcQ2MCWlIkfudvY=;
        b=pqxUZCU0zRHsLj2VT0qWZTu/J82Sdd+ZiOusbKkXq/tILjt3RcMZracTrNm5WwtcGiriWZIX5VBxDa4wmohep0P1nIHY2zOli4AGyoiwNPq3BVd54yTRVbaBSqVSsorLhmmWnEYxOQN26omto9Ft/EmkTmMxL2vebsBSt++hPB4=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YJ0Ul-002nKW-Ha
        for linux-mips@linux-mips.org; Wed, 04 Feb 2015 13:59:55 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59721 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YJ0Uj-002nJF-3m; Wed, 04 Feb 2015 13:59:53 +0000
Message-ID: <54D225D6.6040603@roeck-us.net>
Date:   Wed, 04 Feb 2015 05:59:50 -0800
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Paul Bolle <pebolle@tiscali.nl>, John Crispin <blogic@openwrt.org>
CC:     Wim Van Sebroeck <wim@iguana.be>,
        Ralf Baechle <ralf@linux-mips.org>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: watchdog: SOC_MT7621?
References: <1423044809.23894.65.camel@x220> <54D1F248.4090406@openwrt.org>      <1423047893.23022.13.camel@x220> <54D1FE0F.3030308@openwrt.org> <1423052553.30076.6.camel@tiscali.nl>
In-Reply-To: <1423052553.30076.6.camel@tiscali.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020201.54D225DB.01E2,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 2
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 02/04/2015 04:22 AM, Paul Bolle wrote:
> John Crispin schreef op wo 04-02-2015 om 12:10 [+0100]:
>> i think wim should just drop it and we leave it in openwrt with the
>> other 1/2 million patches that we have. i prefer to upstream the stuff
>> without feeling pressured to hurry up, that kills the fun.
>
> Once code is mainlined you'll get fixes written for you, updates done
> for you, etc. But you'll also get pointed at defects that require you to
> fix them yourself, or see the code removed eventually.
>
>> @Wim, can you drop the patch please ?
>
> Why should Wim drop more than the
>      || SOC_MT7621
>
> snippet?
>

Question is if the driver works with MT7620 as advertised. Either case
it would be odd if the driver advertises itself as MT7621 but only works
for MT7620, so I think it should be dropped entirely for now.

Wim, should I possibly ask Stephen to include my watchdog-next branch
in his -next builds ? This would help us catching such problems earlier.

Thanks,
Guenter
