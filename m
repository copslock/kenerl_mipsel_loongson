Received:  by oss.sgi.com id <S553786AbRABSYP>;
	Tue, 2 Jan 2001 10:24:15 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:18322 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553780AbRABSYE>;
	Tue, 2 Jan 2001 10:24:04 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA24269;
	Tue, 2 Jan 2001 19:12:58 +0100 (MET)
Date:   Tue, 2 Jan 2001 19:12:57 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
cc:     ralf@uni-koblenz.de, linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: SGI/ARCS related fixes
In-Reply-To: <XFMail.001231124111.Harald.Koerfgen@home.ivm.de>
Message-ID: <Pine.GSO.3.96.1010102190251.22443B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, 31 Dec 2000, Harald Koerfgen wrote:

> wanting to bring my O2 patches up to date I stumbled over some minor hickups.
[...]
> --- /nfs/cvs/linux-2.3/linux/arch/mips/arc/memory.c     Mon Dec 11 18:07:34 2000
> +++ linux/arch/mips/arc/memory.c        Sat Dec 30 21:49:32 2000
> @@ -124,7 +124,7 @@
>                 size = p->pages << PAGE_SHIFT;
>                 type = prom_memtype_classify(p->type);
>  
> -               add_memory_region(base, pages, type);
> +               add_memory_region(base, size, type);
>         }
>  }
>  

 That is fine.  I actually included the fix in my set of memory map
patches (patch-mips-2.4.0-test11-20001212-mem_map-37) I sent Ralf a few
days ago.  They still appear to wait to be applied.

> @@ -143,12 +143,13 @@
>                 addr = boot_mem_map.map[i].addr;
>                 while (addr < boot_mem_map.map[i].addr
>                               + boot_mem_map.map[i].size) {
> -                       ClearPageReserved(virt_to_page(__va(addr)));
> -                       set_page_count(virt_to_page(__va(addr)), 1);
> -                       free_page(__va(addr));
> +                       ClearPageReserved(virt_to_page(addr));
> +                       set_page_count(virt_to_page(addr), 1);
> +                       free_page(addr);
>                         addr += PAGE_SIZE;
>                         freed += PAGE_SIZE;
>                 }
>         }
>         printk("Freeing prom memory: %ldkb freed\n", freed >> 10);
>  }
> +

 That's probably incorrect.  These functions expect a virtual address
while "addr" is a physical address.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
