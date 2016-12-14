Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2016 21:56:41 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.13]:58065 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990513AbcLNU4edmvtE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Dec 2016 21:56:34 +0100
Received: from wuerfel.localnet ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPSA (Nemesis) id
 0MN62C-1cF3fj0DG4-006bz3; Wed, 14 Dec 2016 21:56:23 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     kernel-build-reports@lists.linaro.org
Cc:     Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: next build: 198 builds: 4 failed, 194 passed, 7 errors, 82 warnings (next-20161214)
Date:   Wed, 14 Dec 2016 21:56:20 +0100
Message-ID: <6690634.sIS8JJ6W6I@wuerfel>
User-Agent: KMail/5.1.3 (Linux/4.4.0-34-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20161214174539.h3xsugswlq576g7b@sirena.org.uk>
References: <58510536.04c7190a.4a2fb.ae5c@mx.google.com> <20161214160609.GA15191@linux-mips.org> <20161214174539.h3xsugswlq576g7b@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:bc77kE72TOrPGA3qLkT97oBWmoHJKJLGi9zjDRA26Z4Yo3wk5NX
 S6+5nAIcLdDxBst6gM5hw92AuS6uGy2sWVsa4csJN0SyPkNyQRCSAQUyGq4HjuM7OmOpQ1U
 ncsGeV+H4z7IEn3SmzTClbL08EyirfVTQfVtFINRdtP8J9fa6awXgXn6u6T/4ah2ErrYiYM
 EE54WENayrg3+9NuE27Bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7z2HtMIR1o4=:5sEy2+pr8yIwn2FyqXv/Qm
 PArFPFMNjuidpPqU84dJMshIzwRcMbDBR+h66SJri2XNjtdB7bA66x3kAR1TqkJPpmg6E5+kA
 rvegTh3q4u1iwKESNsLV0D+kyldZnPORXKxdE5kELK+WIt+T/aZwE3LPtFvUNRE1EiL/XsTAg
 slb3rfZ59wjYhSgMS6vfbq+8TYKAjD66TBdF60l83e1l6qO1SBxgy7P9bUTueF+zwHN4yGLhf
 Zu8zuz1wYJGSUotfrsKT51XUXIu25vwh3Hy22IOCr3ENFV5CbSyIqG1Np5aQamPBUqs5vEaZs
 pe9V/iXjb+TrVcODHtGY+mSJ73mCwVMB1NJbemLkgXvF4RhGczc79rBSbyCblYkTBQicSc6iI
 HulcJUhPNOIcODFv0m8WhAGLHDZTMmn0PUnEMiqZezRDB9swtFWI8vBcyvxYfUgINI1UzM6bR
 F2NxC+v57MxrTV0m9K3lDd0YRxENhpkCKvkycOhyLTCBELAlN4Jgjp8AVyZEbAmn+I3aPzaQy
 vhSwk0ZM5Em0N7twvJGNAHtNvhgnSZwEEIXNfHkdb4gkdf/vLbrFctpxti4Tmd2NAGDXB52jf
 O9fvfGDxTAsnK28u1Ee3+pSmja+lJtaSJ6h3tMwBBiXpSqW//z+HdWk77K7p1WE423CKhxtsr
 IQT09xO53a/C1eVKg7SqS4Has/gkwD1UPS6Yrd0oVuvAzKVTsE25n28MSQ4Spkt/UOcCKlIFq
 yir/zmTZgkkFlhRm
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday, December 14, 2016 5:45:39 PM CET Mark Brown wrote:
> On Wed, Dec 14, 2016 at 05:06:09PM +0100, Ralf Baechle wrote:
> > On Wed, Dec 14, 2016 at 01:52:14PM +0000, Mark Brown wrote:
> > > On Wed, Dec 14, 2016 at 12:39:18AM -0800, kernelci.org bot wrote:
> 
> > > > mips:    gcc version 5.3.0 (Sourcery CodeBench Lite 2016.05-8)
> 
> > > These MIPS builds have been failing in kernelci ever since MIPS was
> > > added.  This means that we've got a constant level of noise in the
> > > results which makes them less useful for everyone - people get used to
> > > ignoring errors.  Is there any plan to get these fixed?
> 
> > I wonder if these are also toolchain-related issues.  allnoconfig and
> > tinyconfig do build fine for me with GCC 6.1.0 and binutils 2.26.20160125.
> 
> > generic_defconfig requires mkimage of uboot-tools or it will fail like this:
> 
> >   ITB     arch/mips/boot/vmlinux.gz.itb
> > "mkimage" command not found - U-Boot images will not be built
> > arch/mips/boot/Makefile:159: recipe for target 'arch/mips/boot/vmlinux.gz.itb' failed
> > make[1]: *** [arch/mips/boot/vmlinux.gz.itb] Error 1
> > arch/mips/Makefile:365: recipe for target 'vmlinux.gz.itb' failed
> > make: *** [vmlinux.gz.itb] Error 2
> 
> Ah, you don't have a separate uImage target?
> 
> > What binutils are you using and can you send me the build errors messages?
> 
> You can see logs for all the trees we build via the web interface:
> 
>    https://kernelci.org/job/
> 
> I don't have access to the builders to check the binutils version
> without going and finding/downloading the CodeSourcery release.  Where
> did your toolchain come from, is there something specific recommended
> for MIPS?
> 

From the web interface:

| Errors Summary
|
| 2	arch/mips/include/asm/mach-generic/spaces.h:28:0: error: "CAC_BASE" redefined [-Werror]
| 1	{standard input}:191: Error: number (0x9000000080000000) larger than 32 bits
| 1	{standard input}:164: Error: number (0x9000000080000000) larger than 32 bits
| 1	{standard input}:154: Error: number (0x9000000080000000) larger than 32 bits
| 1	{standard input}:139: Error: number (0x9000000080000000) larger than 32 bits
| 1	{standard input}:131: Error: number (0x9000000080000000) larger than 32 bits

This already got better than it was. I haven't analyzed them at all,
but I had not expected them to be toolchain related. The first one is
for ip27_defconfig, the other ones are for allnoconfig/tinyconfig.

The allmodconfig build had a lot more warnings, and was disabled
in kernelci a long time ago.

| Warnings Summary
|
| 2	arch/mips/configs/ip22_defconfig:71:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
| 2	arch/mips/configs/ip22_defconfig:70:warning: symbol value 'm' invalid for NF_CT_PROTO_DCCP

Lots of these, from defconfigs that need a trivial update

1	net/wireless/nl80211.c:4389:1: warning: the frame size of 2240 bytes is larger than 2048 bytes [-Wframe-larger-than=]
1	net/wireless/nl80211.c:1895:1: warning: the frame size of 3776 bytes is larger than 2048 bytes [-Wframe-larger-than=]
1	net/wireless/nl80211.c:1410:1: warning: the frame size of 2208 bytes is larger than 2048 bytes [-Wframe-larger-than=]
1	net/bridge/br_netlink.c:1282:1: warning: the frame size of 2544 bytes is larger than 2048 bytes [-Wframe-larger-than=]
1	drivers/net/ethernet/ti/cpmac.c:1213:2: warning: #warning FIXME: unhardcode gpio&reset bits [-Wcpp]
1	drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c:748:1: warning: the frame size of 4704 bytes is larger than 2048 bytes [-Wframe-larger-than=]
1	drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c:970:1: warning: the frame size of 2784 bytes is larger than 2048 bytes [-Wframe-larger-than=]
1	drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c:1021:1: warning: the frame size of 2208 bytes is larger than 2048 bytes [-Wframe-larger-than=]
1	drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c:621:1: warning: the frame size of 3616 bytes is larger than 2048 bytes [-Wframe-larger-than=]
1	drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2753:1: warning: the frame size of 10768 bytes is larger than 2048 bytes [-Wframe-larger-than=]
1	drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c:641:1: warning: the frame size of 5728 bytes is larger than 2048 bytes [-Wframe-larger-than=]
1	drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c:419:1: warning: the frame size of 2912 bytes is larger than 2048 bytes [-Wframe-larger-than=]
1	drivers/net/ethernet/broadcom/bcm63xx_enet.c:1130:3: warning: 'phydev' may be used uninitialized in this function [-Wmaybe-uninitialized]
1	drivers/mtd/maps/pmcmsp-flash.c:149:30: warning: passing argument 1 of 'strncpy' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]

| 1	crypto/wp512.c:987:1: warning: the frame size of 1568 bytes is larger than 1024 bytes [-Wframe-larger-than=]
| 1	crypto/wp512.c:987:1: warning: the frame size of 1504 bytes is larger than 1024 bytes [-Wframe-larger-than=]
| 1	crypto/wp512.c:987:1: warning: the frame size of 1264 bytes is larger than 1024 bytes [-Wframe-larger-than=]
| 1	crypto/serpent_generic.c:436:1: warning: the frame size of 1472 bytes is larger than 1024 bytes [-Wframe-larger-than=]
| 1	crypto/serpent_generic.c:436:1: warning: the frame size of 1456 bytes is larger than 1024 bytes [-Wframe-larger-than=]

I've played around with these, it's possibly a gcc bug. This fixes one of them,
but breaks older toolchains that didn't have those options:

@@ -779,7 +779,10 @@ static const u64 rc[WHIRLPOOL_ROUNDS] = {
  * The core Whirlpool transform.
  */
 
-static void wp512_process_buffer(struct wp512_ctx *wctx) {
+static void
+__attribute__((optimize("-fno-sched-critical-path-heuristic")))
+__attribute__((optimize("-fno-sched-dep-count-heuristic")))
+wp512_process_buffer(struct wp512_ctx *wctx) {
        int i, r;
        u64 K[8];        /* the round key */
        u64 block[8];    /* mu(buffer) */

| 1	arch/mips/ralink/timer.c:74:13: warning: 'rt_timer_free' defined but not used [-Wunused-function]
| 1	arch/mips/ralink/timer.c:104:13: warning: 'rt_timer_disable' defined but not used [-Wunused-function]
| 1	arch/mips/ralink/rt305x.c:92:13: warning: 'rt305x_wdt_reset' defined but not used [-Wunused-function]
| 1	arch/mips/ralink/prom.c:70:2: warning: 'argv' is used uninitialized in this function [-Wuninitialized]
| 1	arch/mips/ralink/prom.c:70:2: warning: 'argc' is used uninitialized in this function [-Wuninitialized]

These are obvious bugs, fix should be trivial

| 1	arch/mips/netlogic/common/smpboot.S:63: Warning: dla used to load 32-bit register; recommend using la instead
| 1	arch/mips/netlogic/common/smpboot.S:62: Warning: dla used to load 32-bit register; recommend using la instead

Probably toolchain related, but should not be hard to fix up for
older toolchains.

	ARnd
