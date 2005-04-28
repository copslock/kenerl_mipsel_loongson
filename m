Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 04:44:51 +0100 (BST)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:63525 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225534AbVD1Dof>;
	Thu, 28 Apr 2005 04:44:35 +0100
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Wed, 27 Apr 2005 20:44:34 -0700
Received: by miles.echelon.echcorp.com with Internet Mail Service (5.5.2653.19)
	id <JWPMNM7D>; Wed, 27 Apr 2005 20:44:33 -0700
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB590165465B@miles.echelon.echcorp.com>
From:	Prashant Viswanathan <vprashant@echelon.com>
To:	'Manish Lachwani' <mlachwani@mvista.com>,
	Prashant Viswanathan <vprashant@echelon.com>
Cc:	linux-mips@linux-mips.org
Subject: RE: Big Endian au1550
Date:	Wed, 27 Apr 2005 20:44:32 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips

> Prashant Viswanathan wrote:
> 
> >Is there a reason why the default configuration file doesn't support Big
> >Endian for the dbAu1550?
> >
> >Even if I edit .config to set the endianness to "BIG" it seems to change
> to
> >"Little Endian" every time a make is run.
> >
> >Thanks
> >Prashant
> >
> >
> >
> >
> In arch/mips/Kconfig,
> 
> config CPU_LITTLE_ENDIAN
>         bool "Generate little endian code"
>         default y if ACER_PICA_61 || CASIO_E55 || DDB5074 || DDB5476 ||
> DDB5477 || MACH_DECSTATION
> || IBM_WORKPAD || LASAT || MIPS_COBALT || MIPS_ITE8172 || MIPS_IVR ||
> SOC_AU1X00 || NEC_OSPREY || OLIVETTI_M700 || SNI_RM200_PCI ||
> VICTOR_MPC30X || ZAO_CAPCELLA
>         default n if MIPS_EV64120 || MIPS_EV96100 || MOMENCO_OCELOT ||
> MOMENCO_OCELOT_G || SGI_IP22 || SGI_IP27 || SGI_IP32 || TOSHIBA_JMR3927
>         help
>           Some MIPS machines can be configured for either little or big
> endian
>           byte order. These modes require different kernels. Say Y if your
>           machine is little endian, N if it's a big endian machine.
> 
> So, it appears that if you have SOC_AU1X00 set, it will always be
> configured little endian.

Is there a reason for this? 

Many months ago I was able to build a big-endian image and load it on my
dbAu1550 (also configured to be BE). I just decided to update and now I find
that it is almost as if it is not meant to be built BE.
