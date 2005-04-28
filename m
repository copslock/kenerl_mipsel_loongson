Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 09:56:36 +0100 (BST)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.51]:7086 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8225734AbVD1I4U>; Thu, 28 Apr 2005 09:56:20 +0100
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 66C5F799AB
	for <linux-mips@linux-mips.org>; Thu, 28 Apr 2005 08:56:00 +0000 (UTC)
Received: from [192.168.0.85] (unknown [83.104.11.251])
	by smtp-1.hotpop.com (Postfix) with ESMTP
	id 1C83B1A0201; Thu, 28 Apr 2005 08:55:56 +0000 (UTC)
Subject: Re: Big Endian au1550
From:	JP <jaypee@hotpop.com>
To:	ppopov@embeddedalley.com
Cc:	Prashant Viswanathan <vprashant@echelon.com>,
	'Manish Lachwani' <mlachwani@mvista.com>,
	linux-mips@linux-mips.org
In-Reply-To: <42705F23.3000402@embeddedalley.com>
References: <5375D9FB1CC3994D9DCBC47C344EEB590165465B@miles.echelon.echcorp.com>
	 <42705F23.3000402@embeddedalley.com>
Content-Type: text/plain
Date:	Thu, 28 Apr 2005 09:56:23 +0100
Message-Id: <1114678583.2729.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Return-Path: <jaypee@hotpop.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

I can confirm that BE works fine on the db1550 board. Just add line

select SYS_SUPPORTS_BIG_ENDIAN

to the db1550 section of arch/mips/Kconfig. That allows you to choose
BE.

I guess all the alchemy boards will work LE and BE. At least allowing
the setting will mean they get tested rather than folk getting put off
by the fact they can't select it.

JP

On Wed, 2005-04-27 at 20:57 -0700, ppopov@embeddedalley.com wrote:
> Prashant Viswanathan wrote:
> 
> >>Prashant Viswanathan wrote:
> >>
> >>    
> >>
> >>>Is there a reason why the default configuration file doesn't support Big
> >>>Endian for the dbAu1550?
> >>>
> >>>Even if I edit .config to set the endianness to "BIG" it seems to change
> >>>      
> >>>
> >>to
> >>    
> >>
> >>>"Little Endian" every time a make is run.
> >>>
> >>>Thanks
> >>>Prashant
> >>>
> >>>
> >>>
> >>>
> >>>      
> >>>
> >>In arch/mips/Kconfig,
> >>
> >>config CPU_LITTLE_ENDIAN
> >>        bool "Generate little endian code"
> >>        default y if ACER_PICA_61 || CASIO_E55 || DDB5074 || DDB5476 ||
> >>DDB5477 || MACH_DECSTATION
> >>|| IBM_WORKPAD || LASAT || MIPS_COBALT || MIPS_ITE8172 || MIPS_IVR ||
> >>SOC_AU1X00 || NEC_OSPREY || OLIVETTI_M700 || SNI_RM200_PCI ||
> >>VICTOR_MPC30X || ZAO_CAPCELLA
> >>        default n if MIPS_EV64120 || MIPS_EV96100 || MOMENCO_OCELOT ||
> >>MOMENCO_OCELOT_G || SGI_IP22 || SGI_IP27 || SGI_IP32 || TOSHIBA_JMR3927
> >>        help
> >>          Some MIPS machines can be configured for either little or big
> >>endian
> >>          byte order. These modes require different kernels. Say Y if your
> >>          machine is little endian, N if it's a big endian machine.
> >>
> >>So, it appears that if you have SOC_AU1X00 set, it will always be
> >>configured little endian.
> >>    
> >>
> >
> >Is there a reason for this? 
> >  
> >
> It's the more common configuration.
> 
> >Many months ago I was able to build a big-endian image and load it on my
> >dbAu1550 (also configured to be BE). I just decided to update and now I find
> >that it is almost as if it is not meant to be built BE.
> >  
> >
> BE should be fine too.  We should fix this in Kconfig.
> 
> Pete
> 
-- 
mailto:jaypee@hotpop.com
http://jaypee.org.uk
