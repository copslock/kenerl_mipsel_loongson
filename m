Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7F0H4w26742
	for linux-mips-outgoing; Tue, 14 Aug 2001 17:17:04 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7F0H3j26739
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 17:17:03 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7F0LbA19388;
	Tue, 14 Aug 2001 17:21:39 -0700
Message-ID: <3B79BE22.F679A3D@mvista.com>
Date: Tue, 14 Aug 2001 17:11:14 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Simon Gee <simong@oz.agile.tv>, linux-mips@oss.sgi.com,
   gcc-bugs@gcc.gnu.org
Subject: Re: MIPS, profiling, and not working
References: <20010814150924.A19477@nevyn.them.org> <3B79B9F0.7350BE7F@oz.agile.tv> <20010814164438.A22825@nevyn.them.org>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
> 
> On Wed, Aug 15, 2001 at 09:53:20AM +1000, Simon Gee wrote:
> > >
> > >         .set    noreorder
> > >         .set    noat
> > >         move    $1,$31          # save current return address
> > >         jal     _mcount
> > >         subu    $sp,$sp,8               # _mcount pops 2 words from  stack
> > >         .set    reorder
> > >         .set    at
> > >
> >
> > Given this assembler sequence, which is produced by:
> >
> > /* Output assembler code to FILE to increment profiler label # LABELNO
> >    for profiling a function entry.  */
> >
> > #define FUNCTION_PROFILER(FILE, LABELNO)                                \
> > {                                                                       \
> >   if (TARGET_MIPS16)                                                    \
> >     sorry ("mips16 function profiling");                                \
> >   fprintf (FILE, "\t.set\tnoreorder\n");                                \
> >   fprintf (FILE, "\t.set\tnoat\n");                                     \
> >   fprintf (FILE, "\tmove\t%s,%s\t\t# save current return address\n",    \
> >            reg_names[GP_REG_FIRST + 1], reg_names[GP_REG_FIRST + 31]);  \
> >   fprintf (FILE, "\tjal\t_mcount\n");                                   \
> >   fprintf (FILE,                                                        \
> >            "\t%s\t%s,%s,%d\t\t# _mcount pops 2 words from  stack\n",    \
> >            TARGET_64BIT ? "dsubu" : "subu",                             \
> >            reg_names[STACK_POINTER_REGNUM],                             \
> >            reg_names[STACK_POINTER_REGNUM],                             \
> >            Pmode == DImode ? 16 : 8);                                   \
> >   fprintf (FILE, "\t.set\treorder\n");                                  \
> >   fprintf (FILE, "\t.set\tat\n");                                       \
> > }
> >
> > in mips.h, wouldn't the positioning of "subu $sp,$sp,8" imply that it was
> > intended to be within "jal"'s delay slot (the expansion of jal is really
> > annoying!) ? This being the case, the stack adjustment may have had to have
> > been made before the call to _mcount is made.
> 
> *sigh* Yes, I think the adjustment was meant to be made before the
> call.  Perhaps binutils should warn about things in the "delay slot" of a
> macro?
> 

It is a reasonable warning if we are in "noreorder" state.  Programmers tend
to make assumptions about the delay slot after they do "set .noreorder".

Jun
