Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16L0lP31682
	for linux-mips-outgoing; Wed, 6 Feb 2002 13:00:47 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16L0cA31676
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 13:00:38 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 7654F125C8; Wed,  6 Feb 2002 13:00:37 -0800 (PST)
Date: Wed, 6 Feb 2002 13:00:37 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: echristo@redhat.com
Cc: linux-mips@oss.sgi.com, binutils@sources.redhat.com
Subject: PATCH: Modify the mips gas behavior for -g -O
Message-ID: <20020206130037.A29208@lucon.org>
References: <yov5ofj65elj.fsf@broadcom.com> <15454.22661.855423.532827@gladsmuir.algor.co.uk> <20020204083115.C13384@lucon.org> <15454.47823.837119.847975@gladsmuir.algor.co.uk> <20020204172857.A22337@lucon.org> <20020204215804.A2095@nevyn.them.org> <20020205113017.A6144@lucon.org> <20020205135407.A8309@lucon.org> <20020206113259.A15431@dea.linux-mips.net> <20020206124538.A28632@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020206124538.A28632@lucon.org>; from hjl@lucon.org on Wed, Feb 06, 2002 at 12:45:38PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 06, 2002 at 12:45:38PM -0800, H . J . Lu wrote:
> On Wed, Feb 06, 2002 at 11:32:59AM +0100, Ralf Baechle wrote:
> > > 
> > > There is an extra "nop" in the delay slot. I don't think gas is smart
> > > enough to fill the delay slot. I will put back those ".set noredor".
> > 
> > The solution is to move the move instruction in front of the branch
> > instruction.  The assembler will then move it into the delay slot:
> > 
> 
> I found out why it didn't work for me. The problem is -g turns off
> filling  the delay slot. The mips as has
> 
>     case 'g':
>       if (arg == NULL)
>         mips_debug = 2;
>       else    
>         mips_debug = atoi (arg);
>       /* When the MIPS assembler sees -g or -g2, it does not do
>          optimizations which limit full symbolic debugging.  We take 
>          that to be equivalent to -O0.  */
>       if (mips_debug == 2)
>         mips_optimize = 1;
>       break;  
> 
> It doesn't matter of you pass -O to as or not. I'd like to override it
> if -O is seen.
> 
> 

Here is a patch which does what I want. Any comments?

Eric, can you approve

http://sources.redhat.com/ml/binutils/2002-02/msg00028.html

Thanks.


H.J.
----
2002-02-06  H.J. Lu  (hjl@gnu.org)

	* config/tc-mips.c (mips_optimize): Initialize to -2.
	(md_begin): Set mips_optimize to -mips_optimize if it is less
	than 0.
	(md_parse_option): Set mips_optimize to 1 for -g only if it
	is less than 0.

--- gas/config/tc-mips.c.opt	Sun Feb  3 23:47:26 2002
+++ gas/config/tc-mips.c	Wed Feb  6 12:55:39 2002
@@ -431,7 +431,7 @@ static int mips_frame_reg_valid = 0;
    unneeded NOPs and swap branch instructions when possible.  A value
    of 1 means to not swap branches.  A value of 0 means to always
    insert NOPs.  */
-static int mips_optimize = 2;
+static int mips_optimize = -2;
 
 /* Debugging level.  -g sets this to 2.  -gN sets this to N.  -g0 is
    equivalent to seeing no -g option at all.  */
@@ -1020,6 +1020,9 @@ md_begin ()
   int target_cpu_had_mips16 = 0;
   const struct mips_cpu_info *ci;
 
+  if (mips_optimize < 0)
+    mips_optimize = -mips_optimize;
+
   /* GP relative stuff not working for PE */
   if (strncmp (TARGET_OS, "pe", 2) == 0
       && g_switch_value != 0)
@@ -9794,7 +9797,7 @@ md_parse_option (c, arg)
       /* When the MIPS assembler sees -g or -g2, it does not do
          optimizations which limit full symbolic debugging.  We take
          that to be equivalent to -O0.  */
-      if (mips_debug == 2)
+      if (mips_debug == 2 && mips_optimize < 0)
 	mips_optimize = 1;
       break;
 
