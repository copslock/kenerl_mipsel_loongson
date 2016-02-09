Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:03:39 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:46996 "EHLO
        mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010545AbcBIIDgva275 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:03:36 +0100
Received: from exchange2010.bmw-carit.intra ([192.168.100.28]:14684 helo=mail.bmw-carit.de)
        by mail.bmw-carit.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Daniel.Wagner@bmw-carit.de>)
        id 1aT3Go-0008Sy-0i; Tue, 09 Feb 2016 09:03:34 +0100
Received: from handman.bmw-carit.intra (192.168.101.8) by
 Exchange2010.bmw-carit.intra (192.168.100.28) with Microsoft SMTP Server
 (TLS) id 14.3.123.3; Tue, 9 Feb 2016 09:03:33 +0100
X-CTCH-RefID: str=0001.0A0C0205.56B99D56.00E6,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Subject: Re: [PATCH v3 3/3] mips: Differentiate between 32 and 64 bit ELF
 header
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <201602090033.mukhdG4N%fengguang.wu@intel.com>
CC:     kbuild test robot <lkp@intel.com>, <kbuild-all@01.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
X-Enigmail-Draft-Status: N1110
Message-ID: <56B99D55.2020301@bmw-carit.de>
Date:   Tue, 9 Feb 2016 09:03:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <201602090033.mukhdG4N%fengguang.wu@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.wagner@bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.wagner@bmw-carit.de
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

Hi Maciej,

On 02/08/2016 05:22 PM, kbuild test robot wrote:
> Hi Daniel,
> 
> [auto build test ERROR on v4.5-rc3]
> [also build test ERROR on next-20160208]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Daniel-Wagner/Differentiate-between-32-and-64-bit-ELF-header/20160208-234759
> config: mips-fuloong2e_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    arch/mips/kernel/../../../fs/binfmt_elf.c: In function 'load_elf_interp':
>>> arch/mips/kernel/binfmt_elfn32.c:38:7: error: implicit declaration of function 'mips_elf_check_machine' [-Werror=implicit-function-declaration]
>      if (!mips_elf_check_machine(__h))    \
>           ^
>>> arch/mips/kernel/../../../fs/binfmt_elf.c:536:7: note: in expansion of macro 'elf_check_arch'
>      if (!elf_check_arch(interp_elf_ex))
>           ^
>    cc1: some warnings being treated as errors
> --
>    arch/mips/kernel/../../../fs/binfmt_elf.c: In function 'load_elf_interp':

Hmm how I was able to build binfmt_elfo32.o because it should suffer
from the same problem.

I think reusing mips_elf_check_machine() in binfmt_elf?32.c is only
going to work if we include arch/mips/include/asm/elf.h. Though this
looks kind of wrong.

Should I add a mips_elf_check_machine() to binfmt_elf?32.c as well or
just leave them as they are at this point?

cheers,
daniel
