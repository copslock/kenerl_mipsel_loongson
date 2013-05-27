Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 19:17:44 +0200 (CEST)
Received: from mail-la0-f48.google.com ([209.85.215.48]:35828 "EHLO
        mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827529Ab3E0RRlfKoBb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 May 2013 19:17:41 +0200
Received: by mail-la0-f48.google.com with SMTP id fs12so6561857lab.7
        for <linux-mips@linux-mips.org>; Mon, 27 May 2013 10:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=A/UCqS+MLW3tfrb4MPQnoA3ND56V/BVmsn6D/J5oY0w=;
        b=KjD5fRbJ8RVuHPbJM4Lhp10e2tOyNlgZ11vbGM4ZUhHjCVdOabGmNrxFpE0k6sjwl7
         yrt2nuIVz1xmDaVS0ZB7CMd5kOkFRC08yXNxfw/4NQmzWwehQUQe5ELfE+lM6qt89EqO
         4VEnSHaF6K9XtrBqvrkJK90nlTggunyuGndKxrWnWCt5pRK9jnOuftCaKbHqG8Shb7ww
         YN+O1bfLLfwo4sNDFSHCSHpk2qDo0MlriAj4z7DO+QaUtgP3/XwqLc9JSEFRCcqEYYE9
         +nEQBVWf9hWAY9L5y8HY+9TNln9iEUxWQKxpQgLGiLsX5C18qjHgjbgeUV84P5ixThXD
         wKFg==
X-Received: by 10.112.5.7 with SMTP id o7mr14705210lbo.64.1369675055646;
        Mon, 27 May 2013 10:17:35 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-145-214.pppoe.mtu-net.ru. [91.76.145.214])
        by mx.google.com with ESMTPSA id g10sm12319756lag.10.2013.05.27.10.17.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 10:17:34 -0700 (PDT)
Message-ID: <51A3952C.3060006@cogentembedded.com>
Date:   Mon, 27 May 2013 21:17:32 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: cavium-octeon: cvmx-helper-board: print unknown
 board warning only once
References: <1369600543-21558-1-git-send-email-aaro.koskinen@iki.fi> <51A33317.2060202@cogentembedded.com>
In-Reply-To: <51A33317.2060202@cogentembedded.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkVh2u0u+dbcxLCq0mgqJlr8ww47yoLVrxLOkZXriPj3lUIvRKFbsj9zo31u+7yb20Dc+/9
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 27-05-2013 14:19, Sergei Shtylyov wrote:

>> When booting a new board for the first time, the console is flooded with
>> "Unknown board" messages. This is not really helpful. Board type is not
>> going to change after the boot, so it's sufficient to print the warning
>> only once.

>> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> ---
>>   arch/mips/cavium-octeon/executive/cvmx-helper-board.c |    5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)

>> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
>> b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
>> index 7c64977..e0451a0 100644
>> --- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
>> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> [...]
>> @@ -184,8 +186,7 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
>>       }
>>
>>       /* Some unknown board. Somebody forgot to update this
>> function... */
>> -    cvmx_dprintf
>> -        ("cvmx_helper_board_get_mii_address: Unknown board type %d\n",
>> +    pr_warn_once("%s: Unknown board type %d\n", __func__,
>>            cvmx_sysinfo_get()->board_type);

>     Please align this line under the next char under (.

     s/under (/after (/, of course.

WBR, Sergei
