Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 19:17:36 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:55518 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861349AbaGRRRcMTOA8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 19:17:32 +0200
Received: by mail-la0-f46.google.com with SMTP id b8so3134161lan.33
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 10:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=BtvgbTIxq+ZbaEUTFfpZ0tFlITqZGzNz2ygRd63dC+A=;
        b=f7mOsV59siYL9n+HzTvTcc3i7bqz2veW3fg63VwU9jtCALdg8equhquorrPu3uPwLe
         BRW+1U96DOxgOCWnT4hlqzh85LWZuNLxvi0PpFwkqloek+FX6OGcEmuw1YyGdjbz/ZkP
         BPZa8WTr+w7hRBmWgYE2uxYBrUcEr14k/1IWZkYMqTdOHsWW4NdaBCk+5tGVSa7Hm5t2
         Lb2adChLAmutLXSZAvTnhzIxclytxQwNPaR5eR+6PPxOW7wKYwBcWDUKmU9V8RFSeXzs
         YZhV9Y+5wFOrr3Dj7e4SQxwpYdYetUjfbQeP43DkLjcPnprQMZn8fiCXcX+3y//xeDeb
         JOnQ==
X-Gm-Message-State: ALoCoQmFealLCZBmN5lMzI23YSuCgLm+snYQ7kbD3VBdogcnaKfC6cmajMP02iHca4oGYfnoK1Kg
X-Received: by 10.152.202.197 with SMTP id kk5mr6886919lac.19.1405703846505;
 Fri, 18 Jul 2014 10:17:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Fri, 18 Jul 2014 10:17:06 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.11.1407181325200.15709@namei.org>
References: <1405620518-18495-1-git-send-email-keescook@chromium.org> <alpine.LRH.2.11.1407181325200.15709@namei.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 18 Jul 2014 10:17:06 -0700
Message-ID: <CALCETrUv3G+C3PTOD1FJGOG8AQCA30hNkUiusCnQDGq6Kt_Feg@mail.gmail.com>
Subject: Re: [PATCH v12 11/11] seccomp: add thread sync ability
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Drysdale <drysdale@google.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Thu, Jul 17, 2014 at 8:26 PM, James Morris <jmorris@namei.org> wrote:
> On Thu, 17 Jul 2014, Kees Cook wrote:
>
>> Twelfth time's the charm! :)
>
> Btw, there doesn't seem to be an official seccomp maintainer.  Kees, would
> you like to volunteer for this?  If so, send in a patch for MAINTAINERS,
> and set up a git tree for me to pull from.

*snicker* :)

Kees, if you take on this awesome responsibility, should I send you a
rebased version of the fastpath stuff?  If so, I think that the
arch-neutral part should go in through your shiny new tree (once it's
reviewed to your satisfaction), and I'll ask hpa to pick up the x86
part.

I'd volunteer to be a "R:eviewer", but I don't think that the R tag
has made it into MAINTAINERS yet.

--Andy
