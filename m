Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Mar 2003 21:57:24 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:39132 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225202AbTCNV5X>;
	Fri, 14 Mar 2003 21:57:23 +0000
Received: (qmail 6956 invoked by uid 6180); 14 Mar 2003 21:57:21 -0000
Date: Fri, 14 Mar 2003 13:57:21 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: Pete Popov <ppopov@mvista.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Success! Full CardBus/EXCA on PCI->Cardbus Bridge + DbAU1500
Message-ID: <20030314135721.G20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <20030314122352.F20129@luca.pas.lab> <1047677667.18887.162.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1047677667.18887.162.camel@zeus.mvista.com>; from ppopov@mvista.com on Fri, Mar 14, 2003 at 01:34:28PM -0800
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

On Fri, Mar 14, 2003 at 01:34:28PM -0800, Pete Popov wrote:

> Yep, I had to do that way back then when I got the same sort of setup
> working.  Good job figuring that out :)
> 
> Just to confirm, this setup works with the current linux-mips.org plus
> the above info?  No other patches are required, correct?
> 
> I think I'll start an Alchemy/AMD FAQ or something in my directory and
> put this information there. Thanks!

The patches that I'm using:

Pete's 36bit_addr_2.4.21-pre4.patch
Pete's 64bit_pcmcia.patch

Additionally, I had to apply the patch to include/asm-mips/io.h in order
to get the hermes/orinoco drivers to compile. (I posted this patch earlier, and
someone suggested that the SLOW_DOWN_IO; call was not necessary). Find it below.

I have some other patches applied; they should not affect PCMCIA. I'll check
out clean source and patch it with this bare minimum, and let you know
if something else is required.

Thanks, Pete -- a FAQ about your patches will really help people who are
starting out on the Alchemy platform.

Regards,

Jeff


  Index: io.h
  ===================================================================
  RCS file: /home/cvs/linux/include/asm-mips/io.h,v
  retrieving revision 1.29.2.20
  diff -u -r1.29.2.20 io.h
  --- io.h        25 Feb 2003 22:03:12 -0000      1.29.2.20
  +++ io.h        14 Mar 2003 21:50:14 -0000
  @@ -332,12 +332,25 @@
          SLOW_DOWN_IO;                                                   \
   } while(0)
  °
  -#define outw_p(val,port)                                               \
  -do {                                                                   \
  -       *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) = \
  -               __ioswab16(val);                                        \
  -       SLOW_DOWN_IO;                                                   \
  -} while(0)
  +/* baitisj */
  +static inline u16 outw_p(u16 val, unsigned long port)
  +{
  +    register u16 retval;
  +    do {
  +        retval = *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) =
  +            __ioswab16(val);
  +        SLOW_DOWN_IO;
  +    } while(0);
  +    return retval;
  +}
  +/*°°
  + *  #define outw_p(val,port)                                           \
  + *  do {                                                                       \
  + *     *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) = \
  + *             __ioswab16(val);                                        \
  + *     SLOW_DOWN_IO;                                                   \
  + *  } while(0)
  + */
  °
   #define outl_p(val,port)                                               \
   do {                                                                   \
  
> On Fri, 2003-03-14 at 12:23, Jeff Baitis wrote:
> > Everyone:
> > 
> > Thank you very much for helping this green hand get up to speed on the MIPS
> > platform.  I have successfully configured card services to work with the
> > current linux_2_4 CVS, in conjunction with a TI PCI1510 PCI->CardBus bridge.
> > 
> > There are a few card services options that you will need, in order to replicate
> > my work:
> > 
> > 1. The pcmcia_core cis_speed needs to be set to a fairly low value.
> >    I have successfully used `modprobe pcmcia_core cis_speed=10` and 
> >    `modprobe pcmcia_core cis_speed=1.`
> > 
> > 2. The PCMCIA memory window must map into the memory window assigned
> >    by the PCI device autoconfiguration. Since my `lspci -v` shows:
> > 
> >    00:0d.0 CardBus bridge: Texas Instruments: Unknown device ac56
> >        Subsystem: Unknown device 5678:1234
> >        Flags: bus master, medium devsel, latency 168, IRQ 1
> >        Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
> >        Bus: primary=00, secondary=05, subordinate=00, sec-latency=176
> >        Memory window 0: 40001000-40002000 (prefetchable)
> >        Memory window 1: 40400000-407ff000
> >        I/O window 0: 00004000-000040ff
> >        I/O window 1: 00004400-000044ff
> >        16-bit legacy interface ports at 0001
> >  
> >    I configured /etc/pcmcia/config.opts as follows:
> > 
> >        #
> >        # Local PCMCIA Configuration File
> >        #
> >        #----------------------------------------------------------------------
> >        
> >        # System resources available for PCMCIA devices
> >        # remember to modprobe pcmcia_core cis_speed=10
> >        
> >        include port 0x100-0x4ff, port 0xc00-0xcff
> >        include memory 0x40000000-0x40ffffff
> > 
> >        #-------------------------- eof 
> 
> 
> Pete
> 
> 
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
