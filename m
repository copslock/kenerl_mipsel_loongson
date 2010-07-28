Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jul 2010 21:26:27 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:35915 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492566Ab0G1T0S convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jul 2010 21:26:18 +0200
Received: by gwb10 with SMTP id 10so1310729gwb.36
        for <multiple recipients>; Wed, 28 Jul 2010 12:26:12 -0700 (PDT)
Received: by 10.151.40.7 with SMTP id s7mr11418235ybj.405.1280345172065; Wed, 
        28 Jul 2010 12:26:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.84.4 with HTTP; Wed, 28 Jul 2010 12:25:52 -0700 (PDT)
In-Reply-To: <4C5082BE.5050203@caviumnetworks.com>
References: <20100727214948.GA29241@dediao-lnx2.corp.sa.net> 
        <AANLkTi=a=tGURpMKo7g+32LMcFovx4GJk2Wid6vmvQt8@mail.gmail.com> 
        <4C5082BE.5050203@caviumnetworks.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Wed, 28 Jul 2010 13:25:52 -0600
X-Google-Sender-Auth: kRark68JbHDOMlfH3_5UkDGiP0s
Message-ID: <AANLkTi=74zoQziQTmAGo-cNtF9FAT77h+KZagsNEFjEf@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MIPS: Add device tree support to MIPS
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Dezhong Diao <dediao@cisco.com>,
        devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, dvomlehn@cisco.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Wed, Jul 28, 2010 at 1:19 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 07/28/2010 11:54 AM, Grant Likely wrote:
>>
>> Hi Dezhong,
>
> [...]
>>
>> Very nice clean patch, thanks!  How/when would you like to see MIPS OF
>> support go into mainline?
>>
>
> I can't speak for the patch authors, but my preference would be to have MIPS
> OF support go in to 2.6.36 if possible.
>
> How? To me it doesn't matter.  I would let you and Ralf fight it out.

It would probably be best if I at least pick up the first patch into
my test tree to give it a spin with the latest changes.  I'd be happy
to take the 2nd too to avoid ordering issues.

Cheers,
g.
