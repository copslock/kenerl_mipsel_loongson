Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 20:08:48 +0000 (GMT)
Received: from mail.e-smith.com ([IPv6:::ffff:216.191.234.126]:32779 "HELO
	nssg.mitel.com") by linux-mips.org with SMTP id <S8225470AbUAOUIh>;
	Thu, 15 Jan 2004 20:08:37 +0000
Received: (qmail 2628 invoked by uid 404); 15 Jan 2004 20:08:31 -0000
Received: from charlieb-linux-mips@e-smith.com by tripe.nssg.mitel.com with qmail-scanner; 15 Jan 2004 15:08:30 -0000
Received: from allspice-core.nssg.mitel.com (HELO e-smith.com) (10.33.16.12)
  by tripe.nssg.mitel.com (10.33.17.11) with SMTP; 15 Jan 2004 20:08:30 -0000
Received: (qmail 20592 invoked by uid 5008); 15 Jan 2004 20:08:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jan 2004 20:08:30 -0000
Date: Thu, 15 Jan 2004 15:08:30 -0500 (EST)
From: Charlie Brady <charlieb-linux-mips@e-smith.com>
X-X-Sender: charlieb@allspice.nssg.mitel.com
To: "John W. Linville" <linville@lvl7.com>
cc: linux-mips@linux-mips.org
Subject: Broadcom gcc changes (was Re: Broadcom 4702?)
In-Reply-To: <4006E67F.7010906@lvl7.com>
Message-ID: <Pine.LNX.4.44.0401151442590.17500-100000@allspice.nssg.mitel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <charlieb-linux-mips@e-smith.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: charlieb-linux-mips@e-smith.com
Precedence: bulk
X-list: linux-mips


On Thu, 15 Jan 2004, John W. Linville wrote:

> Charlie Brady wrote:
> 
> >+ifdef CONFIG_BCM4710
> >+GCCFLAGS       += -m4710a0kern
> > endif
> >
> >I haven't tried building and running a kernel built without the gcc 
> >workarounds, so I don't know whether they are only required for early 
> >  
> >
> I don't know about the 4710 or 4702 (I haven't got around to that yet), 
> but the 4704 doesn't seem to need any special flags for building the 
> kernel (or anything else).

The acid test is not whether the kernel builds, but whether it runs 
correctly under all circumstances :-)

Here's some of the gcc changes, to give you all a feel for what changes 
they've made.

--- gcc-3.0/gcc/config/mips/mips.h      2001-06-14 16:42:18.000000000 
-0400
+++ WRT54G/tools-src/gnu-20010422/gcc/config/mips/mips.h        2003-10-10 
15:15:14.000000000 -0400
@@ -214,6 +214,7 @@
 #define MASK_UNINIT_CONST_IN_RODATA \
                           0x01000000   /* Store uninitialized
                                           consts in rodata */
+#define MASK_NO4710A0     0x02000000   /* WA_BCM4710A0: Don't work-around 
BCM4710A0 CPU bugs */
                                                                                                                                                             
                                        /* Debug switches, not documented 
*/
 #define MASK_DEBUG     0               /* unused */
@@ -310,6 +311,9 @@
 #define TARGET_NO_CHECK_ZERO_DIV (target_flags & MASK_NO_CHECK_ZERO_DIV)
 #define TARGET_CHECK_RANGE_DIV  (target_flags & MASK_CHECK_RANGE_DIV)
                                                                                                                                                             
+/* WA_BCM4710A0 */
+#define TARGET_4710A0          !(target_flags & MASK_NO4710A0)
+
 /* This is true if we must enable the assembly language file switching
    code.  */
                                                                                                                                                             
@@ -423,6 +427,12 @@
      N_("Work around early 4300 hardware bug")},                       \
   {"no-fix4300",         -MASK_4300_MUL_FIX,                           \
      N_("Don't work around early 4300 hardware bug")},                 \
+  {"4710a0",            -MASK_NO4710A0,                                \
+     N_("Work around BCM4710A0 hardware bugs")},                       \
+  {"no-4710a0",                  MASK_NO4710A0,                                
\
+     N_("Don't work around BCM4710A0 hardware bugs")},                 \
+  {"4710a0kern",         MASK_NO4710A0,                                \
+     N_("Don't work around BCM4710A0 hardware bugs")},                 \
   {"4650",               MASK_MAD | MASK_SINGLE_FLOAT,                 \
      N_("Optimize for 4650")},                                         \
   {"3900",               MASK_MIPS3900,                                \
@@ -590,7 +600,8 @@
                                 )
                                                                                                                                                             
 /* ISA has branch likely instructions (eg. mips2). */
-#define ISA_HAS_BRANCHLIKELY   (mips_isa != 1)
+/* WA_BCM4710A0 */
+#define ISA_HAS_BRANCHLIKELY   (mips_isa != 1 && !TARGET_4710A0)

 /* ISA has the conditional move instructions introduced in mips4. */
 #define ISA_HAS_CONDMOVE        (mips_isa == 4                         \
@@ -784,7 +795,7 @@
 /* GAS_ASM_SPEC is passed when using gas, rather than the MIPS
    assembler.  */
                                                                                                                                                             
-#define GAS_ASM_SPEC "%{mcpu=*} %{m4650} %{mmad:-m4650} %{m3900} %{v} 
%{mgp32} %{mgp64}"
+#define GAS_ASM_SPEC "%{mcpu=*} %{m4650} %{m4710a0} %{m4710a0kern} 
%{mmad:-m4650} %{m3900} %{v} %{mgp32} %{mgp64}"
                                                                                                                                                             
 /* TARGET_ASM_SPEC is used to select either MIPS_AS_ASM_SPEC or
                                                                                                                                                             
...

And so we all have some idea where they started from:

--- gcc-3.0/gcc/version.c       2001-06-17 15:44:25.000000000 -0400
+++ WRT54G/tools-src/gnu-20010422/gcc/version.c 2003-10-10 
15:15:11.000000000 -0400
@@ -1,4 +1,4 @@
 #include "gansidecl.h"
 #include "version.h"
                                                                                                                                                             
-const char *const version_string = "3.0";
+const char *const version_string = "3.0 20010422 (prerelease) with 
bcm4710a0 modifications";


--
Charlie
