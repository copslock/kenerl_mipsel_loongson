Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5IHsenC025904
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 10:54:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5IHseUk025903
	for linux-mips-outgoing; Tue, 18 Jun 2002 10:54:40 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5IHsXnC025900
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 10:54:33 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA02786;
	Tue, 18 Jun 2002 10:57:22 -0700
Message-ID: <3D0F7353.20107@mvista.com>
Date: Tue, 18 Jun 2002 10:52:19 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Carsten Langgaard <carstenl@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: 64-bit kernel
References: <3D0F28AE.7B0D822B@mips.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Carsten Langgaard wrote:

> I don't know if anymore has a interest in the 64-bit kernel, but I just
> found this bug (see patch below).
> It would be nice to know, how many are interested in the 64-bit kernel
> and who actually got something running.
> So please rise you voice.
> 


Actually I think there is an increased interestes to 64bit kernel with the 
recent introduction of RM7K and bcm1250 CPUs.

If 64bit kernel gets mature, I think two years down the road we will see 
mid-range CPUs edging into that domain as well.

(Jun is raising his voice....)

Jun


> /Carsten
> 
> Index: include/asm-mips64/exception.h
> ===================================================================
> RCS file:
> /home/repository/sw/linux-2.4.18/include/asm-mips64/exception.h,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 exception.h
> --- include/asm-mips64/exception.h      4 Mar 2002 11:13:25 -0000
> 1.1.1.1
> +++ include/asm-mips64/exception.h      18 Jun 2002 12:18:40 -0000
> @@ -28,7 +28,7 @@
> 
>         .macro  __build_clear_fpe
>         cfc1    a1, fcr31
> -       li      a2, ~(0x3f << 13)
> +       li      a2, ~(0x3f << 12)
>         and     a2, a1
>         ctc1    a2, fcr31
>         STI
> 
> 
> 
> --
> _    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark             http://www.mips.com
> 
> 
> 
> 
