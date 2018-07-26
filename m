Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2018 19:02:29 +0200 (CEST)
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55737 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992479AbeGZRC0WwAyD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jul 2018 19:02:26 +0200
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3D88460011;
        Thu, 26 Jul 2018 17:01:58 +0000 (UTC)
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
To:     Helge Deller <deller@gmx.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, benh@kernel.crashing.org,
        paulus@samba.org, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <87d0vehx16.fsf@concordia.ellerman.id.au>
 <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
 <20180726125940.GA15033@ls3530>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <de188e2f-99ab-53fa-20df-4fec00a935e9@ghiti.fr>
Date:   Thu, 26 Jul 2018 17:01:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180726125940.GA15033@ls3530>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@ghiti.fr
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

Hi Helge,

Thanks for your tests.
In case it can help you, this is what I get when I try to build 
generic-64bit_defconfig (I truncated the output):

...

 �LD����� vmlinux.o
 �MODPOST vmlinux.o
hppa64-linux-ld: init/main.o(.text+0x98): cannot reach strreplace
init/main.o: In function `initcall_blacklisted':
init/.tmp_main.o:(.text+0x98): relocation truncated to fit: 
R_PARISC_PCREL22F against symbol `strreplace' defined in .text section 
in lib/string.o
hppa64-linux-ld: init/main.o(.text+0xbc): cannot reach strcmp
init/.tmp_main.o:(.text+0xbc): relocation truncated to fit: 
R_PARISC_PCREL22F against symbol `strcmp' defined in .text section in 
lib/string.o
hppa64-linux-ld: init/main.o(.text+0x21c): cannot reach strcpy
init/main.o: In function `do_one_initcall':
(.text+0x21c): relocation truncated to fit: R_PARISC_PCREL22F against 
symbol `strcpy' defined in .text section in lib/string.o
hppa64-linux-ld: init/main.o(.text+0x250): cannot reach strlcat
(.text+0x250): relocation truncated to fit: R_PARISC_PCREL22F against 
symbol `strlcat' defined in .text section in lib/string.o
hppa64-linux-ld: init/main.o(.init.text+0x1d4): cannot reach strcmp
init/main.o: In function `do_early_param':
init/.tmp_main.o:(.init.text+0x1d4): relocation truncated to fit: 
R_PARISC_PCREL22F against symbol `strcmp' defined in .text section in 
lib/string.o
hppa64-linux-ld: init/main.o(.init.text+0x250): cannot reach strcmp
init/.tmp_main.o:(.init.text+0x250): relocation truncated to fit: 
R_PARISC_PCREL22F against symbol `strcmp' defined in .text section in 
lib/string.o
hppa64-linux-ld: init/main.o(.init.text+0x294): cannot reach strlen
init/main.o: In function `repair_env_string':
init/.tmp_main.o:(.init.text+0x294): relocation truncated to fit: 
R_PARISC_PCREL22F against symbol `strlen' defined in .text section in 
lib/string.o
hppa64-linux-ld: init/main.o(.init.text+0x2f0): cannot reach strlen
init/.tmp_main.o:(.init.text+0x2f0): relocation truncated to fit: 
R_PARISC_PCREL22F against symbol `strlen' defined in .text section in 
lib/string.o
hppa64-linux-ld: init/main.o(.init.text+0x308): cannot reach memmove
init/.tmp_main.o:(.init.text+0x308): relocation truncated to fit: 
R_PARISC_PCREL22F against symbol `memmove' defined in .text section in 
lib/string.o
hppa64-linux-ld: init/main.o(.init.text+0x454): cannot reach strlen
init/main.o: In function `unknown_bootoption':
init/.tmp_main.o:(.init.text+0x454): relocation truncated to fit: 
R_PARISC_PCREL22F against symbol `strlen' defined in .text section in 
lib/string.o
hppa64-linux-ld: init/main.o(.init.text+0x4dc): cannot reach strchr
init/.tmp_main.o:(.init.text+0x4dc): additional relocation overflows 
omitted from the output
hppa64-linux-ld: init/main.o(.init.text+0x638): cannot reach strncmp
hppa64-linux-ld: init/main.o(.init.text+0x694): cannot reach get_option
hppa64-linux-ld: init/main.o(.init.text+0x744): cannot reach strsep
hppa64-linux-ld: init/main.o(.init.text+0x798): cannot reach strlen
hppa64-linux-ld: init/main.o(.init.text+0x7d0): cannot reach strcpy
hppa64-linux-ld: init/main.o(.init.text+0x954): cannot reach strlcpy
hppa64-linux-ld: init/main.o(.init.text+0xab8): cannot reach strlen
hppa64-linux-ld: init/main.o(.init.text+0xafc): cannot reach strlen
hppa64-linux-ld: init/main.o(.init.text+0xb40): cannot reach strlen
hppa64-linux-ld: init/main.o(.init.text+0xb84): cannot reach strlen
hppa64-linux-ld: init/main.o(.init.text+0xbd0): cannot reach strcpy
hppa64-linux-ld: init/main.o(.init.text+0xbe8): cannot reach strcpy
hppa64-linux-ld: init/main.o(.init.text+0xc3c): cannot reach 
build_all_zonelists
hppa64-linux-ld: init/main.o(.init.text+0x1200): cannot reach unknown
hppa64-linux-ld: init/main.o(.init.text+0x1278): cannot reach 
wait_for_completion
hppa64-linux-ld: init/main.o(.init.text+0x12b0): cannot reach _raw_spin_lock
hppa64-linux-ld: init/main.o(.init.text+0x147c): cannot reach strcpy
hppa64-linux-ld: init/main.o(.ref.text+0x40): cannot reach kernel_thread
hppa64-linux-ld: init/main.o(.ref.text+0x60): cannot reach 
find_task_by_pid_ns
hppa64-linux-ld: init/main.o(.ref.text+0x98): cannot reach 
set_cpus_allowed_ptr
hppa64-linux-ld: init/main.o(.ref.text+0xbc): cannot reach kernel_thread
hppa64-linux-ld: init/main.o(.ref.text+0xd4): cannot reach 
find_task_by_pid_ns
hppa64-linux-ld: init/main.o(.ref.text+0x108): cannot reach complete
hppa64-linux-ld: init/main.o(.ref.text+0x128): cannot reach 
cpu_startup_entry
hppa64-linux-ld: init/main.o(.ref.text+0x164): cannot reach unknown
hppa64-linux-ld: init/main.o(.ref.text+0x174): cannot reach 
async_synchronize_full
hppa64-linux-ld: init/main.o(.ref.text+0x1a4): cannot reach 
rcu_barrier_sched
hppa64-linux-ld: init/main.o(.ref.text+0x1b4): cannot reach mark_rodata_ro
hppa64-linux-ld: init/main.o(.ref.text+0x1d4): cannot reach 
rcu_end_inkernel_boot
hppa64-linux-ld: init/main.o(.ref.text+0x1f4): cannot reach unknown
hppa64-linux-ld: init/main.o(.ref.text+0x218): cannot reach printk
hppa64-linux-ld: init/main.o(.ref.text+0x238): cannot reach unknown
hppa64-linux-ld: init/main.o(.ref.text+0x258): cannot reach panic
hppa64-linux-ld: init/main.o(.ref.text+0x268): cannot reach printk
hppa64-linux-ld: init/main.o(.ref.text+0x280): cannot reach unknown
hppa64-linux-ld: init/main.o(.ref.text+0x29c): cannot reach unknown
hppa64-linux-ld: init/main.o(.ref.text+0x2b8): cannot reach unknown
hppa64-linux-ld: init/main.o(.ref.text+0x2d4): cannot reach unknown
hppa64-linux-ld: init/main.o(.ref.text+0x2f0): cannot reach panic
hppa64-linux-ld: init/do_mounts.o(.text+0x30): cannot reach strncasecmp
hppa64-linux-ld: init/do_mounts.o(.text+0x158): cannot reach strncmp
hppa64-linux-ld: init/do_mounts.o(.text+0x180): cannot reach strchr

...


On 07/26/2018 12:59 PM, Helge Deller wrote:
> * Alex Ghiti <alex@ghiti.fr>:
>> This is the result of the build for all arches tackled in this series
>> rebased on 4.18-rc6:
>> ...
>> parisc:
>>  ������� generic-64bit_defconfig: with huge page does not link
>>  ������� generic-64bit_defconfig: without huge page does not link
>>  ������� BUT not because of this series, any feedback welcome.
> Strange, but I will check that later....
>
> Anyway, I applied your v4-patch to my parisc64 tree, built the kernel,
> started it and ran some hugetlb LTP testcases sucessfully.
> So, please add:
>
> Tested-by: Helge Deller <deller@gmx.de> # parisc
>
> Helge
