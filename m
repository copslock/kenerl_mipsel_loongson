Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8T8Zu331282
	for linux-mips-outgoing; Sat, 29 Sep 2001 01:35:56 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8T8ZqD31275
	for <linux-mips@oss.sgi.com>; Sat, 29 Sep 2001 01:35:52 -0700
Received: from lucon.org (lake.in.lucon.org [192.168.0.2])
	by ocean.lucon.org (Postfix) with ESMTP
	id EE041125C6; Sat, 29 Sep 2001 01:35:50 -0700 (PDT)
Received: by lucon.org (Postfix, from userid 1000)
	id 82F86EBA5; Sat, 29 Sep 2001 01:35:49 -0700 (PDT)
Date: Sat, 29 Sep 2001 01:35:49 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Kjeld Borch Egevang <kjelde@mips.com>
Cc: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: Re: gcc crash
Message-ID: <20010929013549.A4044@lucon.org>
References: <Pine.LNX.4.30.0109271657250.1742-100000@coplin19.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0109271657250.1742-100000@coplin19.mips.com>; from kjelde@mips.com on Thu, Sep 27, 2001 at 04:59:47PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 27, 2001 at 04:59:47PM +0200, Kjeld Borch Egevang wrote:
> When I compile the following function with "gcc -O2" the compiler crashes.
> Is this a known problem?
> 
> static float sp_f2l(float x)
> {
>     long l, *xl;
>     float y;
> 
>     xl = (void *)&y;
>     l = x;
>     *xl = l;
>     return y;
> }
> 
> I use gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-97.2)
> 

I back ported this from gcc in CVS to gcc 2.96. It works for me. It
will be in the next RedHat 7.1/mips update.


H.J.
-----
2001-09-29  H.J. Lu <hjl@gnu.org>

	* gcc/emit-rtl.c (subreg_hard_regno): Comment out dubious code.

--- gcc/emit-rtl.c.subreg	Sat Sep 29 01:21:24 2001
+++ gcc/emit-rtl.c	Sat Sep 29 01:22:06 2001
@@ -734,6 +734,7 @@ subreg_hard_regno (x, check_mode)
 
   final_regno = SUBREG_REGNO (x);
 
+#if 0
   /* Punt if what we end up with is not a valid regno in
      the SUBREG's mode, or we went past the end of the inner
      REG's mode, or we overflow past the last hard regno.  */
@@ -743,6 +744,7 @@ subreg_hard_regno (x, check_mode)
 	   HARD_REGNO_NREGS (base_regno, GET_MODE (reg)))
        || final_regno >= FIRST_PSEUDO_REGISTER)
     abort ();
+#endif
 
   return final_regno;
 }
