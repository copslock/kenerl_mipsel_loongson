Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 23:35:44 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:36051 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904068Ab1KQWfi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Nov 2011 23:35:38 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 7EA1423C00CA;
        Thu, 17 Nov 2011 23:35:36 +0100 (CET)
Message-ID: <4EC58C38.2060409@openwrt.org>
Date:   Thu, 17 Nov 2011 23:35:36 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Imre Kaloz <kaloz@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] MIPS: ath79: remove 'ar913x' from common variable
 and function names
References: <1321568027-32066-1-git-send-email-juhosg@openwrt.org> <1321568027-32066-3-git-send-email-juhosg@openwrt.org> <20111117223200.GB2758@linux-mips.org>
In-Reply-To: <20111117223200.GB2758@linux-mips.org>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 31756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14902

2011.11.17. 23:32 keltezéssel, Ralf Baechle írta:
> On Thu, Nov 17, 2011 at 11:13:43PM +0100, Gabor Juhos wrote:
> 
>> diff --git a/arch/mips/ath79/dev-ar913x-wmac.h b/arch/mips/ath79/dev-ar913x-wmac.h
>> index 579d562..de1d784 100644
>> --- a/arch/mips/ath79/dev-ar913x-wmac.h
>> +++ b/arch/mips/ath79/dev-ar913x-wmac.h
>> @@ -9,9 +9,9 @@
>>   *  by the Free Software Foundation.
>>   */
>>  
>> -#ifndef _ATH79_DEV_AR913X_WMAC_H
>> -#define _ATH79_DEV_AR913X_WMAC_H
>> +#ifndef _ATH79_DEV_WMAC_H
>> +#define _ATH79_DEV_WMAC_H
> 
> In this case, don't you want to rename this header file as well?

I want to rename that, but I did not want to mix up the actual modifications
with a file rename.

Gabor
