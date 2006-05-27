Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 May 2006 17:59:14 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:37065 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133729AbWE0P7C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 May 2006 17:59:02 +0200
Received: (qmail 14449 invoked from network); 27 May 2006 20:06:58 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 27 May 2006 20:06:58 -0000
Message-ID: <4478770B.9080301@ru.mvista.com>
Date:	Sat, 27 May 2006 19:58:03 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: [MIPS] Fix swap entry for MIPS32 36-bit physical address
References: <S8133863AbWEZXEn/20060526230443Z+689@ftp.linux-mips.org>
In-Reply-To: <S8133863AbWEZXEn/20060526230443Z+689@ftp.linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

linux-mips@linux-mips.org wrote:
> Author: Sergei Shtylyov <sshtylyov@ru.mvista.com> Wed Apr 5 00:24:40 2006 +0400
> Comitter: Ralf Baechle <ralf@linux-mips.org> Sat May 27 00:01:23 2006 +0100
> Commit: f826429f5ad38f40b96ff587cd44def138f99f3a
> Gitweb: http://www.linux-mips.org/g/linux/f826429f
> Branch: master
> 
> With 64-bit physical address enabled, 'swapon' was causing kernel oops
> on Alchemy CPUs (MIPS32R1) because of the swap entry type field
> corrupting the _PAGE_FILE bit in pte_low. So, change layout of the
> swap entry to use all bits except _PAGE_PRESENT and _PAGE_FILE (the
> hardware protection bits are loaded from pte_high which should be
> cleared by __swp_entry_to_pte() macro) -- which gives 25 bits for the
> swap entry offset.  Additionally, PTEs in MIPS32R2 should have the same
> layout for 64-bit physical address case as in MIPS32R1, according to
> the architecture manuals -- so, fix the #ifdef's.
> 
> Signed-off-by: Konstantin Baydarov <kbaidarov@ru.mvista.com>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 
>  include/asm-mips/pgtable-32.h   |   22 +++++++++++++++++++---
>  include/asm-mips/pgtable-bits.h |    2 +-
>  2 files changed, 20 insertions(+), 4 deletions(-)

    Alas, Ralf have finally managed to commit the wrong patch -- both outdated 
and error-prone because it reuses _PAGE_GLOBAL which is bad for set_pte() and 
pte_clear() and probably for the CPU itself since it ANDs G-bit of both the 
even and odd PTEs to decide whether to compare ASID or not when doing TLB 
lookups. I wonder whether this commit can be undone (it's still the most 
recent one) or should I compose an incremental patch?

WBR, Sergei
