Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7ENhtK25945
	for linux-mips-outgoing; Tue, 14 Aug 2001 16:43:55 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7ENhrj25938
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 16:43:53 -0700
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15WnrS-0005wu-00; Tue, 14 Aug 2001 16:44:38 -0700
Date: Tue, 14 Aug 2001 16:44:38 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: Simon Gee <simong@oz.agile.tv>
Cc: linux-mips@oss.sgi.com, gcc-bugs@gcc.gnu.org
Subject: Re: MIPS, profiling, and not working
Message-ID: <20010814164438.A22825@nevyn.them.org>
Mail-Followup-To: Simon Gee <simong@oz.agile.tv>, linux-mips@oss.sgi.com,
	gcc-bugs@gcc.gnu.org
References: <20010814150924.A19477@nevyn.them.org> <3B79B9F0.7350BE7F@oz.agile.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <3B79B9F0.7350BE7F@oz.agile.tv>; from simong@oz.agile.tv on Wed, Aug 15, 2001 at 09:53:20AM +1000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 15, 2001 at 09:53:20AM +1000, Simon Gee wrote:
> >
> >         .set    noreorder
> >         .set    noat
> >         move    $1,$31          # save current return address
> >         jal     _mcount
> >         subu    $sp,$sp,8               # _mcount pops 2 words from  stack
> >         .set    reorder
> >         .set    at
> >
> 
> Given this assembler sequence, which is produced by:
> 
> /* Output assembler code to FILE to increment profiler label # LABELNO
>    for profiling a function entry.  */
> 
> #define FUNCTION_PROFILER(FILE, LABELNO)                                \
> {                                                                       \
>   if (TARGET_MIPS16)                                                    \
>     sorry ("mips16 function profiling");                                \
>   fprintf (FILE, "\t.set\tnoreorder\n");                                \
>   fprintf (FILE, "\t.set\tnoat\n");                                     \
>   fprintf (FILE, "\tmove\t%s,%s\t\t# save current return address\n",    \
>            reg_names[GP_REG_FIRST + 1], reg_names[GP_REG_FIRST + 31]);  \
>   fprintf (FILE, "\tjal\t_mcount\n");                                   \
>   fprintf (FILE,                                                        \
>            "\t%s\t%s,%s,%d\t\t# _mcount pops 2 words from  stack\n",    \
>            TARGET_64BIT ? "dsubu" : "subu",                             \
>            reg_names[STACK_POINTER_REGNUM],                             \
>            reg_names[STACK_POINTER_REGNUM],                             \
>            Pmode == DImode ? 16 : 8);                                   \
>   fprintf (FILE, "\t.set\treorder\n");                                  \
>   fprintf (FILE, "\t.set\tat\n");                                       \
> }
> 
> in mips.h, wouldn't the positioning of "subu $sp,$sp,8" imply that it was
> intended to be within "jal"'s delay slot (the expansion of jal is really
> annoying!) ? This being the case, the stack adjustment may have had to have
> been made before the call to _mcount is made.

*sigh* Yes, I think the adjustment was meant to be made before the
call.  Perhaps binutils should warn about things in the "delay slot" of a
macro?

Doing the adjustment before the call would fix the problem that I'm
seeing.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
