Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2016 11:40:45 +0100 (CET)
Received: from mail-ig0-f193.google.com ([209.85.213.193]:34999 "EHLO
        mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008101AbcAKKknxIJXe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jan 2016 11:40:43 +0100
Received: by mail-ig0-f193.google.com with SMTP id mw1so12358935igb.2
        for <linux-mips@linux-mips.org>; Mon, 11 Jan 2016 02:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0pN0FV69zlpTQI2ohnSQK7dmn8H4XSiC8/mJn08ENCg=;
        b=FYGSHXsxzL55BOoO52Hn3Peav4NlIELdtg0kLuq8H+OA8Tj6uLZHaOzYxQn9Ds++Sy
         qW8iHLk5NN+w3LIqPtnRf+JliYNM5qtyuazBCpRXhoqIjLqGP4lNX6q7FgmoL6WwqNFe
         /chmxgav9WU+xxb+Sz5YP+iknZAtSIwRMD1d59flIQbLCebZbd6bTI4bldyV0tDmbmB8
         1POOpMLgyeILlpOPxR15z0Aii7lt6o5aVhiQ59zUcWOArPifH5ib4AQwlOGOi0YMhZjX
         U+3Ac03t32dSTWcnyuwCAJ1W6wb+OGCTEEDe4WJJ7yJlr6NYi6/TjzpHtTA37uNZjDXM
         jZjg==
X-Received: by 10.50.150.66 with SMTP id ug2mr10502747igb.33.1452508837968;
 Mon, 11 Jan 2016 02:40:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.111.1 with HTTP; Mon, 11 Jan 2016 02:40:18 -0800 (PST)
In-Reply-To: <20160111123423-mutt-send-email-mst@redhat.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
 <1452454200-8844-4-git-send-email-mst@redhat.com> <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
 <1452466336.7773.46.camel@perches.com> <20160111123423-mutt-send-email-mst@redhat.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 11 Jan 2016 21:40:18 +1100
Message-ID: <CAGRGNgU7=vNXZbgSwLs+bBueX1+rKACCRMi74hM+jP8MaX+-WA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] checkpatch: add virt barriers
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux <sparclinux@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Return-Path: <julian.calaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51052
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

Hi Michael,

On Mon, Jan 11, 2016 at 9:35 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sun, Jan 10, 2016 at 02:52:16PM -0800, Joe Perches wrote:
>> On Mon, 2016-01-11 at 09:13 +1100, Julian Calaby wrote:
>> > On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > > Add virt_ barriers to list of barriers to check for
>> > > presence of a comment.
>> []
>> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> []
>> > > @@ -5133,7 +5133,8 @@ sub process {
>> > >                 }x;
>> > >                 my $all_barriers = qr{
>> > >                         $barriers|
>> > > -                       smp_(?:$smp_barrier_stems)
>> > > +                       smp_(?:$smp_barrier_stems)|
>> > > +                       virt_(?:$smp_barrier_stems)
>> >
>> > Sorry I'm late to the party here, but would it make sense to write this as:
>> >
>> > (?:smp|virt)_(?:$smp_barrier_stems)
>>
>> Yes.  Perhaps the name might be better as barrier_stems.
>>
>> Also, ideally this would be longest match first or use \b
>> after the matches so that $all_barriers could work
>> successfully without a following \s*\(
>>
>> my $all_barriers = qr{
>>       (?:smp|virt)_(?:barrier_stems)|
>>       $barriers)
>> }x;
>>
>> or maybe add separate $smp_barriers and $virt_barriers
>>
>> <shrug>  it doesn't matter much in any case
>
> OK just to clarify - are you OK with merging the patch as is?
> Refactorings can come as patches on top if required.

I don't really care either way, I was just asking if it was possible.
If you don't see any value in that change, then don't make it.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
