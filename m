Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 12:03:22 +0200 (CEST)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:59403 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006987AbaH1KDVE0PSa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 12:03:21 +0200
Received: by mail-ig0-f171.google.com with SMTP id l13so7746503iga.4
        for <linux-mips@linux-mips.org>; Thu, 28 Aug 2014 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dLHDAD2fp+x62acsxUo7bC/TwQYjxux2RUnjoBdyv/A=;
        b=SKpsF45oHt8mGWPgNhvjnepSMDgrlIcgC3gX/Lsb+9OtjPirXsggw3RUu/GUGdEDvM
         jeXYM6py7tBeG8xC9JwJ5s6u4gmeEj46N4n4opUBTRJIj+MptxTLTjRB8iqHaxyIJ1hG
         ldIqgUKkaj9Pt9z5qBeXKYwOxa02aA7PQpeisg5nWX0K6mD/HcG25j61aUZxDAhpQJFD
         A3aBwzEnYAyxT0KFbkDQlpb6Lm8u9O/oLSOA/q4O+k6oEjaNpjdJfFF5d2HaaGSvPmNE
         wpGlJuJy3O7b9ASn0VYxNLMtP0dispFLFFjPuqc36auzvdYvDRa1q/1ByV7cVLMe6wLO
         XeZQ==
MIME-Version: 1.0
X-Received: by 10.50.25.65 with SMTP id a1mr2130886igg.3.1409220194573; Thu,
 28 Aug 2014 03:03:14 -0700 (PDT)
Received: by 10.50.135.73 with HTTP; Thu, 28 Aug 2014 03:03:14 -0700 (PDT)
In-Reply-To: <53FEEBA3.9010705@imgtec.com>
References: <CAPweEDznk3iecHkQcaGMd_EZfzZmbAbtXuO9dnePctDxFSWS7Q@mail.gmail.com>
        <20140827114854.GC25985@pburton-laptop>
        <CAPweEDwn95=Oi04H_r1FCDox8Oxd=tP8WAT7ze1urGu2uLJhSA@mail.gmail.com>
        <53FEEBA3.9010705@imgtec.com>
Date:   Thu, 28 Aug 2014 12:03:14 +0200
Message-ID: <CAPweEDwjZhGWbeg0rrP9AVetnzrDtZCi8TtaPO5gjJgH6er_hw@mail.gmail.com>
Subject: Re: rhombus tech eoma68 ingenic jz4775 cpu card
From:   "lkcl ." <luke.leighton@gmail.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <luke.leighton@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42302
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

On Thu, Aug 28, 2014 at 10:43 AM, Zubair Lutfullah Kakakhel
<Zubair.Kakakhel@imgtec.com> wrote:

>>> Did you have anything concrete in mind that would be helpful at this
>>> stage, or are you more judging interest?
>>
>>  bit of both.  background: with 4 CPU cards coming out (ICubeCorp
>> IC1T, Allwinner A20, Allwinner A33 and Ingenic JZ4775) in the next few
>> months and an upcoming (first) crowdfunding campaign i simply won't
>> have time to get everything done myself, so i will kinda need some
>> help.
>
> That's an ambitious list of CPU cards..

 yes - and it makes it clear that the project is most definitely not
about "one product".  basically i have been preparing for a time when
i have enough funding to create the prototype hardware: that's now
happened (nice contract) so i can now get the boards done.  it just so
happens that there are 4 CPU cards ready and 2 base units ready, as i
have a looot of preparing-time available :)

 so, the first "base unit" will be a micro-desktop: this can also act
as a simple test station for the cpu cards; the second base will be a
tablet/netbook PCB.  the first prototypes of the micro-desktop will be
done in about 6 weeks, the tablet/netbook PCB will be a month after
that.

 so, the schedule of arriving hardware that's immediately relevant
will be that in about 6 weeks time i will have 5 JZ4775 CPU Cards
available and 5 micro-desktop base units.  they will be a bit like
gold-dust esp. the micro-desktop bases so i will be happy to loan them
out to anyone willing to help, and maybe give just the one to someone
who can definitely commit to helping with the board bring-up.

 if you and paul are at the same company maybe that would work out well, zubair?

l.
