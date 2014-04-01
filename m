Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2014 15:03:53 +0200 (CEST)
Received: from mail-vc0-f182.google.com ([209.85.220.182]:63856 "EHLO
        mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822151AbaDANDsje0Sq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2014 15:03:48 +0200
Received: by mail-vc0-f182.google.com with SMTP id ks9so9881674vcb.13
        for <multiple recipients>; Tue, 01 Apr 2014 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7kotVtZpUSfX+4YUtCcFBgeHewZrwi2JufgpoWQ5/h0=;
        b=jIXvdu1YyQpFd7GbsqaXbjLQDTUe9qhGh53aJHZxsHulwM3rg8jDk+KC3AsHvR2UVO
         gsS5mY8O48gtwwbsB9JX691SzCDvDlTqowiA1qlMqIFkVO6KvblXsrtB2a5etIGIzUW0
         BcGVx1GWiJLtX08iQC0HeHj0kYCm8P81xBBzG5y+H5yskgdnhxIf4WiRoKRTo9yZoULI
         /K5X9Je9zDL4rSu3M/DtclOeGYikbESgRBIVvJojU3o0+1nMu8CJvf2gf9gctuv3Ffgc
         V3lryIuur7EkmBXolj0mKOh8iaQ307Cq1lYWIxLGRszLB8k2hW5UAU0iPMy4V1cPJTnO
         yJrQ==
MIME-Version: 1.0
X-Received: by 10.52.119.178 with SMTP id kv18mr718919vdb.39.1396357422083;
 Tue, 01 Apr 2014 06:03:42 -0700 (PDT)
Received: by 10.220.203.68 with HTTP; Tue, 1 Apr 2014 06:03:42 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1404010108270.27402@eddie.linux-mips.org>
References: <52863D5E.7080606@linux.com>
        <alpine.LFD.2.11.1404010108270.27402@eddie.linux-mips.org>
Date:   Tue, 1 Apr 2014 15:03:42 +0200
X-Google-Sender-Auth: 3aSvAo7JLW5mnkCxFkQKMDTksU0
Message-ID: <CAAsK9AH51aXUjfTUYMFbssRwZk6_J8BPktgJn9ZKZtX_r3FufQ@mail.gmail.com>
Subject: Re: [PATCH] tc: account for device_register() failure
From:   Levente Kurusa <levex@linux.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ilevex.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: levex@linux.com
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

Hi,

2014-04-01 2:30 GMT+02:00 Maciej W. Rozycki <macro@linux-mips.org>:
> On Fri, 15 Nov 2013, Levente Kurusa wrote:
>
>> This patch makes the TURBOchannel driver bail out if the call
>> to device_register() failed.
>>
>> Signed-off-by: Levente Kurusa <levex@linux.com>
>
> Acked-by: Maciej W. Rozycki <macro@linux-mips.org>
>
> This fixes some build warnings:
>
> drivers/tc/tc.c: In function 'tc_bus_add_devices':
> drivers/tc/tc.c:132: warning: ignoring return value of 'device_register',
> declared with attribute warn_unused_result
> drivers/tc/tc.c: In function 'tc_init':
> drivers/tc/tc.c:151: warning: ignoring return value of 'device_register',
> declared with attribute warn_unused_result
>
> Levente, thanks for your fix and apologies for the long RTT -- can you
> please resend your patch to <linux-mips@linux-mips.org> and Ralf so that
> it'll be pulled via the MIPS tree?  I'll post a follow-up update to fix
> some issues with `tc_init' that I noticed thanks to your change.

Sure, I will repost in a few hours, I just need to get home.
Thanks for the Ack!

> [...]

--
Regards,
Levente Kurusa
