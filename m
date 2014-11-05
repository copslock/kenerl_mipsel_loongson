Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Nov 2014 17:22:50 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13227 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012670AbaKEQWrtoZFo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Nov 2014 17:22:47 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 31E99D885EE29;
        Wed,  5 Nov 2014 16:22:39 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 5 Nov
 2014 16:22:41 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 5 Nov 2014 16:22:41 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Wed, 5 Nov 2014 16:22:40 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
Thread-Topic: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
Thread-Index: AQHP9SQynyyKZQdHPUiykN8MJvqg/JxKYQaAgAACeQCAB9uCEA==
Date:   Wed, 5 Nov 2014 16:22:39 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320F6B3D9@LEMAIL01.le.imgtec.org>
References: <1414771394-24314-1-git-send-email-manuel.lauss@gmail.com>
 <5453B53D.7060409@imgtec.com>
 <CAOLZvyH781d4TALUTCsSGWEzr6dRGmSzaeDKG=bdD8vQoOT2pw@mail.gmail.com>
In-Reply-To: <CAOLZvyH781d4TALUTCsSGWEzr6dRGmSzaeDKG=bdD8vQoOT2pw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.76]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi all,

The issues Markos has seen will be resolved in the toolchain so this
patch is good to go.

Matthew

> -----Original Message-----
> From: Manuel Lauss [mailto:manuel.lauss@gmail.com]
> Sent: 31 October 2014 16:23
> To: Markos Chandras
> Cc: Linux-MIPS; Matthew Fortune; Maciej W. Rozycki; Ralf Baechle
> Subject: Re: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
> 
> I didn't encounter this error with what will be gcc-4.9.3.
> 
> 
> Manuel
> 
> On Fri, Oct 31, 2014 at 5:13 PM, Markos Chandras
> <Markos.Chandras@imgtec.com> wrote:
> > On 10/31/2014 04:03 PM, Manuel Lauss wrote:
> >> Starting with version 2.24.51.20140728 MIPS binutils complain loudly
> >> about mixing soft-float and hard-float object files, leading to this
> >> build failure since GCC is invoked with "-msoft-float" on MIPS:
> >>
> >> {standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
> >>   LD      arch/mips/alchemy/common/built-in.o
> >> mipsel-softfloat-linux-gnu-ld: Warning: arch/mips/alchemy/common/built-
> in.o
> >>  uses -msoft-float (set by arch/mips/alchemy/common/prom.o),
> >>  arch/mips/alchemy/common/sleeper.o uses -mhard-float
> >>
> >> To fix this, we detect if GAS is new enough to support "-msoft-float"
> command
> >> option, and if it does, we can let GCC pass it to GAS;  but then we
> also need
> >> to sprinkle the files which make use of floating point registers with
> the
> >> necessary ".set hardfloat" directives.
> >>
> >> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> >> ---
> >> Compiles with binutils 2.23 and current git head, tested with alchemy
> (mips32r1)
> >> and maltasmvp_defconfig (64bit)
> >>
> >> Tests with MSA and other extensions also appreciated!
> >>
> >> v6: #undef fp so that the preprocessor does not replace the fp in
> >>       .set fp=64 with $30...  Fixes 64bit build.
> >
> > Technically speaking, a maltasmvp_defconfig selects CONFIG_32BIT=y so
> > it's still a 32-bit build.
> >> [...]
> >
> > Ok the fp problem went away but I still have the even/odd errors with my
> > tools
> >
> > arch/mips/kernel/r4k_switch.S: Assembler messages:
> > arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> > was 1
> > arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> > was 3
> > arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> > was 5
> > arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> > was 7
> > arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> > was 9
> > arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> > was 11
> > arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> > was 13
> > arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> > was 15
> > arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> > was 17
> > arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> > was 19
> >
> > The following patch did not help either:
> >
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index 58076472bdd8..b8bb7e170fee 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -56,7 +56,7 @@ ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >    endif
> >  endif
> >  cflags-y += $(call cc-option, -mno-check-zero-division)
> > -
> > +cflags-y += -mno-odd-spreg
> >
> > This is with a regular maltasmvp_defconfig
> >
> > I guess my gcc version is newer than yours. Matthew?
> >
> > --
> > markos
