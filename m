Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 20:51:51 +0200 (CEST)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:57811 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861349AbaGRSvouSKJh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 20:51:44 +0200
Received: by mail-lb0-f172.google.com with SMTP id z11so3162172lbi.17
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 11:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=IYBJP7q+0veUYf4WF+jZZb+Nih+NJOx4vsmPNpNlSvw=;
        b=cKg5LeZD3wlJTP19SHsDsNjVv8mngqADYHWHz++No9alR0n6riMKm6DImjRCTs3lyi
         o6GLNQMnl7W/YjviQ7wZJcXIfP9IyGCnTNohNARSvnePAuH1DmYlfYtHEMfXMrTWBs/r
         gVLgtuIH+crINBW6xmBJNcOdDTsnmKEyttzfKBJOB2AHSEZI/3njng6VNJUOElehUCZQ
         aNhHEDFJ5GJ7RsK1yc5DDrzd6RtahZp5yz7KsG6wQEBsas7Q+yBHE1ocQpyrbzgOk96o
         fXQrep57SsfXtlGWN79anaJAifxm3kGYoPlsmYb3A2ZO9hNOTKZ6kWsyt881LOSX3bWD
         02Pw==
X-Gm-Message-State: ALoCoQkyr49yNUJXTtf71cS+ILug8fmmvec+R/Mo7/0kqt/h1TGKYnWH+B93L+21oYtKgZX6xDXH
X-Received: by 10.112.13.4 with SMTP id d4mr7169495lbc.50.1405709499202; Fri,
 18 Jul 2014 11:51:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Fri, 18 Jul 2014 11:51:19 -0700 (PDT)
In-Reply-To: <CAGXu5jL9wQ4ZJ1kDRx_Y_cyGQEjO_Ugmcc--Q71x32_x1q9ScA@mail.gmail.com>
References: <1405620518-18495-1-git-send-email-keescook@chromium.org>
 <alpine.LRH.2.11.1407181325200.15709@namei.org> <CALCETrUv3G+C3PTOD1FJGOG8AQCA30hNkUiusCnQDGq6Kt_Feg@mail.gmail.com>
 <CAGXu5jL9wQ4ZJ1kDRx_Y_cyGQEjO_Ugmcc--Q71x32_x1q9ScA@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 18 Jul 2014 11:51:19 -0700
Message-ID: <CALCETrWj-NJeeKe6+qTZd3QsvLNMV_K=2swoNXza7Ef2xHkXoQ@mail.gmail.com>
Subject: Re: [PATCH v12 11/11] seccomp: add thread sync ability
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
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
X-archive-position: 41330
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

On Fri, Jul 18, 2014 at 11:13 AM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Jul 18, 2014 at 10:17 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Thu, Jul 17, 2014 at 8:26 PM, James Morris <jmorris@namei.org> wrote:
>>> On Thu, 17 Jul 2014, Kees Cook wrote:
>>>
>>>> Twelfth time's the charm! :)
>>>
>>> Btw, there doesn't seem to be an official seccomp maintainer.  Kees, would
>>> you like to volunteer for this?  If so, send in a patch for MAINTAINERS,
>>> and set up a git tree for me to pull from.
>
> Sure thing, I'll get this set up now. I wonder if I should include the
> glob "arch/*/kernel/ptrace.c" in the MAINTAINERS entry. :P

You might want to convince some arch maintainers first, and that's
like herding cats.  Or Oleg, at least.  Also, do you really want to be
asked to deal with the never-ending stream of bugs that people find in
files matching that glob?

>
>> *snicker* :)
>>
>> Kees, if you take on this awesome responsibility, should I send you a
>> rebased version of the fastpath stuff?  If so, I think that the
>> arch-neutral part should go in through your shiny new tree (once it's
>> reviewed to your satisfaction), and I'll ask hpa to pick up the x86
>> part.
>
> Yeah, that sounds perfect.
>
>> I'd volunteer to be a "R:eviewer", but I don't think that the R tag
>> has made it into MAINTAINERS yet.
>
> I'd love to have you listed. :)

Feel free to pester me once "R" appears in case I forget.

You might be able to convince me to co-maintain some day.  Hmm.

--Andy

>
> -Kees
>
> --
> Kees Cook
> Chrome OS Security



-- 
Andy Lutomirski
AMA Capital Management, LLC
