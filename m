Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6J1DWRw011925
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Jul 2002 18:13:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6J1DVDf011924
	for linux-mips-outgoing; Thu, 18 Jul 2002 18:13:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6J1DPRw011913
	for <linux-mips@oss.sgi.com>; Thu, 18 Jul 2002 18:13:26 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA07863;
	Thu, 18 Jul 2002 18:13:57 -0700
Message-ID: <3D3765F1.6050606@mvista.com>
Date: Thu, 18 Jul 2002 18:05:53 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: Malta bus error
References: <3D375B4C.9000403@mvista.com> <20020718180759.A2091@lucon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

H. J. Lu wrote:
> On Thu, Jul 18, 2002 at 05:20:28PM -0700, Jun Sun wrote:
> 
>>I got the following bus error on Malta.  Does anybody know what causes the 
>>fault?  Is there anyway to disable the error?  Or we should install a malta 
>>bus_error_handler() to discard this kind of error?
>>
>>Apparently the error has something to do with the code layout as it only 
>>happens when I start to modify an unrelated function( do_ri()).
>>
>>I am using the latest linux_2_4 branch from oss.sgi.com CVS tree.
>>
> 
> 
> I got zero problems with 2.4 kernel on oss as of Jul 11 08:18.
> 

Me neither, until I made the following change.  I of course use my own config 
file.

Using Malta's own BE handler to ignore bus error seems to fix the problem, 
although I am not sure if it is the right fix.

Jun

--- arch/mips/kernel/traps.c.orig       Thu Jul 18 15:39:50 2002
+++ arch/mips/kernel/traps.c    Thu Jul 18 16:49:32 2002
@@ -614,8 +614,7 @@
   */
  asmlinkage void do_ri(struct pt_regs *regs)
  {
-       if (!user_mode(regs))
-               BUG();
+       die_if_kernel("no ll/sc emulation for kernel code", regs);

  #ifndef CONFIG_CPU_HAS_LLSC

Jun
