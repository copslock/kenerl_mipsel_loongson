Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2003 18:55:46 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:51699 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225194AbTCUSzp>;
	Fri, 21 Mar 2003 18:55:45 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA28382
	for <linux-mips@linux-mips.org>; Fri, 21 Mar 2003 10:55:43 -0800
Subject: Re: Success! Full CardBus/EXCA on PCI->Cardbus Bridge + DbAU1500
From: Pete Popov <ppopov@mvista.com>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030314135721.G20129@luca.pas.lab>
References: <20030314122352.F20129@luca.pas.lab>
	 <1047677667.18887.162.camel@zeus.mvista.com>
	 <20030314135721.G20129@luca.pas.lab>
Content-Type: text/plain; charset=ISO-8859-1
Organization: MontaVista Software
Message-Id: <1048273049.14211.56.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Mar 2003 10:57:29 -0800
Content-Transfer-Encoding: 8bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Jeff,

I don't touch generic files, especially io.h :), so Ralf will have to
decide whether to apply the patch or not.

Pete

> Additionally, I had to apply the patch to include/asm-mips/io.h in order
> to get the hermes/orinoco drivers to compile. (I posted this patch earlier, and
> someone suggested that the SLOW_DOWN_IO; call was not necessary). Find it below.
> 
> I have some other patches applied; they should not affect PCMCIA. I'll check
> out clean source and patch it with this bare minimum, and let you know
> if something else is required.
> 
> Thanks, Pete -- a FAQ about your patches will really help people who are
> starting out on the Alchemy platform.
> 
> Regards,
> 
> Jeff
> 
> 
>   Index: io.h
>   ===================================================================
>   RCS file: /home/cvs/linux/include/asm-mips/io.h,v
>   retrieving revision 1.29.2.20
>   diff -u -r1.29.2.20 io.h
>   --- io.h        25 Feb 2003 22:03:12 -0000      1.29.2.20
>   +++ io.h        14 Mar 2003 21:50:14 -0000
>   @@ -332,12 +332,25 @@
>           SLOW_DOWN_IO;                                                   \
>    } while(0)
>   °
>   -#define outw_p(val,port)                                               \
>   -do {                                                                   \
>   -       *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) = \
>   -               __ioswab16(val);                                        \
>   -       SLOW_DOWN_IO;                                                   \
>   -} while(0)
>   +/* baitisj */
>   +static inline u16 outw_p(u16 val, unsigned long port)
>   +{
>   +    register u16 retval;
>   +    do {
>   +        retval = *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) =
>   +            __ioswab16(val);
>   +        SLOW_DOWN_IO;
>   +    } while(0);
>   +    return retval;
>   +}
>   +/*°°
>   + *  #define outw_p(val,port)                                           \
>   + *  do {                                                                       \
>   + *     *(volatile u16 *)(mips_io_port_base + __swizzle_addr_w(port)) = \
>   + *             __ioswab16(val);                                        \
>   + *     SLOW_DOWN_IO;                                                   \
>   + *  } while(0)
>   + */
>   °
>    #define outl_p(val,port)                                               \
>    do {                                                                   \
>   
