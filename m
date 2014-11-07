Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 12:05:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17282 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012736AbaKGLFuiSml- convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2014 12:05:50 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 658BEC393F936;
        Fri,  7 Nov 2014 11:05:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 7 Nov 2014 11:05:44 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Fri, 7 Nov 2014 11:05:44 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
CC:     Linux-MIPS <linux-mips@linux-mips.org>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: RE: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
Thread-Topic: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
Thread-Index: AQHP9SQynyyKZQdHPUiykN8MJvqg/JxUc14AgACXORA=
Date:   Fri, 7 Nov 2014 11:05:42 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320F6C533@LEMAIL01.le.imgtec.org>
References: <1414771394-24314-1-git-send-email-manuel.lauss@gmail.com>
 <20141107020204.GA24423@linux-mips.org>
In-Reply-To: <20141107020204.GA24423@linux-mips.org>
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
X-archive-position: 43909
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

> +(mips1) `cfc1 $2,$31'
> make[1]: *** [arch/mips/math-emu/cp1emu.o] Error 1
> make: *** [arch/mips/math-emu] Error 2
> make: *** Waiting for unfinished jobs....

This is the offending code in cp1emu.c:

                        if (is_fpu_owner())
                                asm volatile(
                                        ".set push\n"
                                        "\t.set mips1\n"
                                        "\tcfc1\t%0,$31\n"
                                        "\t.set pop" : "=r" (fcr31));
                        else
                                fcr31 = current->thread.fpu.fcr31;
                        preempt_enable();

I'm not sure how this can have built with binutils 2.23 (as indicated by
Manuel and not built with 2.24). The reason this works with the latest
version of binutils 2.24.x is that cfc1 has been reclassified as not an
FPU instruction.

This just needs the hardfloat annotation adding via the macro as in the
other cases.

Thanks,
Matthew
