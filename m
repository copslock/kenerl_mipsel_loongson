Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2015 17:30:47 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36403 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009856AbbDFPapp9bcW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2015 17:30:45 +0200
Received: by wizk4 with SMTP id k4so34177401wiz.1;
        Mon, 06 Apr 2015 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/2sBh+4kUmX9umzBqIPELpgJInH/SS9AYHNXJ5+3VMg=;
        b=GA56cXHq+JH/f+Onc12/fm7HYc8bxOGauvn8g93nR4IpsH7F1+7BvzySNnbVv9KqEr
         zFhUwQgUmG+BvE+xNLCkVR0KHZT5R6dQOgVUkB68IcHJb4cjamDJ9mN0FPrg43eWRh0y
         slzxttXJEpvqw8lP54BZVGi3X5W/V+KjtMWt6YytJNtAi5NKOH0CDjZk5JafBMF023tG
         PWHj62Um/LBUcksY+VD80C46NfsX40Cc7FTAqhIMn5uihk6P3/8LlCWTAJdWHFGMFESM
         +wjJec0mY/aQEBJOPiEJwn8aM+v7kNYTl1C1nK/3PrajFTtx4a39ImkyfWTxpYfqkg6t
         VZ5g==
X-Received: by 10.181.27.199 with SMTP id ji7mr30193319wid.76.1428334241497;
 Mon, 06 Apr 2015 08:30:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.71.5 with HTTP; Mon, 6 Apr 2015 08:30:21 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1504061448590.21028@eddie.linux-mips.org>
References: <1427389644-92793-1-git-send-email-fykcee1@gmail.com>
 <20150330201015.GA3757@linux-mips.org> <CAGXxSxU_fCvUqkrFDU64MOgsyOW3XkcrSuB7DjcBMODG-B8=xw@mail.gmail.com>
 <alpine.LFD.2.11.1504021342130.5791@eddie.linux-mips.org> <CAGXxSxUD_CPuN-YA9aWDzumZHF1HU8NStyCDSBadmUpz4VTc3Q@mail.gmail.com>
 <alpine.LFD.2.11.1504061448590.21028@eddie.linux-mips.org>
From:   cee1 <fykcee1@gmail.com>
Date:   Mon, 6 Apr 2015 23:30:21 +0800
Message-ID: <CAGXxSxVVnDZmn3c_hFH7AM9-A888ZfADRjiyaLFUyD-pvnE_Zg@mail.gmail.com>
Subject: Re: [v5] MIPS: lib: csum_partial: more instruction paral
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Chen Jie <chenj@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fykcee1@gmail.com
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

2015-04-06 21:52 GMT+08:00 Maciej W. Rozycki <macro@linux-mips.org>:
> On Mon, 6 Apr 2015, cee1 wrote:
>
>> >  I'm not sure if any such other superscalar MIPS pipeline implementation
>> > exists, but if written correctly then at worst it won't hurt anyone else,
>> > so just make sure your change does not regress scalar MIPS pipelines.  I
>> > hope you have a way to verify it.
>>
>> It seems the P-Class of Warrior generation of MIPS CPU has a
>> superscalar MIPS pipeline(http://imgtec.com/mips/warrior/pclass.asp).
>
>  There have been many superscalar MIPS implementations, however I don't
> know offhand if any other have the restrictions like yours.

Hi, I guess I may not make myself clear :)

The example is only showing how this patch removes true data
dependency, not implies any restrictions.

E.g.
ADDC(sum, t0)
ADDC(sum, t1)
ADDC(sum, t2)
ADDC(sum, t3)

which are actually following instructions:
(1) daddu     sum, t0;
(2) sltu         v1, sum, t0;
(3) daddu     sum, v1;

(4) daddu     sum, t1;
(5) sltu         v1, sum, t1;
(6) daddu     sum, v1;

(7) daddu     sum, t2;
(8) sltu         v1, sum, t2;
(9) daddu     sum, v1;

(10) daddu     sum, t3;
(11) sltu         v1, sum, t3;
(12) daddu     sum, v1;

Here, each instruction depends on the result of its previous
instruction, this is tough for any superscalar pipelines.


With the patch applied, it becomes:
ADDC(t0, t1)
ADDC(t2, t3)
ADDC(sum, t0)
ADDC(sum, t2)

which are actually following instructions:
(1) daddu     t0, t1;
(2) sltu         v1, t0, t1;
(3) daddu     t0, v1;

(4) daddu     t2, t3;
(5) sltu         v1, t2, t3;
(6) daddu     t2, v1;

(7) daddu     sum, t0;
(8) sltu         v1, sum, t0;
(9) daddu     sum, v1;

(10) daddu     sum, t2;
(11) sltu         v1, sum, t2;
(12) daddu     sum, v1;

Here, e.g. at least (1) and (4) can be issued at the same cycle, as
long as CPU has enough execution units and a large enough
RS(Reservation Station), fetching instructions quick enough, etc.

What I want to say is, this patch removes some ** true data dependency
**, hence should improve the performance on (most?) superscalar
pipeline implementations.



-- 
Regards,

- cee1
