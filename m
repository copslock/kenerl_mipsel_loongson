Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 10:32:41 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34459 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903545Ab1KRJch (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Nov 2011 10:32:37 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 7C58A23C0084;
        Fri, 18 Nov 2011 10:32:35 +0100 (CET)
Message-ID: <4EC62636.6040208@openwrt.org>
Date:   Fri, 18 Nov 2011 10:32:38 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, Imre Kaloz <kaloz@openwrt.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] MIPS: ath79: remove 'ar913x' from common variable
 and function names
References: <1321568027-32066-1-git-send-email-juhosg@openwrt.org> <1321568027-32066-3-git-send-email-juhosg@openwrt.org> <4EC62138.7010703@mvista.com>
In-Reply-To: <4EC62138.7010703@mvista.com>
X-Enigmail-Version: 1.3.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 31784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15232

Hi Sergei,

2011.11.18. 10:11 keltezéssel, Sergei Shtylyov írta:
> Hello.
> 
> On 18-11-2011 2:13, Gabor Juhos wrote:
> 
>> The wireless MAC specific variables and the registration
>> code can be shared between multiple SoCs. Remove the 'ar913x'
>> part from the function and variable names to avoid confusions.
> 
>> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
>> ---
>>   arch/mips/ath79/dev-ar913x-wmac.c |   20 ++++++++++----------
>>   arch/mips/ath79/dev-ar913x-wmac.h |    8 ++++----
> 
>    Don't you need to rename these files if they're no longer AR913x specific?

These files has been renamed by a later patch.

-Gabor
