Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2005 23:10:44 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:44275 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225313AbVCPXK3>; Wed, 16 Mar 2005 23:10:29 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 5CB4018B9A; Wed, 16 Mar 2005 15:10:27 -0800 (PST)
Message-ID: <4238BCE3.2030003@mvista.com>
Date:	Wed, 16 Mar 2005 15:10:27 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ellis@spinics.net
Cc:	linux-mips@linux-mips.org
Subject: Re: Little Endian
References: <200503162247.j2GMlXPh017146@localhost.localdomain>
In-Reply-To: <200503162247.j2GMlXPh017146@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

ellis@spinics.net wrote:

>I'm just starting to look at a porting project. The board I'll
>be using is little endian and the CVS version of the kernel
>source doesn't have anything but big endian in the config
>menu. Does little endian work at all and if so, how do I 
>select it?
>
>--
>http://www.spinics.net/linux/
>
>  
>
When you do "make menuconfig", under "Machine Selection" item, there is 
an option called "Generate little endian code". Is this what you are 
looking for? This is a config option CONFIG_CPU_LITTLE_ENDIAN. This is 
defined in arch/mips/Kconfig:

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
                                                                                                   

Thanks
Manish Lachwani
