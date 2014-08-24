Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 02:08:25 +0200 (CEST)
Received: from mail-vc0-f172.google.com ([209.85.220.172]:44589 "EHLO
        mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27005162AbaHYAIYKLLHh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2014 02:08:24 +0200
Received: by mail-vc0-f172.google.com with SMTP id im17so14423786vcb.31
        for <multiple recipients>; Sun, 24 Aug 2014 17:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=m/Mtee8XxMkpqJpxOJHZvkn6B7C+JtegygtQXPJo1D8=;
        b=W0ZST6vWXw4a37uOfKmmcS0I4ivHiNeBQLAOJB4JrhmZ2x6uVy7vNxewcvbHvgapiC
         RJiRfMTqQ4koquh09za6NfCgnBYW7AqcG1kW5m+6QP+/pcYddvmCSxETV6sUIP0MQ0mR
         vrZnVjJRu7Xov4wnDhTeZT4wNny0Q20iEO1uABGQVk9Od70ncQQKiLLEwKhibFKiLjPV
         LNwHwTqI3WFLpdcq2H7wasGM/D0irknfL0WJpOduwjoMTbdq/ndR5mF3lMCRycaz5q6M
         HcZy7MEIyQVk+5QXWdDI0N0eLD1RaoVTe49hFm0jHQX9Mpp/Yh/UPytwX4B/e1D/ieXQ
         0UHQ==
X-Received: by 10.221.48.201 with SMTP id ux9mr2424820vcb.68.1408923835632;
 Sun, 24 Aug 2014 16:43:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.5.135 with HTTP; Sun, 24 Aug 2014 16:43:35 -0700 (PDT)
In-Reply-To: <20140823161456.GA2758@localhost>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
 <CAL1qeaGb-o0P7x4nZPJ+dGfoSKz+2ANrB0gGrBi19TtPxVTAZQ@mail.gmail.com>
 <20140823063113.GC23715@localhost> <201408231556.42571.arnd@arndb.de> <20140823161456.GA2758@localhost>
From:   Rob Herring <robherring2@gmail.com>
Date:   Sun, 24 Aug 2014 18:43:35 -0500
Message-ID: <CAL_JsqLGdZRFXni0Y5Loij3FVfw8RzaizNaRA+_hccXz0opkKw@mail.gmail.com>
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On Sat, Aug 23, 2014 at 11:14 AM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Aug 23, 2014 at 03:56:42PM +0200, Arnd Bergmann wrote:
>> On Saturday 23 August 2014, Olof Johansson wrote:
>> > On Fri, Aug 22, 2014 at 02:10:23PM -0700, Andrew Bresticker wrote:
>> > > On Fri, Aug 22, 2014 at 1:42 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> > > >
>> > > > On Aug 21, 2014 3:05 PM, "Andrew Bresticker" <abrestic@chromium.org> wrote:
>> > > > >
>> > > > > To be consistent with other architectures and to avoid unnecessary
>> > > > > makefile duplication, move all MIPS device-trees to arch/mips/boot/dts
>> > > > > and build them with a common makefile.
>> > > >
>> > > > I recall reading that the ARM organization for DTS files was a bit unfortunate
>> > > > and should have been something like:
>> > > >
>> > > > arch/arm/boot/dts/<vendor>/
>> > > >
>> > > > Is this something we should do for the MIPS and update the other architectures
>> > > > to follow that scheme?
>> > >
>> > > I recall reading that as well and that it would be adopted for ARM64,
>> > > but that hasn't seemed to have happened.  Perhaps Olof (CC'ed) will no
>> > > more.
>> >
>> > Yeah, I highly recommend having a directory per vendor. We didn't on ARM,
>> > and the amount of files in that directory is becoming pretty
>> > insane. Moving to a subdirectory structure later gets messy which is
>> > why we've been holding off on it.
>>
>> Another argument is that we plan to actually move all the dts files out of
>> the kernel into a separate project in the future. We really don't want to
>> have the churn of moving all the files now when they get deleted in one
>> of the next merge windows.
>
> To be honest, I don't see that happening within the forseeable
> future. Some of us maintainers like talking about this, but everyone who
> actually develops have nightmares about this scenario. Nobody knows how
> it'll be done without causing some real serious impact on productivity.
>
>> I don't know if we talked about whether that move should be done for
>> all architectures at the same time. If that is the plan, I think it
>> would be best to not move the MIPS files at all but also wait until
>> they can get removed from the kernel tree.
>
> If MIPS can restructure now before things start growing, then I'd really
> recommend that they do so and not hold off waiting on some event that
> might never happen. :)

Yes, I agree on both points.

Rob
