Received:  by oss.sgi.com id <S553750AbRACSSi>;
	Wed, 3 Jan 2001 10:18:38 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:33521 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553692AbRACSSY>; Wed, 3 Jan 2001 10:18:24 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S867580AbRACSJx>;
	Wed, 3 Jan 2001 16:09:53 -0200
Date:	Wed, 3 Jan 2001 16:09:53 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Harald Koerfgen <Harald.Koerfgen@home.ivm.de>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: SGI/ARCS related fixes
Message-ID: <20010103160953.A3795@bacchus.dhis.org>
References: <XFMail.001231124111.Harald.Koerfgen@home.ivm.de> <Pine.GSO.3.96.1010102190251.22443B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1010102190251.22443B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 02, 2001 at 07:12:57PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 02, 2001 at 07:12:57PM +0100, Maciej W. Rozycki wrote:

> > --- /nfs/cvs/linux-2.3/linux/arch/mips/arc/memory.c     Mon Dec 11 18:07:34 2000
> > +++ linux/arch/mips/arc/memory.c        Sat Dec 30 21:49:32 2000
> > @@ -124,7 +124,7 @@
> >                 size = p->pages << PAGE_SHIFT;
> >                 type = prom_memtype_classify(p->type);
> >  
> > -               add_memory_region(base, pages, type);
> > +               add_memory_region(base, size, type);
> >         }
> >  }
> >  
> 
>  That is fine.  I actually included the fix in my set of memory map
> patches (patch-mips-2.4.0-test11-20001212-mem_map-37) I sent Ralf a few
> days ago.  They still appear to wait to be applied.

I suspect your patch got lost from cvs in the recent disk crash.  I reapplied
it now.

  Ralf
