Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UKEHf20656
	for linux-mips-outgoing; Wed, 30 Jan 2002 12:14:17 -0800
Received: from real.realitydiluted.com (real.realitydiluted.com [208.242.241.164])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UKE8d20652
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 12:14:08 -0800
Received: from localhost.localdomain ([127.0.0.1] helo=cotw.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 16W0Ac-0001HB-00; Wed, 30 Jan 2002 13:13:22 -0600
Message-ID: <3C5845CF.A61BF774@cotw.com>
Date: Wed, 30 Jan 2002 13:13:19 -0600
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-mips@oss.sgi.com, ralf@uni-koblenz.de
Subject: Re: [PATCH] Compiler warnings and remove unused code....
References: <Pine.GSO.3.96.1020130193633.8443E-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Wed, 30 Jan 2002, Steven J. Hill wrote:
> 
> > -     p += sprintf(p, "ERR: %10lu\n", irq_err_count);
> > +     p += sprintf(p, "ERR: %10lu\n", (unsigned long) irq_err_count.counter);
> 
>  This looks bogus.  How about atomic_read()?
> 
Well, duh! Yeah, that would be better.

> > +#define MAX_NAMELEN 10
> > +
> > +static struct proc_dir_entry * root_irq_dir;
> > +static struct proc_dir_entry * irq_dir [NR_IRQS];
> > +
> > +static void register_irq_proc (unsigned int irq)
> > +{
> > +     char name [MAX_NAMELEN];
> > +
> > +     if (!root_irq_dir || (irq_desc[irq].handler == &no_irq_type) ||
> > +                     irq_dir[irq])
> > +             return;
> > +
> > +     memset(name, 0, MAX_NAMELEN);
> > +     sprintf(name, "%d", irq);
> > +
> > +     /* create /proc/irq/1234 */
> > +     irq_dir[irq] = proc_mkdir(name, root_irq_dir);
> > +
> > +#if CONFIG_SMP
> > +     {
> > +             struct proc_dir_entry *entry;
> > +
> > +             /* create /proc/irq/1234/smp_affinity */
> > +             entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
> > +
> > +             if (entry) {
> > +                     entry->nlink = 1;
> > +                     entry->data = (void *)(long)irq;
> > +                     entry->read_proc = irq_affinity_read_proc;
> > +                     entry->write_proc = irq_affinity_write_proc;
> > +             }
> > +
> > +             smp_affinity_entry[irq] = entry;
> > +     }
> > +#endif
> > +}
> > +
> 
>  Any specific need to move it?
> 
Yes. Eliminates a 'implicit declaration of register_irq_proc' warning.

> > -             ret = KSEG1ADDR(ret);
> > +             ret = (void *) KSEG1ADDR(ret);
> 
>  Hmm, KSEG1ADDR() should probably use typeof(), instead.
> 
Fine.

> >               printk(KERN_WARNING "Warning only %ldMB will be used.\n",
> > -                    MAXMEM>>20);
> > +                    (unsigned long) (MAXMEM>>20));
> 
>  MAXMEM is int, how about "%d" instead?
> 
Fine.

> > --- drivers/pci/pci.ids       3 Jan 2002 17:20:28 -0000       1.3
> > +++ drivers/pci/pci.ids       30 Jan 2002 17:20:50 -0000
> 
>  Are you sure it belongs here?  Or is needed at all?
> 
What happens is that when 'gendev' is ran to produce devlist.h, without
the patch it spits on '??? trigraph' warnings. By escaping them, the
warning disappears.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
