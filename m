Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5EJ5k109089
	for linux-mips-outgoing; Thu, 14 Jun 2001 12:05:46 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5EJ5jP09086
	for <linux-mips@oss.sgi.com>; Thu, 14 Jun 2001 12:05:45 -0700
Received: from dot.cygnus.com (dot.cygnus.com [205.180.230.224])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id MAA08606;
	Thu, 14 Jun 2001 12:05:44 -0700 (PDT)
Received: (from rth@localhost)
	by dot.cygnus.com (8.11.0/8.11.0) id f5EJ5hR28916;
	Thu, 14 Jun 2001 12:05:43 -0700
X-Authentication-Warning: dot.cygnus.com: rth set sender to rth@redhat.com using -f
Date: Thu, 14 Jun 2001 12:05:43 -0700
From: Richard Henderson <rth@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: gcc@gcc.gnu.org, binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: DWARF2 exception doesn't work with gcc and gas on MIPS.
Message-ID: <20010614120543.B28888@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	"H . J . Lu" <hjl@lucon.org>, gcc@gcc.gnu.org,
	binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
References: <20010613212940.A22683@lucon.org> <20010614101951.B28824@redhat.com> <20010614114117.A3092@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010614114117.A3092@lucon.org>; from hjl@lucon.org on Thu, Jun 14, 2001 at 11:41:17AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 14, 2001 at 11:41:17AM -0700, H . J . Lu wrote:
> 1. Is the usage of current_frame_info.args_size right?

Yes.

> 2. What should be in the place of [(const_int 4)]?

Some unspec_volatile.

> 3. Does it need other patterns for similar situations?

Yes, O64.

> 4. Is my patch ok?

No.

This one should be ok.


r~


Index: mips.md
===================================================================
RCS file: /cvs/gcc/gcc/gcc/config/mips/mips.md,v
retrieving revision 1.94
diff -c -p -d -r1.94 mips.md
*** mips.md	2001/05/20 00:35:24	1.94
--- mips.md	2001/06/14 18:50:32
***************
*** 30,42 ****
  ;; Number	USE
  ;; 0		movsi_ul
  ;; 1		movsi_us, get_fnaddr
- ;; 2		loadgp
  ;; 3		eh_set_return
  ;; 20		builtin_setjmp_setup
  ;;
  ;; UNSPEC_VOLATILE values
  ;; 0		blockage
  ;; 3		builtin_longjmp
  ;; 10		consttable_qi
  ;; 11		consttable_hi
  ;; 12		consttable_si
--- 30,43 ----
  ;; Number	USE
  ;; 0		movsi_ul
  ;; 1		movsi_us, get_fnaddr
  ;; 3		eh_set_return
  ;; 20		builtin_setjmp_setup
  ;;
  ;; UNSPEC_VOLATILE values
  ;; 0		blockage
+ ;; 2		loadgp
  ;; 3		builtin_longjmp
+ ;; 4		exception_receiver
  ;; 10		consttable_qi
  ;; 11		consttable_hi
  ;; 12		consttable_si
*************** ld\\t%2,%1-%S1(%2)\;daddu\\t%2,%2,$31\;j
*** 9571,9576 ****
--- 9572,9598 ----
  		  operands[0]);
    DONE;
  }")
+ 
+ (define_insn "exception_receiver"
+   [(unspec_volatile [(const_int 0)] 4)]
+   "TARGET_ABICALLS && (mips_abi == ABI_32 || mips_abi == ABI_O64)"
+   "*
+ {
+   rtx loc;
+ 
+   operands[0] = gen_rtx_REG (Pmode, PIC_FUNCTION_ADDR_REGNUM);
+ 
+   if (frame_pointer_needed)
+     loc = hard_frame_pointer_rtx;
+   else
+     loc = stack_pointer_rtx;
+   loc = plus_constant (loc, current_frame_info.args_size);
+   operands[1] = gen_rtx_MEM (Pmode, loc);
+ 
+   return mips_move_1word (operands, insn, 0);
+ }"
+   [(set_attr "type"   "load")
+    (set_attr "length" "8")])
  
  ;;
  ;;  ....................
