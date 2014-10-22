Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 16:10:06 +0200 (CEST)
Received: from mail-vc0-f182.google.com ([209.85.220.182]:63575 "EHLO
        mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012133AbaJVOKF2YL5m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 16:10:05 +0200
Received: by mail-vc0-f182.google.com with SMTP id la4so2021332vcb.13
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eQtT3KnejPd/LfpaV7oL2/OQeWetWSl1n6e/esKXa1Q=;
        b=ej1w5S42FMjR8tMeCZRYu96iDmBgg9JSDuabbud0HDkfqxSG1vSCerJls5ffsPplhI
         hslCTgufMTYbBELS4hO2HEPUGdLEYQfyI/NNNgrRpdfMskJGIto8Vz9/PYZp1rGh5zPP
         WeKb47F/x150LecXmybejDhnoI+lCQMsAotL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=eQtT3KnejPd/LfpaV7oL2/OQeWetWSl1n6e/esKXa1Q=;
        b=MbQmJzMWj0Bxkov6a+dEne/b4oJ7jKZg/4hcWbks+n9flQnzkPGtYPRmLemc6+DTI7
         i8+ITlma99toK84Rgu7BRdsviXqnAMYDIGJINRaZ4eQzQct8571IJyRGQ932StgYwfMQ
         9tIoDToPOGAh3SMsUygR3JTTkafCVdvMPZXq0WrJiZyvKfa3uPt3d4NYKF9KlvcZM0pM
         jGnYkZRGEy1dbARQjHSwwfW2V74hCbTdvnEWadgWP8Z+BLEdDyrhekMtit8yeyJhuW7F
         SJ4c3boglACkmolz2teYWx+POpFHxFElMME0E44Vqd8B7ZKMeJdpaCqj38lb+eDXWOWx
         Q6Yg==
X-Gm-Message-State: ALoCoQm1bn31KQ1pIN5Gk54ArPTVh9ONsOt8Nf42F0a7sLRuVCqBmYYUHjWE8z6B0maLrqc78K9x
X-Received: by 10.220.213.197 with SMTP id gx5mr1349450vcb.51.1413986999226;
 Wed, 22 Oct 2014 07:09:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.221.44.8 with HTTP; Wed, 22 Oct 2014 07:09:37 -0700 (PDT)
X-Originating-IP: [2001:470:8:ee7:bd21:7cf6:92dd:9d5c]
In-Reply-To: <20141022080302.GA4037@localhost.localdomain>
References: <1413794538-28465-1-git-send-email-markos.chandras@imgtec.com>
 <20141021110724.GA16479@netboy> <20141021.123544.9516812519754063.davem@davemloft.net>
 <544690CB.4030307@gmail.com> <20141021182757.GA3960@localhost.localdomain>
 <CAOFdcFNYHgupvMChb4NedMsUMAOmE8k0D_F5eRjL-8H8ft=eRw@mail.gmail.com> <20141022080302.GA4037@localhost.localdomain>
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Wed, 22 Oct 2014 10:09:37 -0400
Message-ID: <CAOFdcFO=aLHKtogCf3Sz+XFFcm56JSTi=Om7S+XLdr71YCnFaw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ptp: Fix build failure on MIPS cross builds
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        David Miller <davem@davemloft.net>, markos.chandras@imgtec.com,
        linux-mips@linux-mips.org, corbet@lwn.net, netdev@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <pefoley2@pefoley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pefoley2@pefoley.com
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

On Wed, Oct 22, 2014 at 4:03 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> In the mean time, I would like to restore the testptp.mk that *does*
> cross compile, so that people may use the test program if they
> want. In fact I use this all the time, and so I am a bit annoyed that
> something working was deleted and replaced with something broken.

Sure, I didn't realize that anyone was actually using testptp.mk on a
regular basis.
Feel free to restore it.
