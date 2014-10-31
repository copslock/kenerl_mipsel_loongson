Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2014 13:24:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59877 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012367AbaJaMYsvYrXu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2014 13:24:48 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7C399204C736B;
        Fri, 31 Oct 2014 12:24:39 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 31 Oct
 2014 12:24:41 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 31 Oct 2014 12:24:41 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Fri, 31 Oct 2014 12:24:41 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [RFC PATCH v5] MIPS: fix build with binutils 2.24.51+
Thread-Topic: [RFC PATCH v5] MIPS: fix build with binutils 2.24.51+
Thread-Index: AQHP9H+PaTJ6PCgfz0SmTRfnkyHcx5xKFhyAgAAGozA=
Date:   Fri, 31 Oct 2014 12:24:40 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320F603F9@LEMAIL01.le.imgtec.org>
References: <1414700683-121426-1-git-send-email-manuel.lauss@gmail.com>
 <54537551.6080404@imgtec.com>
In-Reply-To: <54537551.6080404@imgtec.com>
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
X-archive-position: 43804
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

> On 10/30/2014 08:24 PM, Manuel Lauss wrote:
> > Starting with version 2.24.51.20140728 MIPS binutils complain loudly
> > about mixing soft-float and hard-float object files, leading to this
> > build failure since GCC is invoked with "-msoft-float" on MIPS:
> >
> > {standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
> >   LD      arch/mips/alchemy/common/built-in.o
> > mipsel-softfloat-linux-gnu-ld: Warning: arch/mips/alchemy/common/built-
> in.o
> >  uses -msoft-float (set by arch/mips/alchemy/common/prom.o),
> >  arch/mips/alchemy/common/sleeper.o uses -mhard-float
> >
> > To fix this, we detect if GAS is new enough to support "-msoft-float"
> command
> > option, and if it does, we can let GCC pass it to GAS;  but then we also
> need
> > to sprinkle the files which make use of floating point registers with
> the
> > necessary ".set hardfloat" directives.
> >
> > Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> > ---
> > Compiles with binutils 2.23 and current git head, 32bit mips32r1 tested
> only.
> >
> > Tests on 64bit and with MSA and other extensions also appreciated!
> > Markos: I can't reproduce the malta defconfig error you're seeing, at
> least
> > not with sourceware sources.
> >
> > v5: fixed issues with code for 32bit mips32r2 using .set mips64r2
> outlined
> >     by Matthew: what the code really wants is 64bit float support, but
> not
> >     64bit mips code.
> >
> > v4: fixed issues outlined by Markos and Matthew.
> >
> > v3: incorporate Maciej's suggestions:
> > 	- detect if gas can handle -msoft-float and ".set hardfloat"
> > 	- apply .set hardfloat only where really necessary
> >
> > v2: cover more files
> >
> > This was introduced in binutils commit
> 351cdf24d223290b15fa991e5052ec9e9bd1e284
> > ("[MIPS] Implement O32 FPXX, FP64 and FP64A ABI extensions").
> >
> 
> Hello,
> 
> I still can't build it with the toolchain I am using over here. This is
> with a regular maltasmvp_defconfig
> 
> arch/mips/kernel/r4k_fpu.S: Assembler messages:
> arch/mips/kernel/r4k_fpu.S:47: Warning: tried to set unrecognized
> symbol: $30=64

Presumably 'fp' is a pre-processor macro for the 'frame pointer' register.
That's really frustrating. I can't think up any smart macro tricks other
than just #undef fp given that the fp register alias does not appear to be
used in this file.

Matthew
