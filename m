Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACJEMV03911
	for linux-mips-outgoing; Mon, 12 Nov 2001 11:14:22 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACJEG003907
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 11:14:16 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fACJFDB14315;
	Mon, 12 Nov 2001 11:15:13 -0800
Message-ID: <3BF01F6F.D64CEA50@mvista.com>
Date: Mon, 12 Nov 2001 11:13:51 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
References: <Pine.GSO.3.96.1011112194341.24771M-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Mon, 12 Nov 2001, Jun Sun wrote:
> 
> > The /dev/rtc interface is highly influenced by MC146818 chip, which not all
> > RTC devices are alike.  The only fundamental thing in the driver is really the
> > read and write time.
> 
>  You need only to keep the interface, which is:
> 
> static struct file_operations rtc_fops = {
>         owner:          THIS_MODULE,
>         llseek:         no_llseek,
>         read:           rtc_read,
> #if RTC_IRQ
>         poll:           rtc_poll,
> #endif
>         ioctl:          rtc_ioctl,
>         open:           rtc_open,
>         release:        rtc_release,
>         fasync:         rtc_fasync,
> };
> 
> Of these you probably must only implement open() and ioctl() -- you may
> provide others as hardware permits -- see how these functions are
> implemented in drivers/char/rtc.c.  The interface is pretty generic, IMHO.
> 
> > If their abstraction is reasonable, perhaps they can all converge to a better,
> > more generic rtc interface.
> 
>  Just implement the ioctls given hardware permits and return -EINVAL for
> others.  Again, they are pretty generic: get/set the time, alarm, epoch,
> disable/enable various interrupts, etc. -- see include/linux/rtc.h.  You
> may propose additional ioctls if they would be useful for particular
> hardware.
> 

Basically agree.

Maybe the only thing really missing is a formal way to determine and report
the capability of the driver, rather through checking the return value being
-EINVAL.

I guess my original question to Geert is more on the abstraction of the RTC
hardware routines, especially anything beyond rtc_read_time() and
rt_write_time().

Jun
