Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2017 15:03:39 +0100 (CET)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:44442
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992157AbdKTODah1EJL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Nov 2017 15:03:30 +0100
Received: by mail-pf0-x244.google.com with SMTP id r14so849910pfl.11;
        Mon, 20 Nov 2017 06:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t2KKpeoLDmlsm62v2AUbbVFcp69nzRlOBhJ3SJDQQbk=;
        b=sOm93t44redo2rPmtI79E7HmZL+VV0H9OQW1AHA7NwqvV+22Gmo5SsLWOFlrrBwc8S
         6ahCwgxWuh9mXLQN2cNYTrIC7R93wNBY2pzMOeMhkEiTE+x+CuEEW49MtTyuo7Q/3abU
         wY+DCbrExMXlzI58Ovits9Y7gwT5scYRkJa6aZlRVky2v4FXNgyqXQ/7nJ78sbgYwNE8
         Y2ycZ5LIK2WFs/+kNDpAYQYRfA+UrLiA2xiFE90gARuzIaO479rnUM4f2TCHY9jCvtXu
         bJ9tHBrQDZGk+6k49B3J5KVLssCsrA9v6FerI4aTtpcrJ7OFP2dJZKPnDmbant/qsBcu
         vPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t2KKpeoLDmlsm62v2AUbbVFcp69nzRlOBhJ3SJDQQbk=;
        b=k0t+jarWxOP2V60pDzDjo+5UEBFpC9Zu9T+I/e81uflS/mAFhSVTBicTQEqDHNa9mj
         Cm0yDVNsbb6y5qyZ2Y4QELdqik4KkfqDGZkHEKy2eSdnTm2tDos38HaHKh0o+GbXDrY/
         G4VP3p6KjobJOmOl441uzrmffK8bmT9vuEaFJdZEb74Iu+msKfoE4OYnzYHxSnC42QKL
         Gl5tVnS68ewrAYUcbG1Ekdo3SqH5GOUpap//2s517z5Fw/5KAfo8u1DGbMZkKAb32Zih
         eISNV2NdTczLGP/gCfJyG/paA2SuOjLbJvu04AD/1mp7G4CnqMEiEW4XbLILQwYT26uW
         rvYw==
X-Gm-Message-State: AJaThX7qgK+4+2dmphhaFgFlKS/3QIEErTDcmjv3wrkXK/4e50QB4A6P
        wcFKJcgbux2b/M3sZ8pfrUw=
X-Google-Smtp-Source: AGs4zMb4msvW3rmxfGKCO12yJWX7S4pvQ/k6S+uIpl6hdNQzuzLro6XjepZZgfSd7zZ5hmbEAxEsFQ==
X-Received: by 10.99.53.72 with SMTP id c69mr13565088pga.225.1511186603925;
        Mon, 20 Nov 2017 06:03:23 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 73sm23178831pfr.145.2017.11.20.06.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 06:03:22 -0800 (PST)
Subject: Re: [22/26] MIPS: generic: Introduce generic DT-based board support
To:     James Hogan <james.hogan@mips.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
References: <20160826153725.11629-23-paul.burton@imgtec.com>
 <20171119034325.GA17384@roeck-us.net>
 <20171120102507.GD27409@jhogan-linux.mipstec.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5e88e3d4-3c4b-b5eb-0b32-d0c0902e14c2@roeck-us.net>
Date:   Mon, 20 Nov 2017 06:03:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171120102507.GD27409@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 11/20/2017 02:25 AM, James Hogan wrote:
> On Sat, Nov 18, 2017 at 07:43:25PM -0800, Guenter Roeck wrote:
>> On Fri, Aug 26, 2016 at 04:37:21PM +0100, Paul Burton wrote:
>>> Introduce a "generic" platform, which aims to be board-agnostic by
>>> making use of device trees passed by the boot protocol defined in the
>>> MIPS UHI (Universal Hosting Interface) specification. Provision is made
>>> for supporting boards which use a legacy boot protocol that can't be
>>> changed, but adding support for such boards or any others is left to
>>> followon patches.
>>>
>>> Right now the built kernels expect to be loaded to 0x80100000, ie. in
>>> kseg0. This is fine for the vast majority of MIPS platforms, but
>>> nevertheless it would be good to remove this limitation in the future by
>>> mapping the kernel via the TLB such that it can be loaded anywhere & map
>>> itself appropriately.
>>>
>>> Configuration is handled by dynamically generating configs using
>>> scripts/kconfig/merge_config.sh, somewhat similar to the way powerpc
>>> makes use of it. This allows for variations upon the configuration, eg.
>>> differing architecture revisions or subsets of driver support for
>>> differing boards, to be handled without having a large number of
>>> defconfig files.
>>>
>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>
>> Guess it is known that this patch causes failures when building
>> "allmodconfig" on test systems such as 0day; it was reported by 0day
>> some two months ago. nevertheless, the patch found its way into mainline
>> without fix. Does anyone care, or should I simply disable "allmodconfig"
>> test builds for mips ?
> 
> Hi Guenter,
> 
> I can't find any emails from 0day in relation to this patch (I've also
> dug about on the kbuild-all archives without success). Could you link to
> or quote the build failure you're referring to.
> 
> Thanks
> James
> 

It was much older than two months, actually.

https://lkml.org/lkml/2016/12/15/33

Guenter
