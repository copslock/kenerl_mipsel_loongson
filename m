Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3UHlE517902
	for linux-mips-outgoing; Mon, 30 Apr 2001 10:47:14 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3UHlDM17899
	for <linux-mips@oss.sgi.com>; Mon, 30 Apr 2001 10:47:13 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f3UHkp020019;
	Mon, 30 Apr 2001 10:46:51 -0700
Message-ID: <3AEDA393.653FD026@mvista.com>
Date: Mon, 30 Apr 2001 10:40:35 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Shmulevich <michaels@jungo.com>
CC: Ian Soanes <ians@lineo.com>, Linux/MIPS <linux-mips@oss.sgi.com>,
   FR Linux/MIPS <linux-mips@fnet.fr>
Subject: Re: usermode gdb / remote gdb
References: <3AE67CBA.4060606@jungo.com> <3AE69AAA.76A20F08@lineo.com> <3AE6A795.1080004@jungo.com> <3AE6B14F.B5844932@lineo.com> <3AE70BBA.2BD8B387@mvista.com> <3AEBE34C.5070009@jungo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Michael Shmulevich wrote:
> 
> Jun,
> 
> I have a problem with your patch:
> 
> Jun Sun wrote:
> 
> > --- gdb-4.17/gdb/config/mips/mipsel-linux.mh.orig     Mon May 22 18:39:07 2000
> > +++ gdb-4.17/gdb/config/mips/mipsel-linux.mh  Mon May 22 18:39:07 2000
> 
> Gdb seems to miss those files from the distribution. I have checked out
> its CVS tree, and this is what I got:
> 
> [michaels@kobie mips]$ pwd
> /home/michaels/CVS/gdb/gdb/config/mips
> [michaels@kobie mips]$ ls
> CVS/           irix5.mh       nm-mips.h       tm-mips.h
> tm-vr5000el.h  vxmips.mt
> bigmips.mt     irix5.mt       nm-news-mips.h  tm-mips64.h    tm-vxmips.h
>     wince.mt
> bigmips64.mt   littlemips.mh  nm-riscos.h     tm-mipsm3.h    tm-wince.h
>      xm-irix3.h
> decstation.mh  littlemips.mt  riscos.mh       tm-mipsv4.h    tx39.mt
>      xm-irix4.h
> decstation.mt  mipsm3.mh      tm-bigmips.h    tm-tx39.h      tx39l.mt
>      xm-irix5.h
> embed.mt       mipsm3.mt      tm-bigmips64.h  tm-tx39l.h     vr4100.mt
>      xm-mips.h
> embed64.mt     mipsv4.mh      tm-embed.h      tm-vr4100.h    vr4300.mt
>      xm-mipsm3.h
> embedl.mt      mipsv4.mt      tm-embed64.h    tm-vr4300.h    vr4300el.mt
>     xm-mipsv4.h
> embedl64.mt    news-mips.mh   tm-embedl.h     tm-vr4300el.h  vr4xxx.mt
>      xm-news-mips.h
> irix3.mh       nm-irix3.h     tm-embedl64.h   tm-vr4xxx.h    vr4xxxel.mt
>     xm-riscos.h
> irix3.mt       nm-irix4.h     tm-irix3.h      tm-vr4xxxel.h  vr5000.mt
> irix4.mh       nm-irix5.h     tm-irix5.h      tm-vr5000.h    vr5000el.mt
> [michaels@kobie mips]$ ls -l *linux*
> ls: *linux*: No such file or directory
> [michaels@kobie mips]$ cat CVS/Root
> :pserver:anoncvs@anoncvs.cygnus.com:/cvs/src
> [michaels@kobie mips]$
> 
> So, as I said, there seems to be no support for mips-linux in GDB tree.
> Where can I get the gdb-4.17 you were talking about?
> 

You can probably look around and find the official gdb-4.17 release.

A better bet is to get from the mvista CDK 1.2 release:

ftp://ftp.mvista.com/pub/CDKit/1.2/cd/Source/SRPMS/hhl-gdb-5.0-1.src.rpm

It says gdb 5.0, but I think gdb-4.17 is "embedded" in it.  (If not, let me
know).

If you try to add linux-mips to gdb 5.0, you might want to look into the new
multi-arch structure introduced in gdb 5.0.  It *might* be the reason why
original MIPS stuff is removed.

Good luck.

Jun
