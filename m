Received:  by oss.sgi.com id <S553865AbQKQBou>;
	Thu, 16 Nov 2000 17:44:50 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:36090 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553829AbQKQBog>;
	Thu, 16 Nov 2000 17:44:36 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id eAH1fi328800;
	Thu, 16 Nov 2000 17:41:44 -0800
Message-ID: <3A148E0C.5056F18A@mvista.com>
Date:   Thu, 16 Nov 2000 17:46:52 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Steve Johnson <stevej@ridgerun.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: RE: MIPS config.in NET configuration
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi Steve,

> I'm trying to add support for a Galileo Tech. EV64120A board,
>building on Pete Popov's work that's already in CVS.  I'm having trouble
>with the "Network device support" menu when I "make xconfig".

xconfig was broken for me the last time I did some powerpc work as
well.  If you want to be really safe, use "make config".

>    If I select "Galileo EV96100 Evaluation board" on the "Machine
>selection" menu, I can't select PPP support in the "Network device
>support" menu because the IP22/Decstation/Baget code in
>arch/mips/config.in eclipses the normal net menu's CONFIG_PPP.  Is there
>a reasonable way to resolve two different environments needing the same
>variable defined?

>    The same problem exists for CONFIG_SERIAL, which is defined by the
>Decstation and doesn't let me use the normal character device 16550 UART
>menu item.

>    Please note that this is only a problem for "make xconfig".  "make
>menuconfig" works correctly and selects one set of responses for network
>devices based on the machine selection.  Is that the solution, that
>everyone in MIPS uses "make menuconfig"?

BTW, I hope that by the end of next week, I'll be able to send Ralf the
latest patches for the ev96100. It's running pretty well now with the
scache enabled, but I found 96100 misconfiguration problems in the sdram
decoders/subdecoders. The DEC tulip (with one small patch), serial.c
(small patch again) also run fine, as well as the 96100 internal
10/100Mbps controllers.

-- 
Pete Popov
MontaVista Software, Inc
ppopov@mvista.com
