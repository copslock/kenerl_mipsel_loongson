Received:  by oss.sgi.com id <S553775AbRAUV0S>;
	Sun, 21 Jan 2001 13:26:18 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:46589 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553687AbRAUV0D>;
	Sun, 21 Jan 2001 13:26:03 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0LLN2I17528;
	Sun, 21 Jan 2001 13:23:02 -0800
Message-ID: <3A6B5408.81B5DDEC@mvista.com>
Date:   Sun, 21 Jan 2001 13:26:32 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@uni-koblenz.de>
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: test9 problems
References: <3A6A422B.C0EDABD5@mvista.com> <20010121022649.C853@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Sat, Jan 20, 2001 at 05:58:03PM -0800, Pete Popov wrote:
> 
> > I've got a 5231-based board running a test9-ish kernel. The board is
> > quite stable and I don't have any problems using the serial console,
> > running Bonnie, etc.  However, when I enable a virtual terminal and ps2
> > keyboard, I have problems running commands at the virt terminal.  I
> > traced it to the init task seg faulting and getting killed by the
> > kernel, which in turn kills my system. One of the easiest way to
> > reproduce this problem is to try filename completion, such as "ls
> > /etc/nss <tab>" -- hangs just about all the time.  Has anyone else
> > experienced similar problems with any other mips workstation/board?
> 
> Seems to work with other machines.

Thanks Ralf, knowing that helped.  The command line completion failed
when there are more than one matching files or no matching files at all,
which results in an error bell.  A quick experiment definitely pointed
to the error bell as the problem.  I took a look at drivers/char/vt.c
and found this:


#if defined(__i386__) || defined(__alpha__) || defined(__powerpc__) \
    || (defined(__mips__) && defined(CONFIG_ISA)) \
    || (defined(__arm__) && defined(CONFIG_HOST_FOOTBRIDGE))
 
static void
kd_nosound(unsigned long ignored)
{
        /* disable counter 2 */
        outb(inb_p(0x61)&0xFC, 0x61);
        return;
}
 
void
_kd_mksound(unsigned int hz, unsigned int ticks)
{
        static struct timer_list sound_timer = { function: kd_nosound };
        unsigned int count = 0;
        unsigned long flags;
 
        if (hz > 20 && hz < 32767)
                count = 1193180 / hz;
 
        save_flags(flags);
        cli();
        del_timer(&sound_timer);
        if (count) {
                /* enable counter 2 */
                outb_p(inb_p(0x61)|3, 0x61);
                /* set command for counter 2, 2 byte write */
                outb_p(0xB6, 0x43);
                /* select desired HZ */
                outb_p(count & 0xff, 0x42);
                outb((count >> 8) & 0xff, 0x42);
 
                if (ticks) {
                        sound_timer.expires = jiffies+ticks;
                        add_timer(&sound_timer);
                }
        } else
                kd_nosound(0);
        restore_flags(flags);
        return;
}
 
#else
 
void
_kd_mksound(unsigned int hz, unsigned int ticks)
{
}                                 

#endif

I see other mips systems which have defined CONFIG_ISA and I guess I'm
rather surprised that it works on those systems.  I suppose if you
define mips_io_port_base to be equal to the ISA start address, then the
above would work. But then the PCI IO accesses wouldn't work with the
inb(), outb(), etc macros, if the PCI IO space is discontinous from the
ISA IO space -- which it typically is.  The whole inb()/outb() design,
thanks to the x86, really doesn't work all that great for embedded mips
boards -- especially when you start supporting legally ISA devices.

Pete
