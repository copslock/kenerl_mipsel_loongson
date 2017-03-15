Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 16:31:52 +0100 (CET)
Received: from mail-yw0-x236.google.com ([IPv6:2607:f8b0:4002:c05::236]:35208
        "EHLO mail-yw0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991129AbdCOPbpfqRPV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 16:31:45 +0100
Received: by mail-yw0-x236.google.com with SMTP id v198so12867257ywc.2;
        Wed, 15 Mar 2017 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tq0riVXh4Dax5bwtFsdHYDqXUlpYU4hJhempylRsnhs=;
        b=TZbAx7b0vsdlqKgXg8kG4sf0dsK6IQE2UPnDDt1jO6rfH++LEEYyZIRmZXUUKv35Yg
         WueB6eYNqWUhdTWUaBL1u0w1yYoLmuoDh+nZSnDQG9WhmpxWK7IMV2bGyLrr70Um0Jb2
         3Z5ppYuAORenJ67i4AnxObJehs/QTi2+KyRX0mFLZWR4qOFDFzOrDNvdrIlBICOBr0fP
         yOHawC+Ejl7EmzQgBG5GaR6wZxfFCm8VWm6Nr24C1sssmS4KmjXHYPmNRoLGI249k5MT
         pXy/IWHufZpsnYBhhT5HvNxgK/ywCHfy09OGBln1d+295bY17IOVZ79Qx6HeseSb5uXm
         U5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tq0riVXh4Dax5bwtFsdHYDqXUlpYU4hJhempylRsnhs=;
        b=dErn8L9FCfXcseb/gyxXUth6/yW7Y9gZIbCebcjkA7y1Up1Xq8ERAuJ2QgnIFJZM84
         w5RVzsFQG/hVu4VqsrlnzU+YVrFIDvqedzdux14PvWDYv/3e7qTw1bmbVtAdNnNzE1uz
         rNCZLroGnDMvrqWE57I1f+YesA8dK5vLp8ksjbjwppa2bhNCqvXo1ewAgdRLTeRLWffe
         BmR6XHWL/+TKb5MVSQ67gwiaYk79TOswdSh3m+hPhs6+kdFNbmnkC/uCWd+5e+zrWiBh
         mUfFi6Yc2mo4jwUB6LigK7TOnQeB8LclWSIRefGkMMpg/iXXjbxjT5gYs6x3quJfC/z3
         YUaw==
X-Gm-Message-State: AFeK/H24DDkzAlxY1li2te4xSmAncISPKl7QXC1y6oe4RoejVbmPNGxWlbP9iHFEJgEy+0Nxy20ahcbr65KxhA==
X-Received: by 10.37.56.208 with SMTP id f199mr2869985yba.183.1489591899537;
 Wed, 15 Mar 2017 08:31:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.163.164 with HTTP; Wed, 15 Mar 2017 08:31:19 -0700 (PDT)
In-Reply-To: <CAOLZvyGRn5JgeRoiHv0AH8LVwLF5MtXF2KwS5Yr5N8QOK6eYnw@mail.gmail.com>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
 <20170313094757.GI2878@jhogan-linux.le.imgtec.org> <20170315092536.GC22089@linux-mips.org>
 <CAOLZvyGRn5JgeRoiHv0AH8LVwLF5MtXF2KwS5Yr5N8QOK6eYnw@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Wed, 15 Mar 2017 08:31:19 -0700
Message-ID: <CAEdQ38FU6H7ThmP2MgUY-uLhf9feZ6US2JwhEQsCuPw9AeV3nQ@mail.gmail.com>
Subject: Re: NFS corruption, fixed by echo 1 > /proc/sys/vm/drop_caches --
 next debugging steps?
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Wed, Mar 15, 2017 at 7:00 AM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
>
> On Wed, Mar 15, 2017 at 10:25 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>>
>> On Mon, Mar 13, 2017 at 09:47:57AM +0000, James Hogan wrote:
>>
>> > >
>> > > Note that the corruption is different across reboots, both in the size
>> > > of the corruption and the location. I saw 1900~ and 1400~ byte
>> > > sequences corrupted on separate occasions, which don't correspond to
>> > > the system's 16kB page size.
>> > >
>> > > I've tested kernels from v3.19 to 4.11-rc1+ (master branch from
>> > > today). All exhibit this behavior with differing frequencies. Earlier
>> > > kernels seem to reproduce the issue less often, while more recent
>> > > kernels reliably exhibit the problem every boot.
>> > >
>> > > How can I further debug this?
>> >
>> > It smells a bit like a DMA / caching issue.
>> >
>> > Can you provide a full kernel log. That might provide some information
>> > about caching that might be relevant (e.g. does dcache have aliases?).
>>
>> The architecture of the BCM1250 SOC used for the BCM91250 boards are
>> fully coherent, S-cache and D-cache are physically indexed and tagged.
>> Only the VIVT (plus the usual ASID tagging) I-cache leaves space for
>> software to screw up cache management but that shouldn't matter for this
>> case, so I suggest to start looking into this from the NFS side.
>
>
> I did Matt's tests on Alchemy (VIPT caches) with kernels 3.18 to 4.11-rc
> against
> an x86 4.9.15 host, and did not see any problems.   Given Ralf's comment
> about the BCM1250 caches, maybe you have bad hardware (BCM board or
> network) ?

I certainly cannot rule that possibility out. If that is the case, I
would like to be sure of it -- see a failure in memtester or something
for instance. Any suggestions? (I have run memtester and never found
anything)

For what its worth, did you determine the cause of the NFS corruption
you reported [1]?

[1] https://www.spinics.net/lists/mips/msg44006.html
