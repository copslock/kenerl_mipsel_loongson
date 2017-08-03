Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2017 22:56:03 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:33146 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994906AbdHCUzzxA2i6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Aug 2017 22:55:55 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id A65A421EE6; Thu,  3 Aug 2017 22:55:47 +0200 (CEST)
Received: from windsurf.lan (LFbn-1-10680-2.w90-89.abo.wanadoo.fr [90.89.33.2])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 7307321EDF;
        Thu,  3 Aug 2017 22:55:47 +0200 (CEST)
Date:   Thu, 3 Aug 2017 22:55:47 +0200
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Waldemar Brodkorb <wbx@openadk.org>
Subject: undefined reference to `__multi3' when building with gcc 7.x
Message-ID: <20170803225547.6caa602b@windsurf.lan>
Organization: Free Electrons
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/olx.LvPyOw70sLhmMDE=yHg"
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

--MP_/olx.LvPyOw70sLhmMDE=yHg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

When trying to build the current Linux master with a gcc 7.x toolchain
for mips64r6-n32, I'm getting the following build failure:

crypto/scompress.o: In function `.L31':
scompress.c:(.text+0x2a0): undefined reference to `__multi3'
drivers/base/component.o: In function `.L97':
component.c:(.text+0x4a4): undefined reference to `__multi3'
drivers/base/component.o: In function `component_master_add_with_match':
component.c:(.text+0x8c4): undefined reference to `__multi3'
net/core/ethtool.o: In function `ethtool_set_per_queue_coalesce':
ethtool.c:(.text+0x1ab0): undefined reference to `__multi3'
Makefile:1000: recipe for target 'vmlinux' failed
make[2]: *** [vmlinux] Error 1

Taking the example from net/core/ethtool.o, objdump says:

    1aac:       00408025        move    s0,v0
    1ab0:       e8000000        balc    1ab4 <ethtool_set_per_queue_coalesce+0x7c>
    1ab4:       14600000        bnez    v1,1ab8 <ethtool_set_per_queue_coalesce+0x80>

And readelf tells us:

Relocation section '.rela.text' at offset 0xaa00 contains 1189 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
[...]
000000001ab0  023a0000003d R_MIPS_PC26_S2    0000000000000000 __multi3 - 4
                    Type2: R_MIPS_NONE      
                    Type3: R_MIPS_NONE      
[...]
Symbol table '.symtab' contains 586 entries:
[...]
   570: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  UND __multi3

__multi3() is normally provided by libgcc, but of course the kernel
doesn't link with libgcc.

The bug can be reproduced by building with the toolchain available at
http://toolchains.free-electrons.com/downloads/2017.08-rc1-fix-binutils/toolchains/mips64r6el-n32/tarballs/mips64r6el-n32--glibc--bleeding-edge-2017.05-1453-ga703fdd-1.tar.bz2
and building with the attached kernel configuration file.

It is not clear to me if this is a kernel issue (lack of __multi3 in
arch/mips/lib/), or a gcc bug in that it shouldn't emit a call to this
function.

FWIW, sparc64 had a similar issue, and they added __multi3 in their
libgcc replacement, see commit
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/sparc/lib?id=1b4af13ff2cc6897557bb0b8d9e2fad4fa4d67aa.

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--MP_/olx.LvPyOw70sLhmMDE=yHg
Content-Type: application/octet-stream; name=defconfig
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=defconfig

Q09ORklHX01JUFNfTUFMVEE9eQpDT05GSUdfQ1BVX0xJVFRMRV9FTkRJQU49eQpDT05GSUdfQ1BV
X01JUFM2NF9SNj15CkNPTkZJR182NEJJVD15CkNPTkZJR19TWVNWSVBDPXkKQ09ORklHX0hJR0hf
UkVTX1RJTUVSUz15CkNPTkZJR19NT0RVTEVTPXkKQ09ORklHX01PRFVMRV9VTkxPQUQ9eQpDT05G
SUdfUENJPXkKQ09ORklHX01JUFMzMl9PMzI9eQpDT05GSUdfTUlQUzMyX04zMj15CkNPTkZJR19O
RVQ9eQpDT05GSUdfUEFDS0VUPXkKQ09ORklHX1VOSVg9eQpDT05GSUdfSU5FVD15CkNPTkZJR19E
RVZUTVBGUz15CkNPTkZJR19ERVZUTVBGU19NT1VOVD15CkNPTkZJR19JREU9eQpDT05GSUdfQkxL
X0RFVl9JREVDRD15CkNPTkZJR19JREVfR0VORVJJQz15CkNPTkZJR19CTEtfREVWX0dFTkVSSUM9
eQpDT05GSUdfQkxLX0RFVl9QSUlYPXkKQ09ORklHX05FVERFVklDRVM9eQpDT05GSUdfUENORVQz
Mj15CkNPTkZJR19JTlBVVF9FVkRFVj15CkNPTkZJR19TRVJJQUxfODI1MD15CkNPTkZJR19TRVJJ
QUxfODI1MF9DT05TT0xFPXkKQ09ORklHX0ZCPXkKQ09ORklHX0ZCX0NJUlJVUz15CkNPTkZJR19V
U0I9eQpDT05GSUdfVVNCX1VIQ0lfSENEPXkKQ09ORklHX0VYVDRfRlM9eQpDT05GSUdfVE1QRlM9
eQpDT05GSUdfVE1QRlNfUE9TSVhfQUNMPXkK

--MP_/olx.LvPyOw70sLhmMDE=yHg--
