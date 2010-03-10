Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2010 19:34:15 +0100 (CET)
Received: from mail-fx0-f217.google.com ([209.85.220.217]:44138 "EHLO
        mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492620Ab0CJSeH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Mar 2010 19:34:07 +0100
Received: by fxm9 with SMTP id 9so4148700fxm.24
        for <multiple recipients>; Wed, 10 Mar 2010 10:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1+NTcxS3mtuZBtS5Q7frQkxrLTLE2HzmfAEvFOu4jKI=;
        b=lK11ahXweQmABnK+aIyhWRxditsNPt8A1LB1louXyYTxZlRvVhqVKyD/0b8Ttv40ER
         txSt3L/NxRr1afJDRaEmvV0AXWHO/FLoI1AtFnEFne/imvP/OvzTYVHFCHZ5kbn1ObvA
         Grw5Say6HjD5FPU1/Io47gwbAp5pt3/Ouoc5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S5piBG/+BwGFOEH+GFTtaHLwIQMeHhzmZwYQsRHJO4h0LyMYl67gEYQKDk+IXgljsj
         UYcMcKEiHdRKm/ZR3DzhRAqvFGISaryRvUFDozMZIFcs22WvDXZmFwkjhMcHVryVbn+n
         xnGioH74YO7yhMe7lV0zexNQUqj98ghEEW5aQ=
MIME-Version: 1.0
Received: by 10.223.4.197 with SMTP id 5mr2167111fas.1.1268246040666; Wed, 10 
        Mar 2010 10:34:00 -0800 (PST)
In-Reply-To: <20100310164824.GC15118@linux-mips.org>
References: <1268076181-29642-1-git-send-email-manuel.lauss@gmail.com>
         <1268076181-29642-3-git-send-email-manuel.lauss@gmail.com>
         <4B963210.7030906@ru.mvista.com>
         <f861ec6f1003090345n53570102je68aef14e8b3f3fb@mail.gmail.com>
         <4B96364E.5050202@mvista.com>
         <f861ec6f1003090403j190d0ddbp7e245d0990a62a51@mail.gmail.com>
         <20100310164824.GC15118@linux-mips.org>
Date:   Wed, 10 Mar 2010 19:34:00 +0100
Message-ID: <f861ec6f1003101034u25d2acdcjd6dedc4c2221037e@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: move MMC driver registration to board 
        code.
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 10, 2010 at 5:48 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Mar 09, 2010 at 01:03:51PM +0100, Manuel Lauss wrote:
>
>> And on a personal note, that file just bothers me.  It's messy, can
>> cause merge conflicts,
>
> Eye cancer.
>
>> it references structures defined inside board-specific code. In short,
>> it just plain annoys
>> my sense of aesthetics.
>
> Indeed - and I don't think Sergej disagrees with that.  I agree with him
> that device registration code should primarily be done in the SOC code -

For things like fixed internal interrupts, sure.  But for pieces that depend
on where the (and which) chip is used, not so much.

By this logic there should be tons of ifdefs in the interrupt tables for every
in-tree board.


> but you'll need to somehow get that code to communicate with the platform
> code about what really needs to be done then register the remainder of
> the truely platform-specific platform devices.  Something like that.

I prefer a simpler solution.

Manuel
