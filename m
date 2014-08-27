Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 14:05:26 +0200 (CEST)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:53564 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007010AbaH0MFY53BnR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2014 14:05:24 +0200
Received: by mail-ig0-f182.google.com with SMTP id c1so241512igq.3
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b8HiMLsfPGYVLhex8iSgIx1tp9RYFa4R4k6iX43+CFA=;
        b=cYnhsx7LWztdQCgYrXbhDyyTqs2+QHXZV/zK1EYfuVegO+cJRBioSr2Jwccd+6kwcY
         xt/4XymfD3dHw0uIvGbnnJCzBY3vFT2BsyvXqjHHQT0zOcBgJHrE/mVRYGfs5Uz9V4KX
         SeuMrvslaw7mBhCgbmj1zCbpqwGky7FaR396/dY0PzXKvn2DTUCQhDty7BVZjR1KRGNu
         2ZSOyJTZi/UFoz1DVE91GyNx4Eo94daigKkYgJro80kEts8VmB8iee9o1NDPNvarDpXc
         /xRcknZb8eogYmP7++uOJvBfin+ooHFL5rSuSAOHuvrdvztGkngS2jXOcdzs+iudHrp7
         xcKg==
MIME-Version: 1.0
X-Received: by 10.42.249.20 with SMTP id mi20mr402775icb.90.1409141118840;
 Wed, 27 Aug 2014 05:05:18 -0700 (PDT)
Received: by 10.50.135.73 with HTTP; Wed, 27 Aug 2014 05:05:18 -0700 (PDT)
In-Reply-To: <20140827114854.GC25985@pburton-laptop>
References: <CAPweEDznk3iecHkQcaGMd_EZfzZmbAbtXuO9dnePctDxFSWS7Q@mail.gmail.com>
        <20140827114854.GC25985@pburton-laptop>
Date:   Wed, 27 Aug 2014 13:05:18 +0100
Message-ID: <CAPweEDwn95=Oi04H_r1FCDox8Oxd=tP8WAT7ze1urGu2uLJhSA@mail.gmail.com>
Subject: Re: rhombus tech eoma68 ingenic jz4775 cpu card
From:   "lkcl ." <luke.leighton@gmail.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <luke.leighton@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luke.leighton@gmail.com
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

On Wed, Aug 27, 2014 at 12:48 PM, Paul Burton <paul.burton@imgtec.com> wrote:

> Hi Luke :)

 hii paul, nice to meet you

> That all sounds very interesting! I would definitely be interested in
> getting involved & helping out, and I imagine others at Imagination
> may be too!

 _great_.

> We have recently begun releasing a board based around the jz4780[1] so
> have been doing a fair bit of work on that SoC,

 yehhh i have been waiting a long time for ingenic to come up with a SoC
 that has reasonable (i'd prefer great!) specs that does *not* need proprietary
 libraries, so i have avoided the jz4780 although the GPU has been
 successfully reverse-engineered.

 what i am really looking forward to is when ingenic come out with a quad-core
 FSF-Endorseable SoC: that's when the fun really starts.

> are familiar with some
> of the older SoCs in the jz47xx series and I believe should have access
> to some other jz4775 based boards. There is also the jz4770 based GCW
> zero project[2]

 http://www.gcw-zero.com/specifications very cool.  you might be
interested to know that there is someone creating an eoma68 games
console base unit, with quite high specs (capacitive touchpanel, 5in
1280x720 LCD).

> Did you have anything concrete in mind that would be helpful at this
> stage, or are you more judging interest?

 bit of both.  background: with 4 CPU cards coming out (ICubeCorp
IC1T, Allwinner A20, Allwinner A33 and Ingenic JZ4775) in the next few
months and an upcoming (first) crowdfunding campaign i simply won't
have time to get everything done myself, so i will kinda need some
help.

so it's a "yes let people know the project exists, see who's out
there, who'd like some cool early hardware" and also a "these are the
things that need doing, who'd like to help" enquiry.

and on that list, getting *a* kernel and OS installed is right at the
top!  literally this will be a bare board, direct from the prototyping
company.  then begins the task of working out if the hardware's good
by learning at the same time how to get an OS onto the card *at all*
:)

so that's at the micro-level: at the larger level, to give some
perspective, the goal of the rhombus tech project is to create
desirable mass-volume affordable environmentally-conscious computing
appliances, and inviting software libre developers to be involved with
that process at every step of the way.

it's quite an ambitious long-term project and the EOMA68 standard is a
key part of that, being designed to last at least a decade.

l.
