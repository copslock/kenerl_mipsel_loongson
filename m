Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Sep 2010 08:27:34 +0200 (CEST)
Received: from dalsmrelay2.nai.com ([205.227.136.216]:31070 "HELO
        dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1491093Ab0IMG11 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Sep 2010 08:27:27 +0200
Received: from (unknown [10.64.5.51]) by dalsmrelay2.nai.com with smtp
         id 7a50_17dc_f1442bae_beff_11df_acd8_00219b929abd;
        Mon, 13 Sep 2010 06:27:15 +0000
Received: from dalexbr1.corp.nai.org (161.69.111.81) by DALEXHT1.corp.nai.org
 (10.64.5.51) with Microsoft SMTP Server id 8.2.254.0; Mon, 13 Sep 2010
 01:26:31 -0500
Received: from sncexbr1.corp.nai.org ([161.69.5.246]) by dalexbr1.corp.nai.org
 with Microsoft SMTPSVC(6.0.3790.3959);  Mon, 13 Sep 2010 01:26:30 -0500
Received: from STPSMTP01.scur.com ([10.96.96.163]) by sncexbr1.corp.nai.org
 with Microsoft SMTPSVC(6.0.3790.3959);  Sun, 12 Sep 2010 23:26:28 -0700
Received: from cyberguard.com.au ([10.46.129.16]) by STPSMTP01.scur.com with
 Microsoft SMTPSVC(6.0.3790.4675);       Mon, 13 Sep 2010 01:26:28 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])    by
 bne.snapgear.com (Postfix) with ESMTP id 9ADCAEBACC;   Mon, 13 Sep 2010
 16:26:26 +1000 (EST)
X-Virus-Scanned: amavisd-new at snapgear.com
Received: from bne.snapgear.com ([127.0.0.1])   by localhost (bne.snapgear.com
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 9PTK4kC2wECb; Mon, 13
 Sep 2010 16:26:18 +1000 (EST)
Received: from [172.22.196.222] (bnelabfw.scur.com [10.46.129.16])      by
 bne.snapgear.com (Postfix) with ESMTP; Mon, 13 Sep 2010 16:26:18 +1000 (EST)
Message-ID: <4C8DC3CF.6030909@snapgear.com>
Date:   Mon, 13 Sep 2010 16:25:19 +1000
From:   Greg Ungerer <gerg@snapgear.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: fix start of free memory when using initrd
References: <201009080550.o885ohjD014188@goober.internal.moreton.com.au> <4C891863.1080602@caviumnetworks.com> <4C89CBDA.1030309@snapgear.com> <4C8A5B6C.5080405@caviumnetworks.com>
In-Reply-To: <4C8A5B6C.5080405@caviumnetworks.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2010 06:26:28.0353 (UTC) FILETIME=[991A1F10:01CB530C]
X-archive-position: 27749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@snapgear.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9655

David Daney wrote:
> On 09/09/2010 11:10 PM, Greg Ungerer wrote:
>>
>> Hi David,
>>
>> David Daney wrote:
> [...]
>>> We have the attached patch (plus a few more hacks), I don't think it
>>> is universally safe to change the calculation of reserved_end.
>>> Although the patch has some code formatting problems you might
>>> consider using it as a starting point.>
>> I don't use the Cavium u-boot boot loader on this. (And don't use any
>> of the named blocks, or other data struct passing from the boot loader
>> to the kernel). So the patch is not really useful for me.
>>
>> But I am interested, why do you think it is not safe to change
>> reserved_end?
> 
> For Octeon it is probably safe, but there is a reason that this complex 
> logic for restricting the usable memory ranges exists.  Other targets 
> require it, so great care must be taken not to break the non-octeon 
> targets.
> 
>>
>> There is the possible overlap of the kernels bootmem setup data
>> that is not checked (which sparc does for example). But otherwise
>> what problems do you see here?
>>
> 
> I lack the imagination necessary to come up with a failing scenario, but 
> I am also paranoid, so I see danger everywhere.

Good answer :-)

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
