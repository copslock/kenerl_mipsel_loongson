Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2012 20:28:56 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:36218 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903594Ab2BST2x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2012 20:28:53 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 8E73B8F61;
        Sun, 19 Feb 2012 20:28:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CeLvxo6oyga3; Sun, 19 Feb 2012 20:28:38 +0100 (CET)
Received: from [192.168.1.220] (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id A44DF8F60;
        Sun, 19 Feb 2012 20:28:37 +0100 (CET)
Message-ID: <4F414D63.1070409@hauke-m.de>
Date:   Sun, 19 Feb 2012 20:28:35 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     =?ISO-8859-1?Q?Michael_B=FCsch?= <m@bues.ch>
CC:     linville@tuxdriver.com, zajec5@gmail.com,
        b43-dev@lists.infradead.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, arend@broadcom.com
Subject: Re: [PATCH 04/11] ssb: add ccode
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de> <1329676345-15856-5-git-send-email-hauke@hauke-m.de> <20120219194923.566f3fe8@milhouse>
In-Reply-To: <20120219194923.566f3fe8@milhouse>
X-Enigmail-Version: 1.3.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 32484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/19/2012 07:49 PM, Michael Büsch wrote:
> On Sun, 19 Feb 2012 19:32:18 +0100
> Hauke Mehrtens <hauke@hauke-m.de> wrote:
> 
>> This member contains the country code encoded with two chars
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  include/linux/ssb/ssb.h |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
>> index 4928419..44e486e 100644
>> --- a/include/linux/ssb/ssb.h
>> +++ b/include/linux/ssb/ssb.h
>> @@ -33,6 +33,7 @@ struct ssb_sprom {
>>  	u8 et1mdcport;		/* MDIO for enet1 */
>>  	u16 board_rev;		/* Board revision number from SPROM. */
>>  	u8 country_code;	/* Country Code */
>> +	char ccode[2];		/* Country Code as two chars like EU or US */
> 
> This usually is referred to as "alpha2". So we should name it like that, too.
I can not find any references to "alpha2" in the spec, the broadcom
code, ssb, bcma or b43. ccode was the name broadcom gave this value so I
took it.
http://bcm-v4.sipsolutions.net/SPROM wrongly maps ccode to country_code,
but cc is stored into country_code in ssb.

Hauke
