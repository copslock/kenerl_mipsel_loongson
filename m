Received:  by oss.sgi.com id <S554020AbRBOQQi>;
	Thu, 15 Feb 2001 08:16:38 -0800
Received: from [194.90.113.98] ([194.90.113.98]:3335 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S553746AbRBOQQT>;
	Thu, 15 Feb 2001 08:16:19 -0800
Received: from jungo.com (michaels@kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id TAA04117;
	Thu, 15 Feb 2001 19:20:47 +0200
From:   michaels@jungo.com
Message-ID: <3A8C0079.9B8DDAA@jungo.com>
Date:   Thu, 15 Feb 2001 18:14:49 +0200
Organization: Jungo LTD
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Paul Kleist <paulk@mips.com>
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS R5Kc core configuration
References: <3A8ABA30.1D42A067@jungo.com> <3A8BCC28.32E9E240@mips.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Paul,

What I meant is: when configuring linux for some specific MIPS CPU,
right now there is no MIPS64 CPU option (like there was MIPS32 for
Atlas), therefore I don't know what CPU configuration may be used for
5Kc core. 

Do we have an FPU? What are the permitted CP register operations, and
how do we set up the kernel for 64 bit architecture. I guess there were
another 64 bit CPUs that are configured like the LJA0004 MIPS-5KC that
is sitting on our Core board. 

Are you suggesting that QED's 5261 is a close shot?

Thanks,
Michael.

Paul Kleist wrote:
> 
> Hi Michael,
> 
> what do you mean by the phrase 'that can be used for kernel
> configuration' ?
> 
> You can look at eg. QED or NEC websites for other 64 bit mips
> processors, but they
> are not nescessarily identical implementations so do not be sure that
> you can use
> another processor instead of 5Kc which is a MIPS64 implementation.
> 
> The QED5261 is *close*, and we do have 200/100 MHz boards (core/bus
> freq) that can run
> on Atlas/Malta, and this cpuboard run our Linux also.
> 
> Regards
> Paul Kleist
> 
> michaels@jungo.com wrote:
> >
> > Hello,
> >
> > I have recently started to work with the new R5Kc core from MIPS.
> > It is defined to be 64 Bit. I wonder if you know of other processors
> > that are also 64
> > bits that can be safely used for kernel configuration (R10000 maybe?).
> 
> --
> _    _ ____  ___    Paul Kleist        Mailto:paulk@mips.com
> |\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 43
> | \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
>   TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
>                     Denmark            http://www.mips.com/

-- 
Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D 
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
