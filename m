Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6R2Lwl02980
	for linux-mips-outgoing; Thu, 26 Jul 2001 19:21:58 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6R2LuV02974
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 19:21:56 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id EAA29260
	for <linux-mips@oss.sgi.com>; Fri, 27 Jul 2001 04:21:55 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15PxGF-0004mx-00
	for <linux-mips@oss.sgi.com>; Fri, 27 Jul 2001 04:21:55 +0200
Date: Fri, 27 Jul 2001 04:21:55 +0200
To: linux-mips@oss.sgi.com
Subject: Re: [patch] fix profiling in glibc for Linux/MIPS
Message-ID: <20010727042155.C27008@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010726181740.A8070@nevyn.them.org>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
[snip]
> > Maybe I'm missing something, but both the old and the new code
> > add 8 byte more to sp than they subtracted before. How is this
> > supposed to work?
> 
> It's supposed to do that, according to GCC.  Build something with -S
> -pg and look at it.

Well, I don't have a 32bit compiler here ATM, only a highly
experimental 64bit one. :-)  But I found in the GCC Code this
snippet in /config/mips.mips.h:

/* Output assembler code to FILE to increment profiler label # LABELNO
   for profiling a function entry.  */
   
#define FUNCTION_PROFILER(FILE, LABELNO)                                \
{                                                                       \
  if (TARGET_MIPS16)                                                    \
    sorry ("mips16 function profiling");                                \
  fprintf (FILE, "\t.set\tnoreorder\n");                                \
  fprintf (FILE, "\t.set\tnoat\n");                                     \
  fprintf (FILE, "\tmove\t%s,%s\t\t# save current return address\n",    \
           reg_names[GP_REG_FIRST + 1], reg_names[GP_REG_FIRST + 31]);  \
  fprintf (FILE, "\tjal\t_mcount\n");                                   \
  fprintf (FILE,                                                        \
           "\t%s\t%s,%s,%d\t\t# _mcount pops 2 words from  stack\n",    \
           TARGET_64BIT ? "dsubu" : "subu",                             \
           reg_names[STACK_POINTER_REGNUM],                             \
           reg_names[STACK_POINTER_REGNUM],                             \
           Pmode == DImode ? 16 : 8);                                   \
  fprintf (FILE, "\t.set\treorder\n");                                  \
  fprintf (FILE, "\t.set\tat\n");                                       \
}

This means, 8 byte is indeed ok for 32bit targets, a 64bit one
would differ by 16 byte (and won't work with the code you've
changed anyway).

Nevertheless, IHMO it would be a good idea to support both targets.

[snip]
> > Why do you save and restore $6, $7, seemingly without using them?
> 
> Because they were already there; I was trying to keep this patch
> minimal.  My MIPS assembly knowledge, as I said, is a little scanty.

Hm, and I have too little knowledge about the profiler to give
helpful advice here.


Thiemo
