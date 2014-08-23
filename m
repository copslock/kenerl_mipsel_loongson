Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Aug 2014 10:33:43 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:45433 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006672AbaHWQPXJIdsj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Aug 2014 18:15:23 +0200
Received: by mail-pa0-f49.google.com with SMTP id hz1so17949807pad.36
        for <linux-mips@linux-mips.org>; Sat, 23 Aug 2014 09:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3GNpQ0/iygj6w3brcCQRg5OOnvYhAfkOI7m1/FvrkA8=;
        b=DxRif3dYESe7qUkKW2PDUDKlcFEauOA0av/WtheN2Mpj6haOy4gh3mc5Gtmdpjq1ph
         4abiydSVjsjuK1QczqI1jCZ70JDqiQjASNeR+d6Hijka7VbSPWccKLQvgFmv3mfn+cJ6
         A5PD7ZDMZh3pn4sGQI0fM4uGYGU6fuMABfHKrew5KyQc1AojjP7n1XZ89H2CjwcA+5pV
         pg5Xw9RvAFG1PwcCYq127FQ+X5aseM6y/JBebYohFt9b+9jM9+gipwLMA5nbWckf73v7
         Qr+WkPeAPQHsAdWza/FRhqKBVvugBwDnOQdUGceRvomQJgmeDfFgc0s4zunlMHmVrWtv
         VDig==
X-Gm-Message-State: ALoCoQloyPxw0stRXpa5muIk6A6/0f4sHKyZ9K9kHPwoh5oVLrSkFn7JlFS44KSSI85Tvp7s/Vx1
X-Received: by 10.68.190.9 with SMTP id gm9mr3525573pbc.151.1408810516481;
        Sat, 23 Aug 2014 09:15:16 -0700 (PDT)
Received: from localhost (173-13-129-225-sfba.hfc.comcastbusiness.net. [173.13.129.225])
        by mx.google.com with ESMTPSA id oi12sm39194799pdb.79.2014.08.23.09.15.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 23 Aug 2014 09:15:15 -0700 (PDT)
Date:   Sat, 23 Aug 2014 09:14:56 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
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
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
Message-ID: <20140823161456.GA2758@localhost>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
 <CAL1qeaGb-o0P7x4nZPJ+dGfoSKz+2ANrB0gGrBi19TtPxVTAZQ@mail.gmail.com>
 <20140823063113.GC23715@localhost>
 <201408231556.42571.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201408231556.42571.arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <olof@lixom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: olof@lixom.net
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

On Sat, Aug 23, 2014 at 03:56:42PM +0200, Arnd Bergmann wrote:
> On Saturday 23 August 2014, Olof Johansson wrote:
> > On Fri, Aug 22, 2014 at 02:10:23PM -0700, Andrew Bresticker wrote:
> > > On Fri, Aug 22, 2014 at 1:42 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > > >
> > > > On Aug 21, 2014 3:05 PM, "Andrew Bresticker" <abrestic@chromium.org> wrote:
> > > > >
> > > > > To be consistent with other architectures and to avoid unnecessary
> > > > > makefile duplication, move all MIPS device-trees to arch/mips/boot/dts
> > > > > and build them with a common makefile.
> > > >
> > > > I recall reading that the ARM organization for DTS files was a bit unfortunate
> > > > and should have been something like:
> > > >
> > > > arch/arm/boot/dts/<vendor>/
> > > >
> > > > Is this something we should do for the MIPS and update the other architectures
> > > > to follow that scheme?
> > > 
> > > I recall reading that as well and that it would be adopted for ARM64,
> > > but that hasn't seemed to have happened.  Perhaps Olof (CC'ed) will no
> > > more.
> > 
> > Yeah, I highly recommend having a directory per vendor. We didn't on ARM,
> > and the amount of files in that directory is becoming pretty
> > insane. Moving to a subdirectory structure later gets messy which is
> > why we've been holding off on it.
> 
> Another argument is that we plan to actually move all the dts files out of
> the kernel into a separate project in the future. We really don't want to
> have the churn of moving all the files now when they get deleted in one
> of the next merge windows.

To be honest, I don't see that happening within the forseeable
future. Some of us maintainers like talking about this, but everyone who
actually develops have nightmares about this scenario. Nobody knows how
it'll be done without causing some real serious impact on productivity.

> I don't know if we talked about whether that move should be done for
> all architectures at the same time. If that is the plan, I think it
> would be best to not move the MIPS files at all but also wait until
> they can get removed from the kernel tree.

If MIPS can restructure now before things start growing, then I'd really
recommend that they do so and not hold off waiting on some event that
might never happen. :)


-Olof
