Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7ENaSr25619
	for linux-mips-outgoing; Tue, 14 Aug 2001 16:36:28 -0700
Received: from surfers.oz.agile.tv (fw.oz.agile.tv [210.9.52.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7ENaQj25616
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 16:36:26 -0700
Received: from oz.agile.tv (IDENT:simong@pacific.oz.agile.tv [192.168.16.16])
	by surfers.oz.agile.tv (8.11.0/8.11.0) with ESMTP id f7ENaCj29675;
	Wed, 15 Aug 2001 09:36:12 +1000
Message-ID: <3B79B9F0.7350BE7F@oz.agile.tv>
Date: Wed, 15 Aug 2001 09:53:20 +1000
From: Simon Gee <simong@oz.agile.tv>
Organization: AgileTV Corporation Australia
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: linux-mips@oss.sgi.com, gcc-bugs@gcc.gnu.org
Subject: Re: MIPS, profiling, and not working
References: <20010814150924.A19477@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>
>         .set    noreorder
>         .set    noat
>         move    $1,$31          # save current return address
>         jal     _mcount
>         subu    $sp,$sp,8               # _mcount pops 2 words from  stack
>         .set    reorder
>         .set    at
>

Given this assembler sequence, which is produced by:

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

in mips.h, wouldn't the positioning of "subu $sp,$sp,8" imply that it was
intended to be within "jal"'s delay slot (the expansion of jal is really
annoying!) ? This being the case, the stack adjustment may have had to have
been made before the call to _mcount is made.

Simon
