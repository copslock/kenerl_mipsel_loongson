Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 21:56:30 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36733 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013112AbcBVU43NdpAe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 21:56:29 +0100
Received: by mail-pa0-f49.google.com with SMTP id yy13so96864421pab.3
        for <linux-mips@linux-mips.org>; Mon, 22 Feb 2016 12:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=D5tdfQNgtVY/yvTaGvZ0cSt+EM9rHBP1RV4DqKYSBho=;
        b=ZHyjPZ2gmRXjWlcamQwb4RWcY7GFrtm4DooIyVbT1WrLxrU+/bjazR0UJkYlnZbOES
         1slLPL7BvWumSPl623OBGQm9qDjefVmwd+a2tUDlfd+kvRoZfkS7X39jXFMO0rAJVDWC
         zjFNCh9OekOFnSpFyruj5t+/x441JOURSlW9u5HQqaBDmTy3nJzUiPMP/BSJdbDIAx01
         XeDvAhl5NooBn71t1pekZqrhCZ/FI/r+aFUUqR4EcyikIYj1bYGbNSOz3WXvNIh852Y3
         iB5Mr4qPR1WnkIeg3ZFGncIyayubR6hle1gDrqWHzpM2x8SDGq4xu9trEBTLNhb5vHIJ
         laXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=D5tdfQNgtVY/yvTaGvZ0cSt+EM9rHBP1RV4DqKYSBho=;
        b=ISm2DmNDU+LIfksXyBGB4zSrQlY5hsvIoEyJUfu3DfFByZKOV5H9DNBwjSdYZ+feCw
         L5cQI9HhB3SB1iUy9mur067SxFa9kDaddjva/PHlp7ubMqpKiZruMVJBSe1uSD9+enT6
         rmXJWuza/axhHM7lEfTL3l+jM6tlN9Gbm6xm+36sGsK2T1xVHWtXofWL1tWQcFt261H4
         1N20Sd2KEJX2V2pyeB1dWJQeTiI8mX0exePMPSfF/CMpY1ryLqoNniGlbB7kT6VkPwwK
         rlM8/XoBuKh/o5GcpToqfnqqVu4LXeayoIrcqRCoRALoVAVJP0CHum3/BHR6ds/4Wvw0
         inlg==
X-Gm-Message-State: AG10YOR/QIz9i+/4A1dLOcKeKsxwm9AA/wcxHc27mnUk8oFMywcHngrZH33seWHwKV+0sw==
X-Received: by 10.67.6.72 with SMTP id cs8mr40757347pad.138.1456174583117;
        Mon, 22 Feb 2016 12:56:23 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id t87sm38960000pfa.14.2016.02.22.12.56.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Feb 2016 12:56:21 -0800 (PST)
Message-ID: <56CB75F4.9080201@gmail.com>
Date:   Mon, 22 Feb 2016 12:56:20 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Yang Shi <yang.shi@windriver.com>
CC:     Aaro Koskinen <aaro.koskinen@nokia.com>, david.daney@cavium.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: 4.5-rc4 kernel is failed to bootup on CN6880
References: <56C7BD89.2040800@windriver.com> <20160222124303.GR22974@ak-desktop.emea.nsn-net.net> <56CB5E63.1080005@windriver.com>
In-Reply-To: <56CB5E63.1080005@windriver.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 02/22/2016 11:15 AM, Yang Shi wrote:
> On 2/22/2016 4:43 AM, Aaro Koskinen wrote:
>> Hi,
>>
>> On Fri, Feb 19, 2016 at 05:12:41PM -0800, Yang Shi wrote:
>>> I tried to boot 4.5-rc4 kernel on my CN6880 board, but it is failed at
>>> booting up secondary cores. The error is:
>> With v4.5-rc5, EBB6800 is booting fine:
>>
>> [    0.000000] CPU0 revision is: 000d9108 (Cavium Octeon II)
>> [...]
>> [ 2286.273935] SMP: Booting CPU01 (CoreId  1)...
>> [ 2286.278201] CPU1 revision is: 000d9108 (Cavium Octeon II)
>> [...]
>> [ 2287.214953] SMP: Booting CPU31 (CoreId 31)...
>> [ 2287.224668] CPU31 revision is: 000d9108 (Cavium Octeon II)
>> [ 2287.224865] Brought up 32 CPUs
>>
>>> CPU31 revision is: 000d9101 (Cavium Octeon II)
>>> SMP: Booting CPU32 (CoreId 32)...
>>> Secondary boot timeout
>>>
>>> I passed "numcores=32" in kernel commandline since there are 32 cores
>>> ion
>>> CN6880.
>> You shouldn't have CPU32 in that case, the numbering starts from zero.
>> Also the coremask is 32-bit.
>>
>> I can reproduce your issue with CONFIG_NR_CPUS=64. Possibly this code
>> is incorrect for NR_CPUS bigger than 32:
>>
>>          /* The present CPUs get the lowest CPU numbers. */
>>          cpus = 1;
>>          for (id = 0; id < NR_CPUS; id++) {
>>                  if ((id != coreid) && (core_mask & (1 << id))) {
>>                          set_cpu_possible(cpus, true);
>>                          set_cpu_present(cpus, true);
>>
>> What CONFIG_NR_CPUS did you use?
>
> Thanks. I did have 48 NR_CPUS set. It works when I changed it to 32.
>
> I think the problem is core_mask is 32 bit. But when NR_CPUS > 32, in
> "core_mask & (1 << id)" core_mask will be sign extended, then the
> statement will return non-zero all the time.
>

That is correct, and perhaps not coincidentally, the reason I have 
already submitted patches to fix this.

David.


> Yang
>
>>
>> A.
>>
>
>
