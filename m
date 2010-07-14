Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2010 21:26:09 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.9]:55908 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492002Ab0GNT0G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Jul 2010 21:26:06 +0200
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 5887A1C15B20;
        Wed, 14 Jul 2010 21:26:00 +0200 (CEST)
X-Auth-Info: TWxwPfzDJLHCV84CA4oRT87ghk40FukjnNutfGZXCxw=
Received: from lancy.mylan.de (p4FE641EC.dip.t-dialin.net [79.230.65.236])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 18D4B1C001B5;
        Wed, 14 Jul 2010 21:26:00 +0200 (CEST)
Message-ID: <4C3E0F52.9090201@grandegger.com>
Date:   Wed, 14 Jul 2010 21:26:10 +0200
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     linux-mips@linux-mips.org, Wolfgang Grandegger <wg@denx.de>
Subject: Re: [PATCH v2] mips/alchemy: add basic support for the GPR board
References: <1279115243-11586-1-git-send-email-wg@grandegger.com> <AANLkTilwt8Eh9on0tjXecINx28ix1Bky8GiS-E4QdyIJ@mail.gmail.com>
In-Reply-To: <AANLkTilwt8Eh9on0tjXecINx28ix1Bky8GiS-E4QdyIJ@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

On 07/14/2010 04:51 PM, Manuel Lauss wrote:
> On Wed, Jul 14, 2010 at 3:47 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> diff --git a/arch/mips/alchemy/gpr/board_setup.c b/arch/mips/alchemy/gpr/board_setup.c
>> new file mode 100644
>> index 0000000..4e68d76
>> --- /dev/null
>> +++ b/arch/mips/alchemy/gpr/board_setup.c
> 
>> +static int __init gpr_init_irq(void)
>> +{
>> +       return 0;
>> +}
>> +arch_initcall(gpr_init_irq);
> 
> Seems superfluous.  Do you intend to add something here in the future?

Well, as PCMCIA is not supported on that board, it's actually not
needed. I will remove and it for v3.

Wolfgang.
