Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 15:33:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1422 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011212AbbATOdXw-C5U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 15:33:23 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3DFD3FC6390B6;
        Tue, 20 Jan 2015 14:33:15 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 20 Jan 2015 14:33:17 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Tue, 20 Jan 2015 14:33:16 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH RFC v2 12/70] MIPS: asm: asmmacro: Replace add
 instructions with "addui"
Thread-Topic: [PATCH RFC v2 12/70] MIPS: asm: asmmacro: Replace add
 instructions with "addui"
Thread-Index: AQHQNJbUX1Bwba7bIUihtRo4n4BMKpzIyXHA
Date:   Tue, 20 Jan 2015 14:33:15 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320FAC75E@LEMAIL01.le.imgtec.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
 <1421405389-15512-13-git-send-email-markos.chandras@imgtec.com>
 <alpine.LFD.2.11.1501190651440.28301@eddie.linux-mips.org>
 <54BD3355.9010104@imgtec.com>
 <alpine.LFD.2.11.1501191901370.28301@eddie.linux-mips.org>
 <alpine.LFD.2.11.1501191917060.28301@eddie.linux-mips.org>
 <54BE2568.5080105@imgtec.com>
In-Reply-To: <54BE2568.5080105@imgtec.com>
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
X-archive-position: 45371
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

Markos Chandras <Markos.Chandras@imgtec.com> writes:
> On 01/19/2015 07:25 PM, Maciej W. Rozycki wrote:
> > On Mon, 19 Jan 2015, Maciej W. Rozycki wrote:
> >
> >>> sorry i might be missing something but why do you think this is an
> >>> important bug fix that should go into 3.19? the way i read the code it
> >>> seems that it can't go wrong at the moment.
> >>
> >>  We shouldn't be using trapping instructions for address calculation.
> >> These macros have been wrong since the beginning, the MSA instructions
> >> they correspond to do not trigger an exception on an integer overflow
> in
> >> address calculation (none of the MIPS instruction does).
> >
> >  And BTW, it is a bug in GAS too, that it does not accept ADDI for R6 --
> > it should treat the instruction as a macro and expand it to an
> equivalent
> > LI + ADD sequence (using $at or `rd', if available, as a temporary to
> > store the immediate).  Similarly to how microMIPS DADDI is handled for
> > example (where the hardware instruction has an unusually limited range
> of
> > the immediate argument, however GAS accepts any 16-bit).

I suspect this is a discussion best moved to binutils but I have differing
opinions on the value of macros that simply hide the true code that will
be generated. I agree with everything relating to the kernel patch, there
is definitely a 64-bit addressing issue here.

Thanks,
Matthew
