Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2010 17:59:38 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:46213 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491030Ab0J0P7e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Oct 2010 17:59:34 +0200
Received: by wwb39 with SMTP id 39so867841wwb.24
        for <multiple recipients>; Wed, 27 Oct 2010 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=qpgbAglK1wvNSrb7L6qCTaUZWOtrlQ8pZoUp/C1xfXo=;
        b=oY4eNxn7dAZy0yQCX0wzjCxvrBc3PPtuVh5bQF53n+wgpCxEHwl404MlIGdlFJNOAQ
         7kB52PMQO2D5rLF5Wos0hYReOY0HyajoGRQS54h/5s0TRHav4SGkH4d2LKmRAyGD3YTI
         czzGW/PQeYLwL0GmFGwMcnV6pWw0WrnqQ6a10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LBtmP6IUtP9jLw1CIaOLGhiXBMs4HeF84b5v28roTAJzvE/Pa1yzFJrChCM/La/kbq
         3kPDz6Y1G3H09nd72w3LnrphZYzDSNUpYwjM8HnwLRFAVTfUFkWVD4zi1DuJWyHbx2gB
         8xUgy89xnJxQYKrfjzgiFuk63K7VZwjC4ErTI=
MIME-Version: 1.0
Received: by 10.227.135.85 with SMTP id m21mr9138941wbt.227.1288195169044;
 Wed, 27 Oct 2010 08:59:29 -0700 (PDT)
Received: by 10.216.176.203 with HTTP; Wed, 27 Oct 2010 08:59:28 -0700 (PDT)
In-Reply-To: <1288190315.18238.128.camel@gandalf.stny.rr.com>
References: <cover.1288176026.git.wuzhangjin@gmail.com>
        <910dc2d5ae1ed042df4f96815fe4a433078d1c2a.1288176026.git.wuzhangjin@gmail.com>
        <1288186366.18238.125.camel@gandalf.stny.rr.com>
        <AANLkTinsfveuYdo4YJGHqasPgG=+ftL-8sbC5_aYAytt@mail.gmail.com>
        <1288190315.18238.128.camel@gandalf.stny.rr.com>
Date:   Wed, 27 Oct 2010 23:59:28 +0800
Message-ID: <AANLkTinW8b6y4zcGMryYK3Q=uPOvRJyZVidj-Rf=LHzj@mail.gmail.com>
Subject: Re: [PATCH 1/3] ftrace/MIPS: Add MIPS64 support for C version of recordmcount
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, John Reiser <jreiser@bitwagon.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Oct 27, 2010 at 10:38 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 2010-10-27 at 22:09 +0800, wu zhangjin wrote:
>> On Wed, Oct 27, 2010 at 9:32 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Wed, 2010-10-27 at 18:59 +0800, Wu Zhangjin wrote:
>> >> From: Wu Zhangjin <wuzhangjin@gmail.com>
>> >
>> > The From above states that you wrote this. Did you modify what John and
>> > Maciej did? If so, please state clearly what each author has done, and
>> > how you modified it. If you did not write this, please change the From
>> > to the correct author.
>> >
>> > If you did modify it, then state something like this in the change log.
>> >
>> > Original version written by John Reiser <jreiser@BitWagon.com>
>> >
>> > Usage of "union mips_r_info" and the functions MIPS64_r_sym() and
>> > MIPS64_r_info() written by Maciej W. Rozycki <macro@linux-mips.org>
>> >
>>
>> yeah, that is true above.
>>
>> > Then state the changes you made.
>>
>> I didn't change it, just added the comments in the patch log and tested it.
>>
>> Should I resend the patch with the change log information about John and Maciej?
>>
>
> I can make the changes.
>

ok, thanks.

> Then the patch is originally John's, right?
>

Yes, John write it.

> I'll make him the author, with the comment about Maciej, and keep you as
> the Tested-by.

ok, Macjej has simplified the r_info of MIPS there, so perhaps we need
to add SoB for him and he told me to add that line.

For me, Tested-by: is ok.

Regards,
Wu Zhangjin
