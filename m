Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 22:25:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25554 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010751AbbAIVZUUKDez convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 22:25:20 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 06C6C3A3CE779
        for <linux-mips@linux-mips.org>; Fri,  9 Jan 2015 21:25:10 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 9 Jan 2015 21:25:14 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Fri, 9 Jan 2015 21:25:13 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>
Subject: RE: MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS
Thread-Topic: MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS
Thread-Index: AQHQLD4qVjIo4nddzEOeqkawpMt9d5y4Lqrw
Date:   Fri, 9 Jan 2015 21:25:12 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320F9CF6F@LEMAIL01.le.imgtec.org>
References: <1420719457-690-1-git-send-email-paul.burton@imgtec.com>
 <54B024AA.1020400@imgtec.com>
In-Reply-To: <54B024AA.1020400@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.159.69]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45045
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

Leonid Yegoshin <Leonid.Yegoshin@imgtec.com> writes:
> Matthew Fortune - 2015-01-08 12:01:50 
>
> > > +	/* Avoid inadvertently triggering emulation */
> > > +	if ((value & PR_FP_MODE_FR) && cpu_has_fpu &&
> > > +	    !(current_cpu_data.fpu_id & MIPS_FPIR_F64))
> > > +		return -EOPNOTSUPP;
> > > +	if ((value & PR_FP_MODE_FRE) && !cpu_has_fre)
> > > +		return -EOPNOTSUPP;
> >
> > This is perhaps not important immediately but these two cases can
> > be seen as inconsistent. I.e. FR1 is emulated if there is no FPU
> > but FRE is not emulated if there is no FPU.
> >
> > I believe this would be more consistent:
> >
> >	if ((value & PR_FP_MODE_FRE) && cpu_has_fpu &&
> >	    !cpu_has_fre) 
> >		return -EOPNOTSUPP;
> >
> > The kernel then freely emulates any requested mode when there is
> > no FPU but sticks to only true hardware modes when there is an FPU.
> >
> > = More detailed discussion =
> >
> > There has been debate internally at IMG over the issue of FPU emulation
> > so I think it is appropriate to comment on why emulation is not always
> > desirable according to the new o32 FP ABI extensions. I'll try to be
> > brief...
> >
> > The simple reason is that it is obviously better to use a true hardware
> > FPU mode whenever possible. 
>
> I would like to point you to fact that the best choice to use the hardware 
> efficiently is to know which kind of hardware you have. 

From that perspective the PR_SET_FP_MODE does just that except user-mode
discovers the modes by simply trying to use them in order of most desirable
to least desirable. I don't deny that the user code may benefit from knowing
upfront what is available and being able to select an emulated mode if it
*actively* chooses to do so.

> So, it would be much better if application (read - GLIBC/bionic library)
> gets the HW description available in HWCAP and make a choice during library load
> instead of guessing via syscalls in attempt to use one or another FPU/SIMD mode.
> Guessing may easily get a non-optimal HW configuration.

Guessing cannot get a non-optimal mode if the PR_SET_FP_MODE only succeeds for
true hardware modes. What can happen is that the user could fail to find a mode
that it needs even though the kernel could have emulated it. I agree that it may
be a useful to offer the user the opportunity to select an emulated mode though.

> And kernel can just support an application choice via using a real HW or emulation if
> application do some choice because there is no variants (example: FPU absence).

Would your concerns be addressed by adding another bit to the new PR_SET_FP_MODE
option that says the user is willing to accept an emulated mode:

#define PR_FP_MODE_EMU (1<<2)

I do not propose that this is returned from PR_GET_FP_MODE to indicate if
emulation is in use or not though. PR_GET_FP_MODE should just return the mode
in use regardless of emulation.

In addition to this extra control bit the updated behaviour of allowing a
PR_SET_FP_MODE without PR_FP_MODE_EMU should succeed if the current mode
matches the requested mode.

This gives the user the ability to choose a mode falling back to emulation if
they desire. Please bear in mind that this prctl call is for use solely in
dynamic linkers and other similar very low level system code. It is not a
general end user feature.

To find the best mode PR_SET_FP_MODE should then be used as follows with the
use of emulated modes carefully controlled to avoid unnecessary use.

1) dynamic linker needs FR0 mode:
Try PR_FP_MODE_FR0
Try PR_FP_MODE_FR1|PR_FP_MODE_FRE
Try PR_FP_MODE_EMU|PR_FP_MODE_FR0
Try PR_FP_MODE_EMU|PR_FP_MODE_FR1|PR_FP_MODE_FRE

2) dynamic linker needs FR1 mode:
Try PR_FP_MODE_FR1
Try PR_FP_MODE_EMU|PR_FP_MODE_FR1

3) dynamic linker needs FRE mode:
Try PR_FP_MODE_FRE
Try PR_FP_MODE_EMU|PR_FP_MODE_FRE

This is fully compatible with the dynamic linker implementation which is
already committed to glibc but allows the implementation to be extended
in further work to also enable the use of emulated modes. You can go as far
as to have a request to use an emulated mode actually disable an FPU even
if the hardware version of the mode is available!

I do not see any need for HWCAPs for these features as it is such a niche
area. These are fundamental ABI support details that should be hidden as
deeply as possible from an ordinary user.

Thanks,
Matthew
