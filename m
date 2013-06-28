Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 22:04:07 +0200 (CEST)
Received: from mail-ee0-f51.google.com ([74.125.83.51]:42975 "EHLO
        mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823114Ab3F1UEG3cZgg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jun 2013 22:04:06 +0200
Received: by mail-ee0-f51.google.com with SMTP id e52so1248583eek.10
        for <multiple recipients>; Fri, 28 Jun 2013 13:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=zVL5iOfCiXMdd+7orZP4DEPAihhrwefGtV1OMvBSw6s=;
        b=DwT4mUJPDHYUCBz64YqnCN2S5hcsz0LiG2QNciP04BMTCyfUj8+R+JGtizvB14lqj+
         BFFru1HhalkqcgDOI7QGVBfJSXwNEJCpntBngjYQw+TUrhycAYObdUp9G18qldW2uGo1
         xZVQ6ycgiDukH0Uj+RNd57961RAlR6b9J8wVcgb63AniQwrpgd8Y6jMAtNl0Mi3RRFif
         VtQf5SR6dzVgIVevONgk9ufmg4FhIjUQ1n1l8Jlc5gmAkFZRg3LpL4Jr3MYMsSLOmmzK
         I5o5OhVdDAJUAvgYF8fTK0acWwJkhyt6RTvcLW2fKJJS/O+ggsyfXCFyDu1vlgDxcsO8
         jIkw==
X-Received: by 10.14.219.2 with SMTP id l2mr15161282eep.109.1372449841120;
        Fri, 28 Jun 2013 13:04:01 -0700 (PDT)
Received: from shadow (161.196.broadband4.iol.cz. [85.71.196.161])
        by mx.google.com with ESMTPSA id m1sm12552325eex.17.2013.06.28.13.03.57
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 13:04:00 -0700 (PDT)
From:   Denys Vlasenko <vda.linux@googlemail.com>
To:     James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH] kernel/signal.c: avoid BUG_ON with SIG128 (MIPS)
Date:   Fri, 28 Jun 2013 22:03:56 +0200
User-Agent: KMail/1.8.2
Cc:     Oleg Nesterov <oleg@redhat.com>,
        David Daney <ddaney.cavm@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
References: <1369846916-13202-1-git-send-email-james.hogan@imgtec.com> <20130529173634.GA2020@redhat.com> <CAAG0J9_yJd5mf0t7whnKDYtf0AdZDnErjOgUga7t0p3TEL_9YQ@mail.gmail.com>
In-Reply-To: <CAAG0J9_yJd5mf0t7whnKDYtf0AdZDnErjOgUga7t0p3TEL_9YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201306282203.56255.vda.linux@googlemail.com>
Return-Path: <vda.linux@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vda.linux@googlemail.com
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

On Wednesday 29 May 2013 23:56, James Hogan wrote:
> On 29 May 2013 18:36, Oleg Nesterov <oleg@redhat.com> wrote:
> > On 05/29, David Daney wrote:
> >>
> >> On 05/29/2013 10:01 AM, James Hogan wrote:
> >>> MIPS has 128 signals, the highest of which has the number 128. The
> >>
> >> I wonder if we should change the ABI and reduce the number of signals to
> >> 127 instead of this patch.
> >
> > Same thoughts...
> 
> I'll give it a try. I wouldn't have thought it'd break anything, but
> you never know. glibc (incorrectly) sets [__]SIGRTMAX to 127 already.
> On the other hand uClibc sets it to 128, so anything built against
> uClibc that uses signals SIGRTMAX-n (where n may be 0) or uses an
> excessive number of rt signals starting from SIGRTMIN (sounds
> unlikely) could well need an updated uClibc (or a full rebuild if it's
> crazy enough to use __SIGRTMAX).

Fixed in uclibc git: _NSIG is 128, __SIGRTMAX is 127
(_NSIG in libc is not the same as in kernel, but +1).

While at it, added extensive comment why it is so.
