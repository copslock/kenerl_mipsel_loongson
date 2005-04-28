Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 03:23:33 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:35063 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225477AbVD1CXR>; Thu, 28 Apr 2005 03:23:17 +0100
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 470B018F06; Wed, 27 Apr 2005 19:23:14 -0700 (PDT)
Message-ID: <42704911.3010004@mvista.com>
Date:	Wed, 27 Apr 2005 19:23:13 -0700
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Prashant Viswanathan <vprashant@echelon.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Big Endian au1550
References: <5375D9FB1CC3994D9DCBC47C344EEB590165465A@miles.echelon.echcorp.com>
In-Reply-To: <5375D9FB1CC3994D9DCBC47C344EEB590165465A@miles.echelon.echcorp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Prashant Viswanathan wrote:

>Is there a reason why the default configuration file doesn't support Big
>Endian for the dbAu1550? 
>
>Even if I edit .config to set the endianness to "BIG" it seems to change to
>"Little Endian" every time a make is run.
>
>Thanks
>Prashant
>
>
>  
>
In arch/mips/Kconfig,

config CPU_LITTLE_ENDIAN
        bool "Generate little endian code"
        default y if ACER_PICA_61 || CASIO_E55 || DDB5074 || DDB5476 || 
DDB5477 || MACH_DECSTATION
|| IBM_WORKPAD || LASAT || MIPS_COBALT || MIPS_ITE8172 || MIPS_IVR || 
SOC_AU1X00 || NEC_OSPREY || OLIVETTI_M700 || SNI_RM200_PCI || 
VICTOR_MPC30X || ZAO_CAPCELLA
        default n if MIPS_EV64120 || MIPS_EV96100 || MOMENCO_OCELOT || 
MOMENCO_OCELOT_G || SGI_IP22 || SGI_IP27 || SGI_IP32 || TOSHIBA_JMR3927
        help
          Some MIPS machines can be configured for either little or big 
endian
          byte order. These modes require different kernels. Say Y if your
          machine is little endian, N if it's a big endian machine.

So, it appears that if you have SOC_AU1X00 set, it will always be 
configured little endian.

Thanks
Manish Lachwani
