Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 12:28:32 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:56629 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010563AbcASL23QGufS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jan 2016 12:28:29 +0100
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP; 19 Jan 2016 03:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,317,1449561600"; 
   d="scan'208";a="730160119"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2016 03:28:19 -0800
Received: from kbuild by bee with local (Exim 4.83)
        (envelope-from <fengguang.wu@intel.com>)
        id 1aLUSN-000N2A-2r; Tue, 19 Jan 2016 19:28:15 +0800
Date:   Tue, 19 Jan 2016 19:27:55 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Hogan <james.hogan@imgtec.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Hogan <james.hogan@imgtec.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>
Subject: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642] d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Message-ID: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
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

https://github.com/0day-ci/linux  James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642
d979f99e9cc14e2667e9b6e268db695977e4197a  kbuild: Remove stale asm-generic wrappers

arch/x86/include/asm/unistd.h:15:29: fatal error: asm/unistd_32.h: No such file or directory
arch/x86/kernel/asm-offsets_32.c:12:29: fatal error: asm/syscalls_32.h: No such file or directory
arch/x86/kernel/asm-offsets_64.c:15:29: fatal error: asm/syscalls_64.h: No such file or directory
/bin/sh: line 0: [: -ge: unary operator expected

Error ids grouped by kconfigs:

recent_errors
├── i386-alldefconfig
│   └── arch-x86-include-asm-unistd.h:fatal-error:asm-unistd_32.h:No-such-file-or-directory
├── i386-allmodconfig
│   └── arch-x86-include-asm-unistd.h:fatal-error:asm-unistd_32.h:No-such-file-or-directory
├── i386-allyesconfig
│   └── arch-x86-include-asm-unistd.h:fatal-error:asm-unistd_32.h:No-such-file-or-directory
├── i386-defconfig
│   └── arch-x86-include-asm-unistd.h:fatal-error:asm-unistd_32.h:No-such-file-or-directory
├── i386-randconfig-a0-201603
│   └── arch-x86-kernel-asm-offsets_32.c:fatal-error:asm-syscalls_32.h:No-such-file-or-directory
├── i386-randconfig-b0-01191831
│   └── arch-x86-kernel-asm-offsets_32.c:fatal-error:asm-syscalls_32.h:No-such-file-or-directory
├── i386-randconfig-i0-201603
│   └── arch-x86-include-asm-unistd.h:fatal-error:asm-unistd_32.h:No-such-file-or-directory
├── i386-randconfig-i1-201603
│   └── arch-x86-include-asm-unistd.h:fatal-error:asm-unistd_32.h:No-such-file-or-directory
├── i386-randconfig-r0-201603
│   └── arch-x86-kernel-asm-offsets_32.c:fatal-error:asm-syscalls_32.h:No-such-file-or-directory
├── i386-randconfig-s1-201603
│   └── arch-x86-kernel-asm-offsets_32.c:fatal-error:asm-syscalls_32.h:No-such-file-or-directory
├── i386-randconfig-x002-01181631
│   └── bin-sh:line::ge:unary-operator-expected
├── i386-tinyconfig
│   └── arch-x86-kernel-asm-offsets_32.c:fatal-error:asm-syscalls_32.h:No-such-file-or-directory
└── x86_64-randconfig-s3-01191831
    └── arch-x86-kernel-asm-offsets_64.c:fatal-error:asm-syscalls_64.h:No-such-file-or-directory

elapsed time: 50m

configs tested: 118

i386                     randconfig-a0-201603
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                       imx_v6_v7_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                          prima2_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                       spear13xx_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
avr32                    hammerhead_defconfig
m32r                    m32700ut.up_defconfig
mips                        bcm47xx_defconfig
mips                       capcella_defconfig
powerpc                   bluestone_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201603
i386                     randconfig-s1-201603
x86_64                 randconfig-s0-01191831
x86_64                 randconfig-s1-01191831
x86_64                 randconfig-s2-01191831
x86_64                           allmodconfig
x86_64                 randconfig-s3-01191831
x86_64                 randconfig-s4-01191831
x86_64                 randconfig-s5-01191831
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             alldefconfig
mips                         db1xxx_defconfig
mips                malta_qemu_32r6_defconfig
sh                          landisk_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201603
i386                   randconfig-b0-01191831
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201603
i386                     randconfig-i1-201603
i386                             allyesconfig
x86_64                 randconfig-b0-01191744
i386                               tinyconfig
i386                     randconfig-n0-201603
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                   rhel
ia64                          tiger_defconfig
x86_64                 randconfig-x000-201603
x86_64                 randconfig-x001-201603
x86_64                 randconfig-x002-201603
x86_64                 randconfig-x003-201603
x86_64                 randconfig-x004-201603
x86_64                 randconfig-x005-201603
x86_64                 randconfig-x006-201603
x86_64                 randconfig-x007-201603
x86_64                 randconfig-x008-201603
x86_64                 randconfig-x009-201603
i386                     randconfig-r0-201603
i386                             allmodconfig
m68k                          sun3x_defconfig
mips                  mips_paravirt_defconfig
powerpc                     ppa8548_defconfig
i386                 randconfig-x000-01181631
i386                 randconfig-x001-01181631
i386                 randconfig-x002-01181631
i386                 randconfig-x003-01181631
i386                 randconfig-x004-01181631
i386                 randconfig-x005-01181631
i386                 randconfig-x006-01181631
i386                 randconfig-x007-01181631
i386                 randconfig-x008-01181631
i386                 randconfig-x009-01181631

Thanks,
Fengguang
