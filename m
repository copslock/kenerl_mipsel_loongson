Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2010 15:28:38 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:60051 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491962Ab0GHN2e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jul 2010 15:28:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id A32205B1;
        Thu,  8 Jul 2010 15:28:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 413-mdlEhrjU; Thu,  8 Jul 2010 15:28:28 +0200 (CEST)
Received: from [172.31.16.228] (d078161.adsl.hansenet.de [80.171.78.161])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id EB05C5B0;
        Thu,  8 Jul 2010 15:28:22 +0200 (CEST)
Message-ID: <4C35D264.7080809@metafoo.de>
Date:   Thu, 08 Jul 2010 15:28:04 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 16/26] fbdev: Add JZ4740 framebuffer driver
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>        <1276924111-11158-17-git-send-email-lars@metafoo.de>        <4C310ACD.6040604@metafoo.de> <20100707164148.d2a1f8c4.akpm@linux-foundation.org>
In-Reply-To: <20100707164148.d2a1f8c4.akpm@linux-foundation.org>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
> On Mon, 05 Jul 2010 00:27:25 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> Hi Andrew
>>
>> v2 of this patch has been around for two weeks without any comments. I've fixed all
>> the issues you had with v1. If you this version is ok, an Acked-By would be nice :)
> 
> I don't do acks - I already have enough to be blamed for.
Hm, ok.

> Although I might whine about inappropriate use of
> ENOENT, which means "No such file or directory".
> 

That is due to to many bad examples, I guess. Would using ENXIO instead keep you from
whining?

- Lars
