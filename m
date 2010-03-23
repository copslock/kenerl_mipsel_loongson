Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Mar 2010 13:12:26 +0100 (CET)
Received: from mail-qy0-f180.google.com ([209.85.221.180]:60409 "EHLO
        mail-qy0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492263Ab0CWMMW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Mar 2010 13:12:22 +0100
Received: by qyk10 with SMTP id 10so204641qyk.6
        for <multiple recipients>; Tue, 23 Mar 2010 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q1B6QPXNumVW/uh1NLTER5v3sGdf3NFnKu4TEf62kfs=;
        b=stB8nfT3hXHG2JhSwmjSqugBe/xHahTa7RBrjGE1H4h3eFh41k0tb4lCGg7WCYCI5t
         DzHXPazOYWZ46LQV4a1O+A5AZjPkkdGOauEOrANvn/ARou+NHAcL6pooqjfiZWpFhCEA
         jhhauTclZJqEoZ9lzXXI/kohCRuxxBoWjeS4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Eb9vFZVDBus0rbZvTgyO+WGRgk6UECQXshgX7rFrMXxqpVtsFr4fwVGDUdRq2wk7P4
         HL5DFjYEpbzLHrelJIh8vauTz+2g08pPUtwh8f7a0a+/J7ijnkMsDvqihtggAS79uRhA
         mEhRy51A7TdtJu7jLMzCQMD19FSPJytMm5gMI=
MIME-Version: 1.0
Received: by 10.229.188.212 with SMTP id db20mr911377qcb.5.1269346311955; Tue, 
        23 Mar 2010 05:11:51 -0700 (PDT)
In-Reply-To: <28c262361003230146o7bca61e6h3af2062b1172fdb2@mail.gmail.com>
References: <28c262361003230146o7bca61e6h3af2062b1172fdb2@mail.gmail.com>
Date:   Tue, 23 Mar 2010 21:11:51 +0900
Message-ID: <afc622a1003230511o108556f4s5d1282bd3122b3d9@mail.gmail.com>
Subject: Re: data consistency of high page
From:   NamJae Jeon <linkinjeon@gmail.com>
To:     Minchan Kim <minchan.kim@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <linkinjeon@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linkinjeon@gmail.com
Precedence: bulk
X-list: linux-mips

Hi. Ralf.

I'm Namjae.jeon. nice to meet you.

I face cache aliasing problem on mips 34ke.

Our target cache is 34kB 4way i/d-cache , 32bytes linesize.

As you know, there is possibility of cache aliasing on 8kB per way.

But mips arch of kernel mainline can not properly  handile this case.

For example, highmem handling in __fluash_dcache_page function is just return.

So, if argument page is page in highmem, it can not flush in dcache line.

I want to listen your opinion.

Thanks.


2010/3/23 Minchan Kim <minchan.kim@gmail.com>:
> Hi, Ralf.
>
> Below is thread long time ago.
> At that time, we can't end up the problem by some reason.
> Sorry for that.
>
> The problem would occur, again.
>
> On Fri, Oct 16, 2009 at 6:24 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Fri, Oct 16, 2009 at 02:17:19PM +0900, Minchan Kim wrote:
>>
>>> Many code of kernel fs usually allocate high page and flush.
>>> But flush_dcache_page of mips checks PageHighMem to avoid flush
>>> so that data consistency is broken, I think.
>>
>> What processor and cache configuration?
>>
>>> I found it's by you and Atsushi-san on 585fa724.
>>> Why do we need the check?
>>> Could you elaborte please?
>>
>> The if statement exists because __flush_dcache_page would crash if a page
>> is not mapped.  This of course isn't correct but that wasn't a problem
>> since highmem still is only supported on machines that don't have aliases.
>>
>>  Ralf
>>
>
> Our system is following as.
>
> mips 34ke
> primary i-cache 32kB VIPT 4way 32 byte line size.
> primary d-cache 32kB 4way  32 bytes linesize
>
> If you have further questions, Namjae, Could you follow question of Ralf?
>
> --
> Kind regards,
> Minchan Kim
>
