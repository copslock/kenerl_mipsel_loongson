Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g17GIiE26159
	for linux-mips-outgoing; Thu, 7 Feb 2002 08:18:44 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g17GIUA26153;
	Thu, 7 Feb 2002 08:18:30 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA17743;
	Thu, 7 Feb 2002 17:18:30 +0100 (MET)
Date: Thu, 7 Feb 2002 17:18:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Steven J. Hill" <sjhill@cotw.com>
cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: [PATCH] Eliminate more compiler warnings...
In-Reply-To: <3C62A3D5.C9F7808E@cotw.com>
Message-ID: <Pine.GSO.3.96.1020207171253.11756G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 7 Feb 2002, Steven J. Hill wrote:

> Please apply this too. Thanks.
[...]
>         printk("%s at 0x%03x-0x%03x,0x%03x on irq %d", hwif->name,
> -               hwif->io_ports[IDE_DATA_OFFSET],
> -               hwif->io_ports[IDE_DATA_OFFSET]+7,
> -               hwif->io_ports[IDE_CONTROL_OFFSET], hwif->irq);
> +               (unsigned int) hwif->io_ports[IDE_DATA_OFFSET],
> +               (unsigned int) hwif->io_ports[IDE_DATA_OFFSET]+7,
> +               (unsigned int) hwif->io_ports[IDE_CONTROL_OFFSET], hwif->irq);

 Why is it needed?  hwif->io_ports[...] or ide_ioreg_t is short which gets
promoted to int due to varargs automatically. 

 BTW, please send patches to the list as inlined plain text if possible. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
