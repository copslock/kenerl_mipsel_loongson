Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 18:19:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23581 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012134AbcBHRT22Z8DP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 18:19:28 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 85BD0BE8BF33B;
        Mon,  8 Feb 2016 17:19:17 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Mon, 8 Feb 2016
 17:19:20 +0000
Date:   Mon, 8 Feb 2016 17:19:14 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Daniel Wagner <daniel.wagner@bmw-carit.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3 1/3] mips: Use arch specific auxvec.h instead of
 generic-asm version
In-Reply-To: <1454946278-13859-2-git-send-email-daniel.wagner@bmw-carit.de>
Message-ID: <alpine.DEB.2.00.1602081705470.15885@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1602061624460.15885@tp.orcam.me.uk> <1454946278-13859-1-git-send-email-daniel.wagner@bmw-carit.de> <1454946278-13859-2-git-send-email-daniel.wagner@bmw-carit.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Mon, 8 Feb 2016, Daniel Wagner wrote:

> The generic auxvec.h is used instead the arch specific version.
> This happens when cross compiling the kernel.
> 
> mips64-linux-gnu-gcc (GCC) 5.2.1 20151104 (Red Hat Cross 5.2.1-4)
> 
> arch/mips/kernel/../../../fs/binfmt_elf.c: In function ‘create_elf_tables’:
> ./arch/mips/include/asm/elf.h:425:14: error: ‘AT_SYSINFO_EHDR’ undeclared (first use in this function)

 There must be something wrong with your setup, or maybe a bug somewhere 
in our build machinery you just happened to trigger.  Most of us routinely 
use a cross-compiler to build the kernel and you're the first one to 
report the problem.

 Can you report the compiler invocation that has lead to this error?  
Have you used a default config or a custom one?

> diff --git a/arch/mips/include/asm/auxvec.h b/arch/mips/include/asm/auxvec.h
> new file mode 100644
> index 0000000..fbd388c
> --- /dev/null
> +++ b/arch/mips/include/asm/auxvec.h
> @@ -0,0 +1 @@
> +#include <uapi/asm/auxvec.h>

 You're not supposed to require a header in asm/ merely to include a 
header of the same name from uapi/asm/ as there are normally 
-I./arch/mips/include and -I./arch/mips/include/uapi options present both 
at once, in this order, on the compiler's invocation line.  So:

#include <asm/auxvec.h>

will pull the header from uapi/asm/ if none is present in asm/.

  Maciej
