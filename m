Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jul 2010 21:19:38 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7291 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492756Ab0G1TTe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jul 2010 21:19:34 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c5082e00000>; Wed, 28 Jul 2010 12:20:00 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 28 Jul 2010 12:19:32 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 28 Jul 2010 12:19:32 -0700
Message-ID: <4C5082BE.5050203@caviumnetworks.com>
Date:   Wed, 28 Jul 2010 12:19:26 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     Dezhong Diao <dediao@cisco.com>,
        devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, dvomlehn@cisco.com
Subject: Re: [PATCH v2 1/2] MIPS: Add device tree support to MIPS
References: <20100727214948.GA29241@dediao-lnx2.corp.sa.net> <AANLkTi=a=tGURpMKo7g+32LMcFovx4GJk2Wid6vmvQt8@mail.gmail.com>
In-Reply-To: <AANLkTi=a=tGURpMKo7g+32LMcFovx4GJk2Wid6vmvQt8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jul 2010 19:19:32.0080 (UTC) FILETIME=[CE8AEF00:01CB2E89]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 07/28/2010 11:54 AM, Grant Likely wrote:
> Hi Dezhong,
[...]
>
> Very nice clean patch, thanks!  How/when would you like to see MIPS OF
> support go into mainline?
>

I can't speak for the patch authors, but my preference would be to have 
MIPS OF support go in to 2.6.36 if possible.

How? To me it doesn't matter.  I would let you and Ralf fight it out.

Thanks,
David Daney
