Received:  by oss.sgi.com id <S553734AbRAOVV2>;
	Mon, 15 Jan 2001 13:21:28 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:29901 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553724AbRAOVVQ>;
	Mon, 15 Jan 2001 13:21:16 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA12903;
	Mon, 15 Jan 2001 22:21:29 +0100 (MET)
Date:   Mon, 15 Jan 2001 22:21:27 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
In-Reply-To: <20010115181133.A2439@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010115220514.16619Z-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 15 Jan 2001, Florian Lohoff wrote:

> the current cvs kernel crashes in __alloc_bootmem_core here:
> 
> [...]
>         printk("%s, %d memset %p 0 %d\n", __FUNCTION__, __LINE__, ret, size);
>         memset(ret, 0, size);
>         printk("%s, %d\n", __FUNCTION__, __LINE__);
>         return ret;
> [...]
> 
> Output coming:
> 
> __alloc_bootmem_core, 230
> __alloc_bootmem_core, 234 memset 81000000 0 36864
> 
> I guess this is really bogus as the ARCS MEMORY debug gives:
> 
> [0,a8748da0]: base<00000000> pages<00000001> type<Exception Block>              
> [1,a8748dbc]: base<00000001> pages<00000001> type<ARCS Romvec Page>             
> [2,a8748d84]: base<00008002> pages<00000173> type<Standlong Program Pages>      
> [3,a87491cc]: base<00008175> pages<000005cb> type<Generic Free RAM>             
> [4,a874919c]: base<00008740> pages<000000c0> type<ARCS Temp Storage Area>       
> [5,a8749180]: base<00008800> pages<00007800> type<Generic Free RAM>            
> 
> Might this be the sgi/arc bootmem/memory.c doesnt alloc everything
> or frees to much ?

 Thanks for a useful report.  I am the responsible person, it would seem,
as I've rewritten the bootmem allocation code recently to make it
consistent across all the subports and more flexible as well.  I could 
only test the DECstation code so it's possible I screwed up things
elsewhere.  I'll look at the code and I'll provide a patch, either a fix,
if I am able to develop it immediately or some debugging code otherwise.

 As I see prink() works for you could you please also check and report the
memory map as found by the kernel, i.e. the lines output after "Determined
physical RAM map:", if any?  The code is executed very early, before an
actual allocation takes place, so it should run regardless.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
