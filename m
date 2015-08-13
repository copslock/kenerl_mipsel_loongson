Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 01:40:57 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37184 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012527AbbHMXk4Pm0G8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 01:40:56 +0200
Received: by igui7 with SMTP id i7so1768077igu.0
        for <linux-mips@linux-mips.org>; Thu, 13 Aug 2015 16:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vTL2IXuqnqLA++USP56jW/7pYah8VewfUDyHdNH/oDQ=;
        b=h3gBVMzomFXURFaINghXyy7klsjFshQClHLeTCV1ANarytaNen9I3ZXl9PSnROfK77
         Pp+r8g5xSZo8V6EmZDMKgR8/Kxk+EO6iF3YgzVZbgU3zp+zFD7DdmspxcQy0IUSTm6Vs
         3gSVy1OnIk+Ztep9ThpQ3tUCdJDbtmwWonQnW1Eez0TWUOyxaSBVsDDXPyS6w2DVj1Ds
         4UH19/pmntR9kJB6jsp1/nlwCav+ULT8yJ1owPjMTDi8zFwhMKxETSA3/cxDkBkqHrxt
         M6ykYT7Vhj+K9LEutaFk2hyt0AQTz21zrII/lTA1YMwKE3q6Ad44Jbj2xeWN9miEeFin
         LBBg==
X-Received: by 10.50.64.244 with SMTP id r20mr30317522igs.33.1439509250185;
 Thu, 13 Aug 2015 16:40:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.18.132 with HTTP; Thu, 13 Aug 2015 16:40:30 -0700 (PDT)
In-Reply-To: <20150813143528.GC17183@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de> <55CB3F47.3000902@plexistor.com>
 <CAGRGNgUKkaPnyvn30DXyNpdiXQzS6J=1+mQ3ick8C8=bhx_RHA@mail.gmail.com> <20150813143528.GC17183@lst.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Fri, 14 Aug 2015 09:40:30 +1000
Message-ID: <CAGRGNgWXO9fYSf5YxPM9atSCmUdHB_WDB=n8zd=7eWK1GaJU4A@mail.gmail.com>
Subject: Re: RFC: prepare for struct scatterlist entries without page backing
To:     Christoph Hellwig <hch@lst.de>
Cc:     Boaz Harrosh <boaz@plexistor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        axboe@kernel.dk, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-nvdimm@ml01.01.org,
        David Howells <dhowells@redhat.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        =?UTF-8?Q?H=C3=A5vard_Skinnemoen?= <hskinnemoen@gmail.com>,
        linux-xtensa@linux-xtensa.org, grundler@parisc-linux.org,
        Miao Steven <realmz6@gmail.com>, alex.williamson@redhat.com,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-parisc@vger.kernel.org, vgupta@synopsys.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <julian.calaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
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

Hi Christoph,

On Fri, Aug 14, 2015 at 12:35 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Aug 13, 2015 at 09:37:37AM +1000, Julian Calaby wrote:
>> I.e. ~90% of this patch set seems to be just mechanically dropping
>> BUG_ON()s and converting open coded stuff to use accessor functions
>> (which should be macros or get inlined, right?) - and the remaining
>> bit is not flushing if we don't have a physical page somewhere.
>
> Which is was 90%.  By lines changed most actually is the diffs for
> the cache flushing.

I was talking in terms of changes made, not lines changed: by my
recollection, about a third of the patches didn't touch flush calls
and most of the lines changed looked like refactoring so that making
the flush call conditional would be easier.

I guess it smelled like you were doing lots of distinct changes in a
single patch and I got my numbers wrong.

>> Would it make sense to split this patch set into a few bits: one to
>> drop all the useless BUG_ON()s, one to convert all the open coded
>> stuff to accessor functions, then another to do the actual page-less
>> sg stuff?
>
> Without the ifs the BUG_ON() actually are useful to assert we
> never feed the sort of physical addresses we can't otherwise support,
> so I don't think that part is doable.

My point is that there's a couple of patches that only remove
BUG_ON()s, which implies that for that particular driver it doesn't
matter if there's a physical page or not, so therefore that code is
purely "documentation".

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
