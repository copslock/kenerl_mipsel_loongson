Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2010 19:23:02 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16017 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492013Ab0BZSW6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2010 19:22:58 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b8811890000>; Fri, 26 Feb 2010 10:23:05 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 26 Feb 2010 10:22:15 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 26 Feb 2010 10:22:14 -0800
Message-ID: <4B881151.9070300@caviumnetworks.com>
Date:   Fri, 26 Feb 2010 10:22:09 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     gdb-patches@sourceware.org
CC:     Joel Brobecker <brobecker@adacore.com>,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Make mips-linux signal frame unwinding more robust.
References: <4B82CEC4.2010607@caviumnetworks.com> <20100225174739.GA2851@adacore.com> <4B86C5EB.6090303@caviumnetworks.com>
In-Reply-To: <4B86C5EB.6090303@caviumnetworks.com>
Content-Type: multipart/mixed;
 boundary="------------040409000908060901040502"
X-OriginalArrivalTime: 26 Feb 2010 18:22:14.0971 (UTC) FILETIME=[9F13B8B0:01CAB710]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040409000908060901040502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/25/2010 10:48 AM, David Daney wrote:
> On 02/25/2010 09:47 AM, Joel Brobecker wrote:
[...]
>>
>> I don't know mips-linux, but something looked funny to me: You avoid
>> the use of SIGFRAME_CODE_OFFSET to compute the address where the
>> sigcontext
>> structure is located, but you still use it to compute the frame base
>> address (used when building the frame ID). Is the frame base address
>> still a constant offset from FUNC, or does the frame ID base address
>> also needs to be changed.
>
> Right, I missed that part. When it started working, I stopped patching.
> I will take another look at that part.
>
>

Here is the revised patch fixing the issue Joel noted.

 From the original message:

   The current signal frame unwinding code in mips-linux-tdep.c assumes
   a constant offset from the signal return trampoline to the signal
   frame. The assumption does not hold for all kernels.  Specifically
   those that have to be compiled with ICACHE_REFILLS_WORKAROUND_WAR
   set (SGI O2 for example).  In the near future, it is likely that the
   assumption will cease to hold universally, as we are attempting to
   move the signal return trampoline off the stack entirely.

   The libgcc unwinder already gets this right by using the signal
   frame's SP to locate the sigcontext.

   This patch makes gdb follow suit and find the sigcontext_base using
   the signal frame's SP rather than an offset from the trampoline.

Tested on mips64-linux with no regressions (and more than 100
improvements).

OK to commit?

How about on the 7.1 branch?


2010-02-26  David Daney  <ddaney.caviumnetworks.com>

	* mips-linux-tdep.c: Update struct sigframe comments.
	(SIGFRAME_CODE_OFFSET): Delete macro.
	(mips_linux_o32_sigframe_init): Calculate sigcontext_base using
	this_frame's sp.
	(mips_linux_n32n64_sigframe_init): Same.

--------------040409000908060901040502
Content-Type: text/plain;
 name="gdb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gdb.patch"

Index: gdb/mips-linux-tdep.c
===================================================================
RCS file: /cvs/src/src/gdb/mips-linux-tdep.c,v
retrieving revision 1.81
diff -u -p -r1.81 mips-linux-tdep.c
--- gdb/mips-linux-tdep.c	1 Jan 2010 07:31:37 -0000	1.81
+++ gdb/mips-linux-tdep.c	25 Feb 2010 20:27:05 -0000
@@ -797,7 +797,7 @@ static const struct tramp_frame mips_lin
 
    struct sigframe {
      u32 sf_ass[4];            [argument save space for o32]
-     u32 sf_code[2];           [signal trampoline]
+     u32 sf_code[2];           [signal trampoline or fill]
      struct sigcontext sf_sc;
      sigset_t sf_mask;
    };
@@ -827,7 +827,7 @@ static const struct tramp_frame mips_lin
 
    struct rt_sigframe {
      u32 rs_ass[4];            [argument save space for o32]
-     u32 rs_code[2]            [signal trampoline]
+     u32 rs_code[2]            [signal trampoline or fill]
      struct siginfo rs_info;
      struct ucontext rs_uc;
    };
@@ -842,7 +842,6 @@ static const struct tramp_frame mips_lin
    };  */
 /* *INDENT-ON* */
 
-#define SIGFRAME_CODE_OFFSET         (4 * 4)
 #define SIGFRAME_SIGCONTEXT_OFFSET   (6 * 4)
 
 #define RTSIGFRAME_SIGINFO_SIZE      128
@@ -871,14 +870,15 @@ mips_linux_o32_sigframe_init (const stru
 {
   struct gdbarch *gdbarch = get_frame_arch (this_frame);
   int ireg, reg_position;
-  CORE_ADDR sigcontext_base = func - SIGFRAME_CODE_OFFSET;
+  CORE_ADDR frame_sp = get_frame_sp (this_frame);
+  CORE_ADDR sigcontext_base;
   const struct mips_regnum *regs = mips_regnum (gdbarch);
   CORE_ADDR regs_base;
 
   if (self == &mips_linux_o32_sigframe)
-    sigcontext_base += SIGFRAME_SIGCONTEXT_OFFSET;
+    sigcontext_base = frame_sp + SIGFRAME_SIGCONTEXT_OFFSET;
   else
-    sigcontext_base += RTSIGFRAME_SIGCONTEXT_OFFSET;
+    sigcontext_base = frame_sp + RTSIGFRAME_SIGCONTEXT_OFFSET;
 
   /* I'm not proud of this hack.  Eventually we will have the
      infrastructure to indicate the size of saved registers on a
@@ -947,9 +947,7 @@ mips_linux_o32_sigframe_init (const stru
 			   sigcontext_base + SIGCONTEXT_BADVADDR);
 
   /* Choice of the bottom of the sigframe is somewhat arbitrary.  */
-  trad_frame_set_id (this_cache,
-		     frame_id_build (func - SIGFRAME_CODE_OFFSET,
-				     func));
+  trad_frame_set_id (this_cache, frame_id_build (frame_sp, func));
 }
 
 /* *INDENT-OFF* */
@@ -957,7 +955,7 @@ mips_linux_o32_sigframe_init (const stru
 
   struct rt_sigframe_n32 {
     u32 rs_ass[4];                  [ argument save space for o32 ]
-    u32 rs_code[2];                 [ signal trampoline ]
+    u32 rs_code[2];                 [ signal trampoline or fill ]
     struct siginfo rs_info;
     struct ucontextn32 rs_uc;
   };
@@ -1038,13 +1036,14 @@ mips_linux_n32n64_sigframe_init (const s
 {
   struct gdbarch *gdbarch = get_frame_arch (this_frame);
   int ireg, reg_position;
-  CORE_ADDR sigcontext_base = func - SIGFRAME_CODE_OFFSET;
+  CORE_ADDR frame_sp = get_frame_sp (this_frame);
+  CORE_ADDR sigcontext_base;
   const struct mips_regnum *regs = mips_regnum (gdbarch);
 
   if (self == &mips_linux_n32_rt_sigframe)
-    sigcontext_base += N32_SIGFRAME_SIGCONTEXT_OFFSET;
+    sigcontext_base = frame_sp + N32_SIGFRAME_SIGCONTEXT_OFFSET;
   else
-    sigcontext_base += N64_SIGFRAME_SIGCONTEXT_OFFSET;
+    sigcontext_base = frame_sp + N64_SIGFRAME_SIGCONTEXT_OFFSET;
 
   if (mips_linux_restart_reg_p (gdbarch))
     trad_frame_set_reg_addr (this_cache,
@@ -1082,9 +1081,7 @@ mips_linux_n32n64_sigframe_init (const s
 			   sigcontext_base + N64_SIGCONTEXT_LO);
 
   /* Choice of the bottom of the sigframe is somewhat arbitrary.  */
-  trad_frame_set_id (this_cache,
-		     frame_id_build (func - SIGFRAME_CODE_OFFSET,
-				     func));
+  trad_frame_set_id (this_cache, frame_id_build (frame_sp, func));
 }
 
 static void

--------------040409000908060901040502--
