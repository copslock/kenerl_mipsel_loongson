Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2017 10:42:21 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:57800 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992241AbdKTJmOP4qmR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Nov 2017 10:42:14 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 20 Nov 2017 09:41:41 +0000
Received: from [192.168.159.117] (192.168.159.117) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 20 Nov
 2017 01:41:28 -0800
Subject: Re: Fwd: stable-rc/linux-4.4.y build: 182 builds: 60 failed, 122
 passed, 60 errors, 60 warnings (v4.4.99-60-g803704b287d8)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
References: <5a11b2d4.17f71c0a.5dc3f.fef5@mx.google.com>
 <CAK8P3a2QcYoFHFrR+DPFs1Oo6Li1NO=VMxoAyoh=yWF24j4YMg@mail.gmail.com>
 <CAK8P3a1TCQR1gDRL_Ns5tTJyj8x_NJupM74i8rKpUZ0hRa1mcQ@mail.gmail.com>
From:   Marcin Nowakowski <marcin.nowakowski@mips.com>
Message-ID: <8a278610-716d-321e-a403-6c8e74b05c82@mips.com>
Date:   Mon, 20 Nov 2017 10:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1TCQR1gDRL_Ns5tTJyj8x_NJupM74i8rKpUZ0hRa1mcQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.117]
X-BESS-ID: 1511170894-298552-458-83668-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187128
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Marcin.Nowakowski@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@mips.com
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

Hi Arnd, Greg,

On 19.11.2017 21:55, Arnd Bergmann wrote:
> [Adding the others to cc]
> 
> ---------- Forwarded message ----------
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Sun, Nov 19, 2017 at 9:53 PM
> Subject: Re: stable-rc/linux-4.4.y build: 182 builds: 60 failed, 122
> passed, 60 errors, 60 warnings (v4.4.99-60-g803704b287d8)
> To: "kernelci.org bot" <bot@kernelci.org>, gregkh <gregkh@linuxfoundation.org>
> Cc: Tom Gall <tom.gall@linaro.org>, Sumit Semwal
> <sumit.semwal@linaro.org>, Amit Pundir <amit.pundir@linaro.org>, Arnd
> Bergmann <arnd.bergmann@linaro.org>, Anmar Oueja
> <anmar.oueja@linaro.org>
> 
> 
> On Sun, Nov 19, 2017 at 5:35 PM, kernelci.org bot <bot@kernelci.org> wrote:
>> stable-rc/linux-4.4.y build: 182 builds: 60 failed, 122 passed, 60 errors, 60 warnings (v4.4.99-60-g803704b287d8)
>>
>> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y/kernel/v4.4.99-60-g803704b287d8/
>>
>> Tree: stable-rc
>> Branch: linux-4.4.y
>> Git Describe: v4.4.99-60-g803704b287d8
>> Git Commit: 803704b287d89efcd70fade9e650176282a1d766
>> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>> Built: 4 unique architectures
>>
>> Build Failures Detected:
>>
>> mips:    gcc version 6.3.0 (GCC)
>>
>>      allnoconfig: FAIL
>>      ar7_defconfig: FAIL
>>      ath79_defconfig: FAIL
>>      bcm47xx_defconfig: FAIL
>> ...
>>
>> Errors summary:
>>
>>       60  arch/mips/kernel/setup.c:439:8: error: implicit declaration of function 'PHYS_PFN' [-Werror=implicit-function-declaration]
> 
> All mips builds failed with this error, apparently caused by the
> backport of d9b5b658210f2 ("MIPS: init: Ensure bootmem does not
> corrupt reserved memory").
> 

The following change:
8f235d1a3eb71 ('mm: add PHYS_PFN, use it in __phys_to_pfn()')
needs to be backported prior to d9b5b658210f2 to add the missing macro 
definition.

thanks,
Marcin
