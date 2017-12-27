Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 09:27:17 +0100 (CET)
Received: from mail-ua0-x244.google.com ([IPv6:2607:f8b0:400c:c08::244]:45201
        "EHLO mail-ua0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990394AbdL0I1JIj0DM convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Dec 2017 09:27:09 +0100
Received: by mail-ua0-x244.google.com with SMTP id e39so2602797uae.12;
        Wed, 27 Dec 2017 00:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=R5UWXg5qyBic0J6JQqwxYExnkxlP80adqG5fydbaIPk=;
        b=dejasInK6B/9Nyx8VJHCEvKIDAhwuw4bam9cmxlFqxhu/Fvz3Q0z0YKo0OzL7/Zs0W
         eXddpbGPFlMz/DaVT1FZKZ4lUejOotZXHIxBlcOFEPkMtPGPyF5Xo3ZvlXIUAlQRp5hZ
         qxly8oT0qJfR6rBI4tAt8ta+bpR8nJM/jT3bBPRszv5mOZt8CK02IdR2uyOGBD3E2/Jj
         QeDv0sAcS2kwnw7MGbr7QXJr/JGy9krz84u0OXXzitXdFROt8ht9bT2ltf8Jrb2hQbUh
         XIWvPJAVEpjQXFYQzqIr8SBSZhV+l3Br3eAjLBL9vsUrpqXPi0FPRtx/Fab0Eu6vdN0s
         oLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=R5UWXg5qyBic0J6JQqwxYExnkxlP80adqG5fydbaIPk=;
        b=f8KHk6I9HqRTza/Ulj5PmF+mM80m1bPrpMuPd92+SYeLCSkCrFkUAIhvqX2RiE3GEA
         7BBRHGUxgGMwWDeoYaKChdTj0EFmsG/UcfYLphDz7Jx0fw8dvmpF8JdtA42gsIcXocES
         X6uykw1PLUWYwOoYAhooSNf0jIV0tBFCBJcxAJzZwDBA172nDnoeT9/H3ajqnVU1xSzW
         Q4JQjSccSmEK8OYljo5h0B5SvSlcZDAZF512oYgSFCgNlw1Na4/lsHlkQBpMJMIS7fDE
         Phq8X0ioyBr44WnLkO7Xypl1dqH9XjnOnrrGMec/GCST6CT+JHIVjJt/McDJagq3fn5E
         sKQw==
X-Gm-Message-State: AKGB3mKUnOgC6iuGX1odgknV6BZcjuzq6gRC/AtS0uWbYUGuE/qqhco9
        bYcu6MXhysILa7v9OJh3mi4dzNkuVKcvfmZAgUA=
X-Google-Smtp-Source: ACJfBotIL5xF3h94lHUOZtA4JSY0gbQInvpcfhkFXOe2akb06sj2xMwFH5hPiksmZl2wHk2G9aI5p/jXaFxp/KoI4Z0=
X-Received: by 10.176.20.65 with SMTP id c1mr27881673uae.136.1514363222780;
 Wed, 27 Dec 2017 00:27:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.49.1 with HTTP; Wed, 27 Dec 2017 00:26:42 -0800 (PST)
In-Reply-To: <BD3A5F1946F2E540A31AF2CE969BAEEEC28277@MIPSMAIL01.mipstec.com>
References: <20171226104554.19612-1-malat@debian.org> <BD3A5F1946F2E540A31AF2CE969BAEEEC2826A@MIPSMAIL01.mipstec.com>
 <BD3A5F1946F2E540A31AF2CE969BAEEEC28277@MIPSMAIL01.mipstec.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 27 Dec 2017 09:26:42 +0100
X-Google-Sender-Auth: fkbN9Xdu803L0D3e1knkT9BNSn4
Message-ID: <CA+7wUsxXX-dkaZhLnjdzF0x+bbm-J1yjHuZQzr9eaKjffytf1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: math-emu: Do not export function `srl128`
To:     Aleksandar Markovic <Aleksandar.Markovic@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        James Hogan <jhogan@kernel.org>,
        Douglas Leung <douglas.leung@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Tue, Dec 26, 2017 at 7:10 PM, Aleksandar Markovic
<Aleksandar.Markovic@mips.com> wrote:
>> > Fix non-fatal warning:
>> >
>> > arch/mips/math-emu/dp_maddf.c:19:6: warning: no previous prototype for ‘srl128’ [-Wmissing-prototypes]
>> >  void srl128(u64 *hptr, u64 *lptr, int count)
>> >
>> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> > ---
>> >  arch/mips/math-emu/dp_maddf.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/mips/math-emu/dp_maddf.c b/arch/mips/math-emu/dp_maddf.c
>> > index 7ad79ed411f5..0e2278a47f43 100644
>> > --- a/arch/mips/math-emu/dp_maddf.c
>> > +++ b/arch/mips/math-emu/dp_maddf.c
>> > @@ -16,7 +16,7 @@
>> >
>> >
>> >  /* 128 bits shift right logical with rounding. */
>> > -void srl128(u64 *hptr, u64 *lptr, int count)
>> > +static void srl128(u64 *hptr, u64 *lptr, int count)
>> >  {
>> >          u64 low;
>> >
>> > --
>> > 2.11.0
>>
>> Acked-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
>
> However, there is an already submitted patch: (the code change is identical)
>
> https://www.linux-mips.org/archives/linux-mips/2017-11/msg00044.html
>
> Status of that patch on patchwork is "Accepted".

Sorry did not realized you sent it already.

Thanks
