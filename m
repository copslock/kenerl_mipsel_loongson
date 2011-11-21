Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 00:43:59 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:57591 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903811Ab1KUXnw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2011 00:43:52 +0100
Received: by wwp14 with SMTP id 14so9075045wwp.24
        for <multiple recipients>; Mon, 21 Nov 2011 15:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=LxI8tjHf94ho4R1RW7YgQB1K4Ndpxhi19EeYXvxXPac=;
        b=x7Kr9+RWPx1gZV6GV7rblIOV7jBjQdTsBM2MtHE+Knylg9EuwlZiYRZWbvVzBjqcy4
         WNzAxkc4/2FhB2N6DI8WEgEQzCGcVKnYfgGnlVKqsAVQli9J2TeWw/vzdEJ/zLEdXQOW
         MMn6XTb6pwxDKUKrgal4KOZc294GGcwE/mDaQ=
Received: by 10.216.133.12 with SMTP id p12mr2312123wei.99.1321919027083; Mon,
 21 Nov 2011 15:43:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.151.168 with HTTP; Mon, 21 Nov 2011 15:43:26 -0800 (PST)
In-Reply-To: <4ECADD83.3090108@caviumnetworks.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
 <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com>
 <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com>
 <4ECACF68.3020701@gmail.com> <CA+55aFwZxqHfEOemj+OJNKCj2toqGf3rkK-9iuS39L7iZsoH1Q@mail.gmail.com>
 <4ECADD83.3090108@caviumnetworks.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Nov 2011 15:43:26 -0800
X-Google-Sender-Auth: -FL2_DQAhXpRba0x1FkjLBxhHsE
Message-ID: <CA+55aFzSNqCOFuvtEc2V1THVOsOVnz6NOa1U_9p5=Y4E=sj6qg@mail.gmail.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and HPAGE_SIZE
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Robin Holt <holt@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18032

On Mon, Nov 21, 2011 at 3:23 PM, David Daney <ddaney@caviumnetworks.com> wrote:
>
> Ok Linus, for you I would recommend against running this git command on your
> tree:
>
> git grep -E '#define.+BUG\(\);'
>
> It's not like there isn't precedence.

So two wrongs make a right?

I do note that almost all the BUG() ones are in the same broken area:
hugepages. There's something wrong with the development there.

I wish people whose code had stuff like that would take a deep look at it.

                        Linus
