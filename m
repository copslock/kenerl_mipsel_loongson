Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UJusk20164
	for linux-mips-outgoing; Wed, 30 Jan 2002 11:56:54 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UJuhd20156
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 11:56:43 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA14813;
	Wed, 30 Jan 2002 19:55:08 +0100 (MET)
Date: Wed, 30 Jan 2002 19:55:08 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Steven J. Hill" <sjhill@cotw.com>
cc: linux-mips@oss.sgi.com, ralf@uni-koblenz.de
Subject: Re: [PATCH] Compiler warnings and remove unused code....
In-Reply-To: <3C582D6E.F86FBFE7@cotw.com>
Message-ID: <Pine.GSO.3.96.1020130193633.8443E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 30 Jan 2002, Steven J. Hill wrote:

> -	p += sprintf(p, "ERR: %10lu\n", irq_err_count);
> +	p += sprintf(p, "ERR: %10lu\n", (unsigned long) irq_err_count.counter);

 This looks bogus.  How about atomic_read()? 

> +#define MAX_NAMELEN 10
> +
> +static struct proc_dir_entry * root_irq_dir;
> +static struct proc_dir_entry * irq_dir [NR_IRQS];
> +
> +static void register_irq_proc (unsigned int irq)
> +{
> +	char name [MAX_NAMELEN];
> +
> +	if (!root_irq_dir || (irq_desc[irq].handler == &no_irq_type) ||
> +			irq_dir[irq])
> +		return;
> +
> +	memset(name, 0, MAX_NAMELEN);
> +	sprintf(name, "%d", irq);
> +
> +	/* create /proc/irq/1234 */
> +	irq_dir[irq] = proc_mkdir(name, root_irq_dir);
> +
> +#if CONFIG_SMP
> +	{
> +		struct proc_dir_entry *entry;
> +
> +		/* create /proc/irq/1234/smp_affinity */
> +		entry = create_proc_entry("smp_affinity", 0600, irq_dir[irq]);
> +
> +		if (entry) {
> +			entry->nlink = 1;
> +			entry->data = (void *)(long)irq;
> +			entry->read_proc = irq_affinity_read_proc;
> +			entry->write_proc = irq_affinity_write_proc;
> +		}
> +
> +		smp_affinity_entry[irq] = entry;
> +	}
> +#endif
> +}
> +

 Any specific need to move it?

> -		ret = KSEG1ADDR(ret);
> +		ret = (void *) KSEG1ADDR(ret);

 Hmm, KSEG1ADDR() should probably use typeof(), instead.

>  		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
> -		       MAXMEM>>20);
> +		       (unsigned long) (MAXMEM>>20));

 MAXMEM is int, how about "%d" instead? 

> --- drivers/pci/pci.ids	3 Jan 2002 17:20:28 -0000	1.3
> +++ drivers/pci/pci.ids	30 Jan 2002 17:20:50 -0000

 Are you sure it belongs here?  Or is needed at all? 

 Otherwise OK, I think, unless I missed something. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
