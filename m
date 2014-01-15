Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 22:25:33 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:59949 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825884AbaAOVZaYGhUZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jan 2014 22:25:30 +0100
Received: by mail-pb0-f49.google.com with SMTP id up15so1173803pbc.22
        for <multiple recipients>; Wed, 15 Jan 2014 13:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZUrAjJ9eta9JjWY3Et+9Jgnw4EcYyBkHFDERw4smChc=;
        b=z6vWdpjjLYcR71lISssOsp5R0ZhmSPym/yleAVcp1MCtIb5doij9u7GKzHfiriWWOV
         rdY0q5C6rfIdAWGukCdrSu4idaK/RkDl/uq03eJIfyGZB61cYOBRedNVr0X8spyZisZ/
         6MkdKaf2INlC97RkRGl4Wwt5eB8OBks7h+UiUhomilEGQXP27Kpg9Y7gY5jaTqKjXRER
         5xGRiu+87rRpa23wSXdAiv7VeDRq7+W1tNGYvfnDrmMMNJ4qaG70/bBO+ju8CSZRNtj/
         tKO7eEUqMdHxkHC29bmXCW6R3GLOamnLXeAif8RsG0c97PZvpYugetRNAyfJL7jq7j/v
         3ccg==
X-Received: by 10.68.17.7 with SMTP id k7mr5300343pbd.119.1389821123330; Wed,
 15 Jan 2014 13:25:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.186.101 with HTTP; Wed, 15 Jan 2014 13:24:42 -0800 (PST)
In-Reply-To: <CAGVrzcYQaY=0ciN-__sU34idRaiU71Sca190HTtcRkrO7-0mzg@mail.gmail.com>
References: <1389812784-30085-1-git-send-email-florian@openwrt.org>
 <52D6DD74.60308@caviumnetworks.com> <CAGVrzcYQaY=0ciN-__sU34idRaiU71Sca190HTtcRkrO7-0mzg@mail.gmail.com>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Wed, 15 Jan 2014 13:24:42 -0800
X-Google-Sender-Auth: 85MUzy0s3JD6TKm1JV8p3IybE18
Message-ID: <CAGVrzcat0d-76HsYn9JKq97-Q-7dg_U_K+Ym=uU-_RfwBRYXbQ@mail.gmail.com>
Subject: Re: [PATCH mips-for-linux-next] MIPS: check for -mfix-cn63xxp1
 compiler option
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        "david.daney" <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2014/1/15 Florian Fainelli <florian@openwrt.org>:
> 2014/1/15 David Daney <ddaney@caviumnetworks.com>:
>> On 01/15/2014 11:06 AM, Florian Fainelli wrote:
>>>
>>> Attempting to build for Cavium Octeon with an unpatched or old
>>> toolchain will fail due to the -mfix-cn63xxp1 option being unrecognized.
>>> Call cc-option on this option to make sure we can safely use it.
>>>
>>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
>>
>>
>> NACK.
>>
>> If the chip you are building for needs -Wa,-mfix-cn63xxp1, then building
>> without this option yields a system the generates random errors.  So I would
>> argue that if -Wa,-mfix-cn63xxp1 is not supported by your assembler,
>> breaking the build is the proper thing to do.
>
> Fair enough. Maybe the condition should be refined to be based off
> CONFIG_CAVIUM_CN63XXP1?

Which is already the case... sorry for the noise.
-- 
Florian
