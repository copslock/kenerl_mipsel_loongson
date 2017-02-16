Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2017 17:49:32 +0100 (CET)
Received: from mail-ot0-x231.google.com ([IPv6:2607:f8b0:4003:c0f::231]:33105
        "EHLO mail-ot0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993896AbdBPQtZvfrxP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Feb 2017 17:49:25 +0100
Received: by mail-ot0-x231.google.com with SMTP id 73so14926523otj.0;
        Thu, 16 Feb 2017 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/8suOwyN4O7yC69xBhCdo4L25IuMrO+8vmozL1oRwfU=;
        b=TslzvMfbmPLlD7isi0rN3dFJExpUyat6R3ZZx1S6v4m3v6sXCoaI/v76+MzeaCdFrA
         uPA24heaItzyq7m3kM9uSIMXkmw+mSzmQhLVvtKPHzfA2zY26p82mAqLGSTY07MKorGd
         t43YNE2bafWIyB4q34EenRs/Fg2/H45ASgZZ98DwN7yyO9OBmYhkRurn2wEqPCRKKqR8
         3Gv8jjAul5AHBUHmy/SGyO+G6z9oMF5eHuxvv0E1M1AKx74VTW8ZkQ0gfQ5BfKJ1RiRt
         7hiUWPCzypqv6Am43pipjix+ahlzWCs7q1sHNfkjjB4zeoUu1gkdpZRGRG8Q0JNrzJfR
         wSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/8suOwyN4O7yC69xBhCdo4L25IuMrO+8vmozL1oRwfU=;
        b=VQYw+y3NMYM9PXT0KP6T/uU1s6Tb0X4pqRznV2VLZ04DUzIlIH6PgUG1h1iZhlDvL4
         /p5p5sTWMXzilACzi1Tn3ZaICD+krv5CgWhn3UU7HRRSrVM7zkOy9sVhqoB3oflaUZNq
         BNUi7egD10SJw0OsK7Xor9IP9jwgsAHKlq0jfZrBa1f+FZ76YPE8rT0Mb8hDquHuj4kz
         gGbAgTidH4GyYuA85TF2txMGXNnmuV2HZGskSSjb7dZytvbbHGu294q1gkrLrOrqp2AC
         VBHqBJCkaIqawQnmW0Cw7XGnAAdYpAfFqPMfKxXEIWk/EqY69uBfb+ySEzaESOF2PP2u
         B7Rw==
X-Gm-Message-State: AMke39nsNqksdOElc9M422JEZIAn5cGdnnjrdTvkfSIYEW7EbqBvEizlUhkrRE9wyWM3mET6Sn4Eeg1UZPTMrA==
X-Received: by 10.157.4.141 with SMTP id 13mr1915187otm.243.1487263760043;
 Thu, 16 Feb 2017 08:49:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Thu, 16 Feb 2017 08:49:19 -0800 (PST)
In-Reply-To: <20170216130643.GV9246@jhogan-linux.le.imgtec.org>
References: <20170216130643.GV9246@jhogan-linux.le.imgtec.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Feb 2017 08:49:19 -0800
X-Google-Sender-Auth: roIhNwh5yyCZPABo3eW5ndll1WU
Message-ID: <CA+55aFz-4S-E5ebymwUCjqvi3_uWjF+XkqigfCOBq37gnzW3Bw@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS fixes for 4.10
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56852
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

On Thu, Feb 16, 2017 at 5:06 AM, James Hogan <james.hogan@imgtec.com> wrote:
>
> I've gathered together some of the more important fixes that it'd be
> good to get into 4.10. They're mostly build fixes, with a few runtime
> fixes too.

So quite frankly, I've been ignoring MIPS pull requests lately,
because I got fed up with the "never honors the merge window" part.

Not taking a pull request is the only way I can really show my
displeasure with the fact that area consistently ignores all the
release timing.

I'll happily take a MIPS pull request during the next merge window.
But it needs to actually do the right thing: not just coming in at a
timely point (not at the last day of the merge window or some time
very late in the rc series), but  also that it hasn't just been
rebased, it's actually been in -next etc.

Of course, sending pull requests for the merge window *early* is fine,
so sending me stuff for the upcoming merge window for 4.11 this week
is just showing that things are all lines up in time (still assuming
the -next thing etc).

But until I see that kind of "maintainer actually bothers to work with
the right process", I'm going to continue to ignore MIPS pull
requests.

             Linus
