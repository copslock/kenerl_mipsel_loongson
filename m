Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 07:18:03 +0200 (CEST)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:54474 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006825AbbFAFSAt6xa4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2015 07:18:00 +0200
Received: from resomta-ch2-04v.sys.comcast.net ([69.252.207.100])
        by resqmta-ch2-10v.sys.comcast.net with comcast
        id atHs1q0022AWL2D01tHsv1; Mon, 01 Jun 2015 05:17:52 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-04v.sys.comcast.net with comcast
        id atHr1q00642s2jH01tHrpM; Mon, 01 Jun 2015 05:17:52 +0000
Message-ID: <556BEAFE.9030400@gentoo.org>
Date:   Mon, 01 Jun 2015 01:17:50 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: CONFIG_64BIT && CONFIG_MIPS_HUGE_TLB_SUPPORT build broken
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433135872;
        bh=a2TpBB3Vo3WZW28zNxSN4I991xZzdH9PM1tHP6SLaaQ=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=p4nrZWOymlmhuikMVhZ3X+9fiyPs9BAH65dbFyeL7Usa53cQ8j4sRmTN9dxZEex1s
         OTgN89Fi9r2Nue8/BOtgDQtm7uGlQXOvNN2b0oAJ0YbikH1RO5o31DjSj5Ndjgm0qa
         yCknPJ5ZFiIoe9lzgVX2LYzhJn0EJW/F2/UjnCvIpCOnE6ADX1Y/HBs9KYX+5eNmro
         5AC4rz9im67PmVy3nhO4F+fNPYzfM5EtJXlMU3yFX8qOCri3wz2xZGGVYTdCxEuC5v
         3jhXp1SIyXSDtyjNRY6GeEvJlmAlTteXfuuHnCpqEe125kmxSmhs3G14ZglX+ok27f
         VjmolwFWHyGXA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

Looks like this particular build configuration has problems:

  CC      arch/mips/kernel/cpu-probe.o
In file included from ./arch/mips/include/asm/io.h:27:0,
                 from include/linux/io.h:22,
                 from ./arch/mips/include/asm/mips-cm.h:14,
                 from ./arch/mips/include/asm/smp-ops.h:16,
                 from ./arch/mips/include/asm/smp.h:21,
                 from include/linux/smp.h:59,
                 from ./arch/mips/include/asm/cpu-type.h:12,
                 from ./arch/mips/include/asm/timex.h:19,
                 from include/linux/timex.h:65,
                 from include/linux/sched.h:19,
                 from include/linux/ptrace.h:5,
                 from arch/mips/kernel/cpu-probe.c:16:
./arch/mips/include/asm/pgtable-bits.h:164:0: error: "_PAGE_GLOBAL_SHIFT"
redefined [-Werror]
 #define _PAGE_GLOBAL_SHIFT (_PAGE_MODIFIED_SHIFT + 1)
 ^
./arch/mips/include/asm/pgtable-bits.h:141:0: note: this is the location of the
previous definition
 #define _PAGE_GLOBAL_SHIFT (_PAGE_SPLITTING_SHIFT + 1)
 ^
cc1: all warnings being treated as errors
scripts/Makefile.build:258: recipe for target 'arch/mips/kernel/cpu-probe.o' failed
make[2]: *** [arch/mips/kernel/cpu-probe.o] Error 1
scripts/Makefile.build:403: recipe for target 'arch/mips/kernel' failed
make[1]: *** [arch/mips/kernel] Error 2
Makefile:946: recipe for target 'arch/mips' failed
make: *** [arch/mips] Error 2


Caused by these two blocks:

   #if defined(CONFIG_64BIT) && defined(CONFIG_MIPS_HUGE_TLB_SUPPORT)
   /* Huge TLB page */
   #define _PAGE_HUGE_SHIFT        (_PAGE_MODIFIED_SHIFT + 1)
   #define _PAGE_HUGE              (1 << _PAGE_HUGE_SHIFT)
   #define _PAGE_SPLITTING_SHIFT   (_PAGE_HUGE_SHIFT + 1)
   #define _PAGE_SPLITTING         (1 << _PAGE_SPLITTING_SHIFT)

   /* Only R2 or newer cores have the XI bit */
   #ifdef CONFIG_CPU_MIPSR2
   #define _PAGE_NO_EXEC_SHIFT     (_PAGE_SPLITTING_SHIFT + 1)
   #else
-> #define _PAGE_GLOBAL_SHIFT      (_PAGE_SPLITTING_SHIFT + 1)
   #define _PAGE_GLOBAL            (1 << _PAGE_GLOBAL_SHIFT)
   #endif  /* CONFIG_CPU_MIPSR2 */

   #endif  /* CONFIG_64BIT && CONFIG_MIPS_HUGE_TLB_SUPPORT */

And ...

   #ifdef CONFIG_CPU_MIPSR2
   /* XI - page cannot be executed */
   #ifndef _PAGE_NO_EXEC_SHIFT
   #define _PAGE_NO_EXEC_SHIFT     (_PAGE_MODIFIED_SHIFT + 1)
   #endif
   #define _PAGE_NO_EXEC           (cpu_has_rixi ? (1 << _PAGE_NO_EXEC_SHIFT) : 0)

   /* RI - page cannot be read */
   #define _PAGE_READ_SHIFT        (_PAGE_NO_EXEC_SHIFT + 1)
   #define _PAGE_READ              (cpu_has_rixi ? 0 : (1 << _PAGE_READ_SHIFT))
   #define _PAGE_NO_READ_SHIFT     _PAGE_READ_SHIFT
   #define _PAGE_NO_READ           (cpu_has_rixi ? (1 << _PAGE_READ_SHIFT) : 0)

   #define _PAGE_GLOBAL_SHIFT      (_PAGE_NO_READ_SHIFT + 1)
   #define _PAGE_GLOBAL            (1 << _PAGE_GLOBAL_SHIFT)

   #else   /* !CONFIG_CPU_MIPSR2 */
-> #define _PAGE_GLOBAL_SHIFT      (_PAGE_MODIFIED_SHIFT + 1)
   #define _PAGE_GLOBAL            (1 << _PAGE_GLOBAL_SHIFT)
   #endif  /* CONFIG_CPU_MIPSR2 */


Since this is dealing with R2 stuff, not sure what the best fix is.  Looks like
this is the problem commit:

http://git.linux-mips.org/cgit/ralf/linux.git/commit/arch/mips/include/asm/pgtable-bits.h?id=be0c37c985eddc46d0d67543898c086f60460e2e


--J
