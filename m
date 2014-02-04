Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2014 19:58:49 +0100 (CET)
Received: from mail-vb0-f41.google.com ([209.85.212.41]:38214 "EHLO
        mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6836937AbaBDS6qmDxz4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Feb 2014 19:58:46 +0100
Received: by mail-vb0-f41.google.com with SMTP id g10so6200423vbg.0
        for <multiple recipients>; Tue, 04 Feb 2014 10:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SfYU7T412mZLvbxJxmSPOuac37Ye7WmIVCQN9H6jFlk=;
        b=DP/1qkcPnMR9kj3wOVk4wUFaURSMqcPNTbz1eW8A3cLVzcFKtXhmbwX230ssKeZnih
         UYytA4TueiMlN+V8WEVdk4dISxr062U1/xLEPFU4J/u2x9xMz9T9trrsD1ZEFxhm7ezq
         MtI2i0ArcoMIQNQy4QkcmGcI+PCtLNDxVxOXGV3dG3gBHxUguUlOcel4l5omdKeMu0Ci
         s2fhUo4sZH6uCvwgZf7K9DjljBdny+QQN9ZoFjG/QUm6NkTg4DZYSkal0sRY4jIfqyUa
         Of1AwHIh2iZZOQdk3PpezeX0F5cqmlnarOanOOoPuZlgVQisItHc6TkndoUpkeKNdhXc
         FQjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SfYU7T412mZLvbxJxmSPOuac37Ye7WmIVCQN9H6jFlk=;
        b=b/XnEatpb7bnhu3VAfy/QXHwIVBVDZzXY3/hHul0obE4Aj8srKAqMPQ1UPYcWS4gBS
         RkoASHiH1cFd0JhOaiul7TTvty+JGpayJvLbtmYS/XX42kE05lVK4ncMKbe+j0K1vYP8
         h1xbEL9wEQAqhF89eM+ZwWqL3Cz6UDUIZ+Je4=
MIME-Version: 1.0
X-Received: by 10.221.39.138 with SMTP id tm10mr34237306vcb.7.1391540320462;
 Tue, 04 Feb 2014 10:58:40 -0800 (PST)
Received: by 10.220.13.2 with HTTP; Tue, 4 Feb 2014 10:58:40 -0800 (PST)
In-Reply-To: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
References: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
Date:   Tue, 4 Feb 2014 10:58:40 -0800
X-Google-Sender-Auth: Nf3oCEiAGg34OL5xppyEsWHRX3U
Message-ID: <CA+55aFz9+AtK_OnUhH0gspUsXLxZN-MRwKVR5zVPsVGmGpBqxg@mail.gmail.com>
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
X-archive-position: 39210
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

On Tue, Feb 4, 2014 at 10:41 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Still doesn't make sense, because if we need the first sync to stop
> writes from being re-ordered with the ll-sc, we also need the second
> sync to avoid the same.

Presumably octeon doesn't do speculative writes, only *buffered* writes.

So writes move down, not up.

But it looks like Cavium is one of those clown companies that have a
"contact us" button for technical documentation rather than actually
making it available.

Christ, why would anybody do business with a tech company that hides
technical details? Seriously, that just stinks of "we have so many
bugs that we cannot make the documentation available".

                  Linus
