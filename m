Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2014 17:35:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18198 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012381AbaJaQfcq9ZAS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2014 17:35:32 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F15D7C6934317;
        Fri, 31 Oct 2014 16:35:23 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 31 Oct 2014 16:35:26 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Fri, 31 Oct 2014 16:35:26 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
Thread-Topic: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
Thread-Index: AQHP9SQynyyKZQdHPUiykN8MJvqg/JxKYQaAgAAFHKA=
Date:   Fri, 31 Oct 2014 16:35:25 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320F62676@LEMAIL01.le.imgtec.org>
References: <1414771394-24314-1-git-send-email-manuel.lauss@gmail.com>
 <5453B53D.7060409@imgtec.com>
In-Reply-To: <5453B53D.7060409@imgtec.com>
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
X-archive-position: 43810
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

> > Tests with MSA and other extensions also appreciated!
> >
> > v6: #undef fp so that the preprocessor does not replace the fp in
> > 	.set fp=64 with $30...  Fixes 64bit build.
> 
> Technically speaking, a maltasmvp_defconfig selects CONFIG_32BIT=y so
> it's still a 32-bit build.
> > [...]
> 
> Ok the fp problem went away but I still have the even/odd errors with my
> tools
> 
> arch/mips/kernel/r4k_switch.S: Assembler messages:
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 1
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 3
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 5
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 7
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 9
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 11
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 13
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 15
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 17
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 19

Could you send me the .s and compile flags?

Matthew 
