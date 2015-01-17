Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2015 20:00:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45414 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010174AbbAQTAkD58Mc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jan 2015 20:00:40 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E9A2B42D437F9;
        Sat, 17 Jan 2015 19:00:30 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sat, 17 Jan 2015 19:00:34 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Sat, 17 Jan 2015 19:00:32 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Manuel Lauss <manuel.lauss@gmail.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Subject: RE: 3.18+: soft-float userland unusable due to .MIPS.abiflags patch
Thread-Topic: 3.18+: soft-float userland unusable due to .MIPS.abiflags patch
Thread-Index: AQHQMbZETJL51Hv6jkWZmajb6hjbjpzDCtmAgAARsJCAAA6CgIAAAMIAgAAAiiCAAVhLAIAAIaig
Date:   Sat, 17 Jan 2015 19:00:31 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320FAA1B6@LEMAIL01.le.imgtec.org>
References: <CAOLZvyFP6FX3ydFdU7fmDd7GCnBCAPyLnxkmyjYknXP8Wui0kg@mail.gmail.com>
 <CAOLZvyGBOqCARmLx+rQ1CEgFw2TZBYYauGOiD9tF31MFsB-peQ@mail.gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320FA97DF@LEMAIL01.le.imgtec.org>
 <CAOLZvyGUGr3ubbzNjoFLCEDk29Fbn4qjoT6xmT=F1OZ4L-YhMA@mail.gmail.com>
 <CAOLZvyE7nk4r+gcYTkdbfeDWh6c75RRhijuh-XY=AK98LF81LA@mail.gmail.com>
 <6D39441BF12EF246A7ABCE6654B0235320FA9A04@LEMAIL01.le.imgtec.org>
 <20150117163832.GA12420@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20150117163832.GA12420@fuloong-minipc.musicnaut.iki.fi>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.113]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45246
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

Aaro Koskinen <aaro.koskinen@iki.fi> writes:
> On Fri, Jan 16, 2015 at 08:36:12PM +0000, Matthew Fortune wrote:
> > You are right that it is the .MIPS.abiflags patch that is causing your
> > trouble. For a long time I had to put a restriction in the ABI plan
> > that soft-float binaries without an ABIFLAGS pheader could not be
> > linked against soft-float binaries with an ABIFLAGS pheader. We have
> > since found a way to relax that restriction without reducing the
> > effectiveness of the new compatibility checks. I would need to check
> > the code in the kernel but I suspect that is the issue. Markos has
> > done a significant update to this piece of code which he posted
> > earlier today. That updated version should allow the combination of
> > soft-float without ABIFLAGS and soft-float with ABIFLAGS.
> 
> Are you referring to the series with 70 patches? I think a fix that
> passes stable kernel rules is needed.

Yes it was just one patch though for this issue:
[PATCH RFC v2 68/70] MIPS: kernel: elf: Improve the overall ABI and FPU
mode checks

I wasn't trying to suggest how to fix the existing code just explaining
how it came to be and what has been done about it for next release.
(I'm not a kernel developer I'm just interested as I did most of the
design work for the new ABI extensions.)

I guess there are three options:
a) revert the patch - That would remove the new ABI safety measures from
   3.19 which is a shame given it has MSA support in it (I think anyway).
   equally given that the new prctl FPU mode options did not make 3.19
   then I suppose it doesn't lose too much either as the two features
   go hand in hand to some extent.
b) Fix the broken case - I doubt it will be too challenging to fix up
   the implementation to allow the soft-float ABIFLAGS + no ABIFLAGS
   combination.
c) Apply Markos' updated patch (with the references to r6 removed).

I'll leave it to others to decide which approach is best.

Thanks,
Matthew
