Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5EIfKa08216
	for linux-mips-outgoing; Thu, 14 Jun 2001 11:41:20 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5EIfIP08213
	for <linux-mips@oss.sgi.com>; Thu, 14 Jun 2001 11:41:18 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id F1AAE125BA; Thu, 14 Jun 2001 11:41:17 -0700 (PDT)
Date: Thu, 14 Jun 2001 11:41:17 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Richard Henderson <rth@redhat.com>, gcc@gcc.gnu.org,
   binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: DWARF2 exception doesn't work with gcc and gas on MIPS.
Message-ID: <20010614114117.A3092@lucon.org>
References: <20010613212940.A22683@lucon.org> <20010614101951.B28824@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010614101951.B28824@redhat.com>; from rth@redhat.com on Thu, Jun 14, 2001 at 10:19:51AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jun 14, 2001 at 10:19:51AM -0700, Richard Henderson wrote:
> 
> I could have sworn there was an exception_receiver pattern on mips
> to handle this, but I don't see it now.  It's relatively easy to fix;
> see TARGET_LD_BUGGY_LDGP is handled on alpha.
> 

Thanks. This patch seems to fix my problem. But I have several
questions:

1. Is the usage of current_frame_info.args_size right?
2. What should be in the place of [(const_int 4)]?
3. Does it need other patterns for similar situations?
4. Is my patch ok?


H.J.
----
2001-06-14  H.J. Lu <hjl@gnu.org>

	* config/mips/mips.md (exception_receiver): New.

--- gcc/config/mips/mips.md.except	Thu Jun 14 10:34:34 2001
+++ gcc/config/mips/mips.md	Thu Jun 14 11:36:31 2001
@@ -10461,3 +10461,21 @@ ld\\t%2,%1-%S1(%2)\;daddu\\t%2,%2,$31\;j
   [(set_attr "type"	"arith")
    (set_attr "mode"	"DI")
    (set_attr "length"	"40")])
+
+;; For o32, the gp register is call clobbered, so it must
+;; be saved & restored around calls by the caller.  If the call
+;; doesn't return normally (nonlocal goto, or an exception is
+;; thrown), then the code at the exception handler label must
+;; restore the gp register.
+(define_insn "exception_receiver"
+  [(const_int 4)]
+  "mips_abi == ABI_32"
+  "*
+{
+  static char ldgp[40];
+  sprintf (ldgp, \"lw\\t$gp,%ld($sp)\", current_frame_info.args_size);
+  return ldgp;
+}"
+  [(set_attr "type"	"load")
+   (set_attr "mode"	"SI")
+   (set_attr "length"	"4")])
