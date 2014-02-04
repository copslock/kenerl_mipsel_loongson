Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2014 20:17:09 +0100 (CET)
Received: from mail-ve0-f177.google.com ([209.85.128.177]:55301 "EHLO
        mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834791AbaBDTRE5npbQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Feb 2014 20:17:04 +0100
Received: by mail-ve0-f177.google.com with SMTP id jz11so6236457veb.8
        for <multiple recipients>; Tue, 04 Feb 2014 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oGS/qi8cNlKwaZtYufsHAQ+oJuIWhWItpwsBJkLk+wY=;
        b=e1o2oUawBW5uV3HAl7C9gnvQbqfjzajfgYDkdylB5oSRE/EhNeI+cBgzMvHbAB8xu6
         d7gUH6Q8LUizsbiMfWrm26bwR7gQmUA0DeyHWgsc85/hNl3PB2Y/fPHzNIq02SiWHnmW
         z7hUkJ9zDdfofDE82+RPv2lLoLbrmYLbwDJcDxSiDAib0sSCE2ogdaZeXdXdRNHSF58h
         Qts2KYt19LeN1AGwRfzeYQEtckLPWbHQwjkV7KwMH2yWNhOufpkf0scfDbYECBaqZiXM
         xbN8cU2OEVp3KiRoECEiCt4xNs8kKq9mgJIwI3ylx7kVf1e5RAgDLtYAFqaJID/I6ysw
         KPRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oGS/qi8cNlKwaZtYufsHAQ+oJuIWhWItpwsBJkLk+wY=;
        b=E40enm9JQitBe3s52IstfeGnsKtM3cMrM9KxYXno/lbC3jcsvSnFr3VFRI/0g9TziR
         IOOqP7TMN87OJrEisWxYaRTZmW8sRP2xTc/BB+50DVQLt07FfrqqE7hVPilkh1vNADwd
         vgvw4oV9wkXZDHU13EWZpDSeVynvSlRm90Z6E=
MIME-Version: 1.0
X-Received: by 10.58.255.233 with SMTP id at9mr10988673ved.20.1391541418868;
 Tue, 04 Feb 2014 11:16:58 -0800 (PST)
Received: by 10.220.13.2 with HTTP; Tue, 4 Feb 2014 11:16:58 -0800 (PST)
In-Reply-To: <20140204190535.GC5002@laptop.programming.kicks-ass.net>
References: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
        <CA+55aFz9+AtK_OnUhH0gspUsXLxZN-MRwKVR5zVPsVGmGpBqxg@mail.gmail.com>
        <20140204190535.GC5002@laptop.programming.kicks-ass.net>
Date:   Tue, 4 Feb 2014 11:16:58 -0800
X-Google-Sender-Auth: 7Zp5duukBqkbbUqQluZ2PQ2c_eU
Message-ID: <CA+55aFwiuE+WbNLdeV8sGqZccoXkjg_VFOJ+xKMZUgbFP_sKZw@mail.gmail.com>
Subject: Re: mips octeon memory model questions
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Tue, Feb 4, 2014 at 11:05 AM, Peter Zijlstra
>
>> So writes move down, not up.
>
> Right, but the ll-sc store might move down over a later store.

Unlikely. The thing is, in order for the sc to succeed, it has to
already have hit the cache coherency domain (or at least reserved it -
ie maybe the value is not actually *in* the cache, but the sc needs to
have gotten exclusive access to the cacheline).

So just how do you expect a later store (that is *after* the
conditional branch that tests the result of the sc) to move up before
it?

I'm not saying it's physically impossible: speculation is always
possible. But it would require some rather clever speculative store
buffers or caches and killing of same when mispredicted. Which is
actually fairly unlikely, since stores are seldom - if ever - in the
critical path. IOW, "lots and lots of effort for very little gain".

So I'm personally quite willing to believe that a
sc+conditional-branch+st is quite well ordered without any extra
barriers. I'd be more worried about *reads* moving up past the sc
("doesn't reorder reads" to me would imply not moving across the "ll"
part, but it's quite likely that the "sc" actually counts as both a
read and a write).

Without any visible documentation (see aforementioned "clown company"
comment) all of this is obviously just pure speculation.

              Linus
