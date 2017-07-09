Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2017 02:08:53 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:52864 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993423AbdGIAIoSS1YR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 9 Jul 2017 02:08:44 +0200
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2017 17:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,331,1496127600"; 
   d="gz'50?scan'50,208,50";a="106237432"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 08 Jul 2017 17:08:31 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1dTzpS-000PmS-8w; Sun, 09 Jul 2017 08:12:02 +0800
Date:   Sun, 9 Jul 2017 08:07:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     kbuild-all@01.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        linux-kernel@vger.kernel.org, Aaron Tomlin <atomlin@redhat.com>,
        "Jason A. Donenfeld" <jason@zx2c4.com>
Subject: Re: [PATCH] MIPS: Fix minimum alignment requirement of IRQ stack
Message-ID: <201707090720.pSLWXbMb%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <1499439432-29847-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lkp@intel.com
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


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matt,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12 next-20170707]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matt-Redfearn/MIPS-Fix-minimum-alignment-requirement-of-IRQ-stack/20170709-054925
config: mips-jz4740 (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   In file included from arch/mips/include/asm/irq.h:12:0,
                    from include/linux/irq.h:27,
                    from arch/mips/sgi-ip22/ip22-time.c:15:
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:18:15: note: in expansion of macro 'LONG'
    typedef long  LONG __attribute__ ((__mode__ (__SI__)));
                  ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:27:9: note: in expansion of macro 'LONG'
    typedef LONG  _PCHAR;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:28:9: note: in expansion of macro 'LONG'
    typedef LONG  _PSHORT;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:29:9: note: in expansion of macro 'LONG'
    typedef LONG  _PLARGE_INTEGER;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:30:9: note: in expansion of macro 'LONG'
    typedef LONG  _PLONG;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:31:9: note: in expansion of macro 'LONG'
    typedef LONG  _PUCHAR;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:32:9: note: in expansion of macro 'LONG'
    typedef LONG  _PUSHORT;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:33:9: note: in expansion of macro 'LONG'
    typedef LONG  _PULONG;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:34:9: note: in expansion of macro 'LONG'
    typedef LONG  _PVOID;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:65:9: note: in expansion of macro 'LONG'
    typedef LONG  *PLONG;
            ^~~~
   In file included from arch/mips/include/asm/sgialib.h:15:0,
                    from arch/mips/sgi-ip22/ip22-time.c:27:
>> arch/mips/include/asm/sgiarcs.h:89:2: error: unknown type name '_PULONG'
     _PULONG   iname; /* string identifier */
     ^~~~~~~
   In file included from arch/mips/include/asm/irq.h:12:0,
                    from include/linux/irq.h:27,
                    from arch/mips/sgi-ip22/ip22-time.c:15:
   arch/mips/include/asm/asm.h:318:15: error: expected specifier-qualifier-list before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgiarcs.h:188:2: note: in expansion of macro 'LONG'
     LONG load;   /* Load an executable image. */
     ^~~~
   In file included from arch/mips/include/asm/sgialib.h:15:0,
                    from arch/mips/sgi-ip22/ip22-time.c:27:
>> arch/mips/include/asm/sgiarcs.h:252:2: error: unknown type name '_PLONG'
     _PLONG   rs_block; /* Restart block. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:253:2: error: unknown type name '_PLONG'
     _PLONG   dbg_block; /* Debug block. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:254:2: error: unknown type name '_PLONG'
     _PLONG   gevect;  /* XXX General vector??? */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:255:2: error: unknown type name '_PLONG'
     _PLONG   utlbvect; /* XXX UTLB vector??? */
     ^~~~~~
>> arch/mips/include/asm/sgiarcs.h:257:2: error: unknown type name '_PVOID'
     _PVOID   romvec;  /* Function interface. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:259:2: error: unknown type name '_PVOID'
     _PVOID   pvector; /* Private vector. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:263:2: error: unknown type name '_PVOID'
     _PVOID   adap_vector; /* Adapter 0 vector ptr. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:266:2: error: unknown type name '_PVOID'
     _PVOID   adap_vector1; /* Adapter 1 vector ptr. */
     ^~~~~~
   In file included from arch/mips/include/asm/irq.h:12:0,
                    from include/linux/irq.h:27,
                    from arch/mips/sgi-ip22/ip22-time.c:15:
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:20:8: note: in expansion of macro 'LONG'
    extern LONG *_prom_argv, *_prom_envp;
           ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:64:8: note: in expansion of macro 'LONG'
    extern LONG ArcSetEnvironmentVariable(PCHAR name, PCHAR value);
           ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:70:8: note: in expansion of macro 'LONG'
    extern LONG ArcRead(ULONG fd, PVOID buf, ULONG num, PULONG cnt);
           ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:71:8: note: in expansion of macro 'LONG'
    extern LONG ArcWrite(ULONG fd, PVOID buf, ULONG num, PULONG cnt);
           ^~~~
   arch/mips/sgi-ip22/ip22-time.c: In function 'indy_8254timer_irq':
>> arch/mips/sgi-ip22/ip22-time.c:128:2: error: implicit declaration of function 'ArcRead' [-Werror=implicit-function-declaration]
     ArcRead(0, &c, 1, &cnt);
     ^~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from arch/mips/include/asm/irq.h:12:0,
                    from include/linux/irq.h:27,
                    from include/asm-generic/hardirq.h:12,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from arch/mips/sgi-ip22/ip22-reset.c:11:
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:18:15: note: in expansion of macro 'LONG'
    typedef long  LONG __attribute__ ((__mode__ (__SI__)));
                  ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:27:9: note: in expansion of macro 'LONG'
    typedef LONG  _PCHAR;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:28:9: note: in expansion of macro 'LONG'
    typedef LONG  _PSHORT;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:29:9: note: in expansion of macro 'LONG'
    typedef LONG  _PLARGE_INTEGER;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:30:9: note: in expansion of macro 'LONG'
    typedef LONG  _PLONG;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:31:9: note: in expansion of macro 'LONG'
    typedef LONG  _PUCHAR;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:32:9: note: in expansion of macro 'LONG'
    typedef LONG  _PUSHORT;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:33:9: note: in expansion of macro 'LONG'
    typedef LONG  _PULONG;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:34:9: note: in expansion of macro 'LONG'
    typedef LONG  _PVOID;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:65:9: note: in expansion of macro 'LONG'
    typedef LONG  *PLONG;
            ^~~~
   In file included from arch/mips/include/asm/sgialib.h:15:0,
                    from arch/mips/sgi-ip22/ip22-reset.c:21:
>> arch/mips/include/asm/sgiarcs.h:89:2: error: unknown type name '_PULONG'
     _PULONG   iname; /* string identifier */
     ^~~~~~~
   In file included from arch/mips/include/asm/irq.h:12:0,
                    from include/linux/irq.h:27,
                    from include/asm-generic/hardirq.h:12,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from arch/mips/sgi-ip22/ip22-reset.c:11:
   arch/mips/include/asm/asm.h:318:15: error: expected specifier-qualifier-list before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgiarcs.h:188:2: note: in expansion of macro 'LONG'
     LONG load;   /* Load an executable image. */
     ^~~~
   In file included from arch/mips/include/asm/sgialib.h:15:0,
                    from arch/mips/sgi-ip22/ip22-reset.c:21:
>> arch/mips/include/asm/sgiarcs.h:252:2: error: unknown type name '_PLONG'
     _PLONG   rs_block; /* Restart block. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:253:2: error: unknown type name '_PLONG'
     _PLONG   dbg_block; /* Debug block. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:254:2: error: unknown type name '_PLONG'
     _PLONG   gevect;  /* XXX General vector??? */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:255:2: error: unknown type name '_PLONG'
     _PLONG   utlbvect; /* XXX UTLB vector??? */
     ^~~~~~
>> arch/mips/include/asm/sgiarcs.h:257:2: error: unknown type name '_PVOID'
     _PVOID   romvec;  /* Function interface. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:259:2: error: unknown type name '_PVOID'
     _PVOID   pvector; /* Private vector. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:263:2: error: unknown type name '_PVOID'
     _PVOID   adap_vector; /* Adapter 0 vector ptr. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:266:2: error: unknown type name '_PVOID'
     _PVOID   adap_vector1; /* Adapter 1 vector ptr. */
     ^~~~~~
   In file included from arch/mips/include/asm/irq.h:12:0,
                    from include/linux/irq.h:27,
                    from include/asm-generic/hardirq.h:12,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:8,
                    from include/linux/interrupt.h:12,
                    from arch/mips/sgi-ip22/ip22-reset.c:11:
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:20:8: note: in expansion of macro 'LONG'
    extern LONG *_prom_argv, *_prom_envp;
           ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:64:8: note: in expansion of macro 'LONG'
    extern LONG ArcSetEnvironmentVariable(PCHAR name, PCHAR value);
           ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:70:8: note: in expansion of macro 'LONG'
    extern LONG ArcRead(ULONG fd, PVOID buf, ULONG num, PULONG cnt);
           ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:71:8: note: in expansion of macro 'LONG'
    extern LONG ArcWrite(ULONG fd, PVOID buf, ULONG num, PULONG cnt);
           ^~~~
--
   In file included from arch/mips/include/asm/irq.h:12:0,
                    from include/linux/irq.h:27,
                    from arch/mips//sgi-ip22/ip22-time.c:15:
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:18:15: note: in expansion of macro 'LONG'
    typedef long  LONG __attribute__ ((__mode__ (__SI__)));
                  ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:27:9: note: in expansion of macro 'LONG'
    typedef LONG  _PCHAR;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:28:9: note: in expansion of macro 'LONG'
    typedef LONG  _PSHORT;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:29:9: note: in expansion of macro 'LONG'
    typedef LONG  _PLARGE_INTEGER;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:30:9: note: in expansion of macro 'LONG'
    typedef LONG  _PLONG;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:31:9: note: in expansion of macro 'LONG'
    typedef LONG  _PUCHAR;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:32:9: note: in expansion of macro 'LONG'
    typedef LONG  _PUSHORT;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:33:9: note: in expansion of macro 'LONG'
    typedef LONG  _PULONG;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:34:9: note: in expansion of macro 'LONG'
    typedef LONG  _PVOID;
            ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/fw/arc/types.h:65:9: note: in expansion of macro 'LONG'
    typedef LONG  *PLONG;
            ^~~~
   In file included from arch/mips/include/asm/sgialib.h:15:0,
                    from arch/mips//sgi-ip22/ip22-time.c:27:
>> arch/mips/include/asm/sgiarcs.h:89:2: error: unknown type name '_PULONG'
     _PULONG   iname; /* string identifier */
     ^~~~~~~
   In file included from arch/mips/include/asm/irq.h:12:0,
                    from include/linux/irq.h:27,
                    from arch/mips//sgi-ip22/ip22-time.c:15:
   arch/mips/include/asm/asm.h:318:15: error: expected specifier-qualifier-list before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgiarcs.h:188:2: note: in expansion of macro 'LONG'
     LONG load;   /* Load an executable image. */
     ^~~~
   In file included from arch/mips/include/asm/sgialib.h:15:0,
                    from arch/mips//sgi-ip22/ip22-time.c:27:
>> arch/mips/include/asm/sgiarcs.h:252:2: error: unknown type name '_PLONG'
     _PLONG   rs_block; /* Restart block. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:253:2: error: unknown type name '_PLONG'
     _PLONG   dbg_block; /* Debug block. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:254:2: error: unknown type name '_PLONG'
     _PLONG   gevect;  /* XXX General vector??? */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:255:2: error: unknown type name '_PLONG'
     _PLONG   utlbvect; /* XXX UTLB vector??? */
     ^~~~~~
>> arch/mips/include/asm/sgiarcs.h:257:2: error: unknown type name '_PVOID'
     _PVOID   romvec;  /* Function interface. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:259:2: error: unknown type name '_PVOID'
     _PVOID   pvector; /* Private vector. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:263:2: error: unknown type name '_PVOID'
     _PVOID   adap_vector; /* Adapter 0 vector ptr. */
     ^~~~~~
   arch/mips/include/asm/sgiarcs.h:266:2: error: unknown type name '_PVOID'
     _PVOID   adap_vector1; /* Adapter 1 vector ptr. */
     ^~~~~~
   In file included from arch/mips/include/asm/irq.h:12:0,
                    from include/linux/irq.h:27,
                    from arch/mips//sgi-ip22/ip22-time.c:15:
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:20:8: note: in expansion of macro 'LONG'
    extern LONG *_prom_argv, *_prom_envp;
           ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:64:8: note: in expansion of macro 'LONG'
    extern LONG ArcSetEnvironmentVariable(PCHAR name, PCHAR value);
           ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:70:8: note: in expansion of macro 'LONG'
    extern LONG ArcRead(ULONG fd, PVOID buf, ULONG num, PULONG cnt);
           ^~~~
   arch/mips/include/asm/asm.h:318:15: error: expected identifier or '(' before '.' token
    #define LONG  .word
                  ^
   arch/mips/include/asm/sgialib.h:71:8: note: in expansion of macro 'LONG'
    extern LONG ArcWrite(ULONG fd, PVOID buf, ULONG num, PULONG cnt);
           ^~~~
   arch/mips//sgi-ip22/ip22-time.c: In function 'indy_8254timer_irq':
   arch/mips//sgi-ip22/ip22-time.c:128:2: error: implicit declaration of function 'ArcRead' [-Werror=implicit-function-declaration]
     ArcRead(0, &c, 1, &cnt);
     ^~~~~~~
   cc1: all warnings being treated as errors

vim +/_PULONG +89 arch/mips/include/asm/sgiarcs.h

^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   83  	USHORT			vers;	/* node version */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   84  	USHORT			rev;	/* node revision */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   85  	ULONG			key;	/* completely magic */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   86  	ULONG			amask;	/* XXX affinity mask??? */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   87  	ULONG			cdsize; /* size of configuration data */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   88  	ULONG			ilen;	/* length of string identifier */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  @89  	_PULONG			iname;	/* string identifier */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   90  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   91  typedef struct linux_component pcomponent;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   92  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   93  struct linux_sysid {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   94  	char vend[8], prod[8];
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   95  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   96  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   97  /* ARCS prom memory descriptors. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   98  enum arcs_memtypes {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16   99  	arcs_eblock,  /* exception block */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  100  	arcs_rvpage,  /* ARCS romvec page */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  101  	arcs_fcontig, /* Contiguous and free */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  102  	arcs_free,    /* Generic free memory */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  103  	arcs_bmem,    /* Borken memory, don't use */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  104  	arcs_prog,    /* A loaded program resides here */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  105  	arcs_atmp,    /* ARCS temporary storage area, wish Sparc OpenBoot told this */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  106  	arcs_aperm,   /* ARCS permanent storage... */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  107  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  108  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  109  /* ARC has slightly different types than ARCS */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  110  enum arc_memtypes {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  111  	arc_eblock,  /* exception block */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  112  	arc_rvpage,  /* romvec page */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  113  	arc_free,    /* Generic free memory */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  114  	arc_bmem,    /* Borken memory, don't use */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  115  	arc_prog,    /* A loaded program resides here */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  116  	arc_atmp,    /* temporary storage area */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  117  	arc_aperm,   /* permanent storage */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  118  	arc_fcontig, /* Contiguous and free */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  119  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  120  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  121  union linux_memtypes {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  122      enum arcs_memtypes arcs;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  123      enum arc_memtypes arc;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  124  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  125  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  126  struct linux_mdesc {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  127  	union linux_memtypes type;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  128  	ULONG base;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  129  	ULONG pages;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  130  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  131  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  132  /* Time of day descriptor. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  133  struct linux_tinfo {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  134  	unsigned short yr;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  135  	unsigned short mnth;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  136  	unsigned short day;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  137  	unsigned short hr;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  138  	unsigned short min;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  139  	unsigned short sec;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  140  	unsigned short msec;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  141  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  142  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  143  /* ARCS virtual dirents. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  144  struct linux_vdirent {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  145  	ULONG namelen;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  146  	unsigned char attr;
92a76f6d arch/mips/include/asm/sgiarcs.h Adam Buchbinder 2016-02-25  147  	char fname[32]; /* XXX empirical, should be a define */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  148  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  149  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  150  /* Other stuff for files. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  151  enum linux_omode {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  152  	rdonly, wronly, rdwr, wronly_creat, rdwr_creat,
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  153  	wronly_ssede, rdwr_ssede, dirent, dirent_creat
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  154  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  155  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  156  enum linux_seekmode {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  157  	absolute, relative
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  158  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  159  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  160  enum linux_mountops {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  161  	media_load, media_unload
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  162  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  163  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  164  /* This prom has a bolixed design. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  165  struct linux_bigint {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  166  #ifdef __MIPSEL__
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  167  	u32 lo;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  168  	s32 hi;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  169  #else /* !(__MIPSEL__) */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  170  	s32 hi;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  171  	u32 lo;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  172  #endif
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  173  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  174  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  175  struct linux_finfo {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  176  	struct linux_bigint   begin;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  177  	struct linux_bigint   end;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  178  	struct linux_bigint   cur;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  179  	enum linux_devtypes   dtype;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  180  	unsigned long	      namelen;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  181  	unsigned char	      attr;
92a76f6d arch/mips/include/asm/sgiarcs.h Adam Buchbinder 2016-02-25  182  	char		      name[32]; /* XXX empirical, should be define */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  183  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  184  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  185  /* This describes the vector containing function pointers to the ARC
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  186     firmware functions.	*/
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  187  struct linux_romvec {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16 @188  	LONG	load;			/* Load an executable image. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  189  	LONG	invoke;			/* Invoke a standalong image. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  190  	LONG	exec;			/* Load and begin execution of a
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  191  					   standalone image. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  192  	LONG	halt;			/* Halt the machine. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  193  	LONG	pdown;			/* Power down the machine. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  194  	LONG	restart;		/* XXX soft reset??? */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  195  	LONG	reboot;			/* Reboot the machine. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  196  	LONG	imode;			/* Enter PROM interactive mode. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  197  	LONG	_unused1;		/* Was ReturnFromMain(). */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  198  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  199  	/* PROM device tree interface. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  200  	LONG	next_component;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  201  	LONG	child_component;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  202  	LONG	parent_component;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  203  	LONG	component_data;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  204  	LONG	child_add;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  205  	LONG	comp_del;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  206  	LONG	component_by_path;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  207  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  208  	/* Misc. stuff. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  209  	LONG	cfg_save;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  210  	LONG	get_sysid;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  211  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  212  	/* Probing for memory. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  213  	LONG	get_mdesc;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  214  	LONG	_unused2;		/* was Signal() */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  215  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  216  	LONG	get_tinfo;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  217  	LONG	get_rtime;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  218  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  219  	/* File type operations. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  220  	LONG	get_vdirent;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  221  	LONG	open;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  222  	LONG	close;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  223  	LONG	read;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  224  	LONG	get_rstatus;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  225  	LONG	write;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  226  	LONG	seek;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  227  	LONG	mount;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  228  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  229  	/* Dealing with firmware environment variables. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  230  	LONG	get_evar;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  231  	LONG	set_evar;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  232  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  233  	LONG	get_finfo;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  234  	LONG	set_finfo;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  235  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  236  	/* Miscellaneous. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  237  	LONG	cache_flush;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  238  	LONG	TestUnicodeCharacter;		/* ARC; not sure if ARCS too */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  239  	LONG	GetDisplayStatus;
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  240  };
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  241  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  242  /* The SGI ARCS parameter block is in a fixed location for standalone
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  243   * programs to access PROM facilities easily.
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  244   */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  245  typedef struct _SYSTEM_PARAMETER_BLOCK {
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  246  	ULONG			magic;		/* magic cookie */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  247  #define PROMBLOCK_MAGIC	     0x53435241
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  248  
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  249  	ULONG			len;		/* length of parm block */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  250  	USHORT			ver;		/* ARCS firmware version */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  251  	USHORT			rev;		/* ARCS firmware revision */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16 @252  	_PLONG			rs_block;	/* Restart block. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16 @253  	_PLONG			dbg_block;	/* Debug block. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  254  	_PLONG			gevect;		/* XXX General vector??? */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  255  	_PLONG			utlbvect;	/* XXX UTLB vector??? */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  256  	ULONG			rveclen;	/* Size of romvec struct. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16 @257  	_PVOID			romvec;		/* Function interface. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  258  	ULONG			pveclen;	/* Length of private vector. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  259  	_PVOID			pvector;	/* Private vector. */
^1da177e include/asm-mips/sgiarcs.h      Linus Torvalds  2005-04-16  260  	ULONG			adap_cnt;	/* Adapter count. */

:::::: The code at line 89 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/D9sDkZ92kUBAA==

--VbJkn9YxBvnuCH5J--
