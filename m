Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 23:40:00 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:49156 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014168AbcC3Vj47gCkw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Mar 2016 23:39:56 +0200
Received: from [192.168.178.24] (pD9F60AA0.dip0.t-ipconnect.de [217.246.10.160])
        by hauke-m.de (Postfix) with ESMTPSA id 0C0A110029B;
        Wed, 30 Mar 2016 23:39:56 +0200 (CEST)
Subject: Re: [PATCH v2] MIPS: vdso: flush the vdso data page to update it on
 all processes
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
References: <1456074518-13163-1-git-send-email-hauke@hauke-m.de>
 <56FAF575.4070607@hauke-m.de> <56FBEEFF.10406@imgtec.com>
Cc:     alex.smith@imgtec.com, sergei.shtylyov@cogentembedded.com,
        "# v4 . 4+" <stable@vger.kernel.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <56FC472B.1040801@hauke-m.de>
Date:   Wed, 30 Mar 2016 23:37:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.6.0
MIME-Version: 1.0
In-Reply-To: <56FBEEFF.10406@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 03/30/2016 05:21 PM, Zubair Lutfullah Kakakhel wrote:
> Hi Hauke,
> 
> Could you share details of what version of glibc/rfs setup you are using?

Hi,

I am using the musl libc version 1.1.4 in OpenWrt. musl uses the same
vdso code on arm and x86, it just needed some extensions to support the
-ENOSYS return value which is not returned by the other architectures.

I removed the following patches from OpenWrt to activate vdso
gettimeofday in kernel 4.4 again:
target/linux/generic/patches-4.4/206-mips-disable-vdso.patch
target/linux/generic/patches-4.4/340-MIPS-deactivate-gettimeofday-vdso.patch

> 
> Thanks.
> 
> Regards,
> ZubairLK
> 
> On 29/03/16 22:36, Hauke Mehrtens wrote:
>> On 02/21/2016 06:08 PM, Hauke Mehrtens wrote:
>>> Without flushing the vdso data page the vdso call is working on dated
>>> or unsynced data. This resulted in problems where the clock_gettime
>>> vdso call returned a time 6 seconds later after a 3 seconds sleep,
>>> while the syscall reported a time 3 sounds later, like expected. This
>>> happened very often and I got these ping results for example:
>>>
>>> root@OpenWrt:/# ping 192.168.1.255
>>> PING 192.168.1.255 (192.168.1.255): 56 data bytes
>>> 64 bytes from 192.168.1.3: seq=0 ttl=64 time=0.688 ms
>>> 64 bytes from 192.168.1.3: seq=1 ttl=64 time=4294172.045 ms
>>> 64 bytes from 192.168.1.3: seq=2 ttl=64 time=4293968.105 ms
>>> 64 bytes from 192.168.1.3: seq=3 ttl=64 time=4294055.920 ms
>>> 64 bytes from 192.168.1.3: seq=4 ttl=64 time=4294671.913 ms
>>>
>>> This was tested on a Lantiq/Intel VRX288 (MIPS BE 34Kc V5.6 CPU with
>>> two VPEs)
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> Cc: <stable@vger.kernel.org> # v4.4+
>>
>> This patch flushes the complete dcache of the CPU if cpu_has_dc_aliases
>> is set.
>>
>> Calling flush_dcache_page(virt_to_page(&vdso_data)); improved the
>> situation a litte bit but did not fix my problem.
>>
>> Could someone from Imagination please look into this problem. The page
>> is linked into many virtual address spaces and when it gets modified by
>> the kernel the user space processes are still accessing partly old data,
>> even when lush_dcache_page() was called.
>>
>>> ---
>>>   arch/mips/kernel/vdso.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
>>> index 975e997..8b0d974 100644
>>> --- a/arch/mips/kernel/vdso.c
>>> +++ b/arch/mips/kernel/vdso.c
>>> @@ -20,6 +20,8 @@
>>>   #include <linux/timekeeper_internal.h>
>>>
>>>   #include <asm/abi.h>
>>> +#include <asm/cacheflush.h>
>>> +#include <asm/page.h>
>>>   #include <asm/vdso.h>
>>>
>>>   /* Kernel-provided data used by the VDSO. */
>>> @@ -85,6 +87,8 @@ void update_vsyscall(struct timekeeper *tk)
>>>       }
>>>
>>>       vdso_data_write_end(&vdso_data);
>>> +    flush_cache_vmap((unsigned long)&vdso_data,
>>> +             (unsigned long)&vdso_data + sizeof(vdso_data));
>>>   }
>>>
>>>   void update_vsyscall_tz(void)
>>> @@ -93,6 +97,8 @@ void update_vsyscall_tz(void)
>>>           vdso_data.tz_minuteswest = sys_tz.tz_minuteswest;
>>>           vdso_data.tz_dsttime = sys_tz.tz_dsttime;
>>>       }
>>> +    flush_cache_vmap((unsigned long)&vdso_data,
>>> +             (unsigned long)&vdso_data + sizeof(vdso_data));
>>>   }
>>>
>>>   int arch_setup_additional_pages(struct linux_binprm *bprm, int
>>> uses_interp)
>>>
>>
>>
