Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3T9nxx27042
	for linux-mips-outgoing; Sun, 29 Apr 2001 02:49:59 -0700
Received: from mailgw1.netvision.net.il (mailgw1.netvision.net.il [194.90.1.14])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3T9nvM27031
	for <linux-mips@oss.sgi.com>; Sun, 29 Apr 2001 02:49:57 -0700
Received: from jungo.com ([194.90.113.98])
	by mailgw1.netvision.net.il (8.9.3/8.9.3) with ESMTP id MAA25897;
	Sun, 29 Apr 2001 12:49:35 +0300 (IDT)
Message-ID: <3AEBE34C.5070009@jungo.com>
Date: Sun, 29 Apr 2001 12:47:56 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Ian Soanes <ians@lineo.com>, Linux/MIPS <linux-mips@oss.sgi.com>,
   FR Linux/MIPS <linux-mips@fnet.fr>
Subject: Re: usermode gdb / remote gdb
References: <3AE67CBA.4060606@jungo.com> <3AE69AAA.76A20F08@lineo.com> <3AE6A795.1080004@jungo.com> <3AE6B14F.B5844932@lineo.com> <3AE70BBA.2BD8B387@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Jun,

I have a problem with your patch:

Jun Sun wrote:

> --- gdb-4.17/gdb/config/mips/mipsel-linux.mh.orig	Mon May 22 18:39:07 2000
> +++ gdb-4.17/gdb/config/mips/mipsel-linux.mh	Mon May 22 18:39:07 2000

Gdb seems to miss those files from the distribution. I have checked out 
its CVS tree, and this is what I got:

[michaels@kobie mips]$ pwd
/home/michaels/CVS/gdb/gdb/config/mips
[michaels@kobie mips]$ ls
CVS/           irix5.mh       nm-mips.h       tm-mips.h 
tm-vr5000el.h  vxmips.mt
bigmips.mt     irix5.mt       nm-news-mips.h  tm-mips64.h    tm-vxmips.h 
    wince.mt
bigmips64.mt   littlemips.mh  nm-riscos.h     tm-mipsm3.h    tm-wince.h 
     xm-irix3.h
decstation.mh  littlemips.mt  riscos.mh       tm-mipsv4.h    tx39.mt 
     xm-irix4.h
decstation.mt  mipsm3.mh      tm-bigmips.h    tm-tx39.h      tx39l.mt 
     xm-irix5.h
embed.mt       mipsm3.mt      tm-bigmips64.h  tm-tx39l.h     vr4100.mt 
     xm-mips.h
embed64.mt     mipsv4.mh      tm-embed.h      tm-vr4100.h    vr4300.mt 
     xm-mipsm3.h
embedl.mt      mipsv4.mt      tm-embed64.h    tm-vr4300.h    vr4300el.mt 
    xm-mipsv4.h
embedl64.mt    news-mips.mh   tm-embedl.h     tm-vr4300el.h  vr4xxx.mt 
     xm-news-mips.h
irix3.mh       nm-irix3.h     tm-embedl64.h   tm-vr4xxx.h    vr4xxxel.mt 
    xm-riscos.h
irix3.mt       nm-irix4.h     tm-irix3.h      tm-vr4xxxel.h  vr5000.mt
irix4.mh       nm-irix5.h     tm-irix5.h      tm-vr5000.h    vr5000el.mt
[michaels@kobie mips]$ ls -l *linux*
ls: *linux*: No such file or directory
[michaels@kobie mips]$ cat CVS/Root
:pserver:anoncvs@anoncvs.cygnus.com:/cvs/src
[michaels@kobie mips]$

So, as I said, there seems to be no support for mips-linux in GDB tree.
Where can I get the gdb-4.17 you were talking about?



-- 
Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
