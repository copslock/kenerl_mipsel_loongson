Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jul 2014 23:33:24 +0200 (CEST)
Received: from mail-vc0-f171.google.com ([209.85.220.171]:34600 "EHLO
        mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860071AbaGSVdWnKr6A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jul 2014 23:33:22 +0200
Received: by mail-vc0-f171.google.com with SMTP id hq11so8274468vcb.16
        for <multiple recipients>; Sat, 19 Jul 2014 14:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a8gnnTFvLagR1Kk0snZ/6d5sQuQ6fMnv50zRSBJkaTg=;
        b=qIks9BHlpzxNM/QP6ORy/78ZOxSJHXqzZNPcL/YNQQMjYYsvofugyNGZsBwhY5L9tC
         wPHTRSNhGMER4RunsjEgld1S1vXjaMHp6N4w+pQ2JaFQGeDbF0xdKkQl+ff7aE7RA5GX
         K68fqQzI7UKuA5wGMYxSNLYbXSUThkpuz6+00GVI3eNdxf4h8cHg1hr88LxU1YnVprXZ
         z6Qhvw5HeYNJRYRCBDVOZ3P+PYPasMudLyYS2wsqKoC/uKAshZXIh8woVY+ZG191FVv8
         FfOFT2OCNzxw8KCCGFsfzrdhFHBgcVkB3JMR9IvoCh7Ow2VbO2uCGo8bZetAs/CvXrTG
         V8NA==
MIME-Version: 1.0
X-Received: by 10.220.166.9 with SMTP id k9mr17254996vcy.20.1405805596510;
 Sat, 19 Jul 2014 14:33:16 -0700 (PDT)
Received: by 10.221.53.5 with HTTP; Sat, 19 Jul 2014 14:33:16 -0700 (PDT)
In-Reply-To: <1405771556.18077.5.camel@x220>
References: <1405746604-7737-1-git-send-email-xerofoify@gmail.com>
        <1405771556.18077.5.camel@x220>
Date:   Sat, 19 Jul 2014 17:33:16 -0400
Message-ID: <CAPDOMVgQ-F9Y4AoNfFW-vN0YP10kwYL-GCwkpnXj+zg_UMJ4jw@mail.gmail.com>
Subject: Re: [PATCH] mips: Remove uneeded line in cmp_smp_finish
From:   Nick Krause <xerofoify@gmail.com>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     ralf@linux-mips.org, paul.burton@imgtec.com,
        Leonid.Yegoshin@imgtec.com, markos.chandras@imgtec.com,
        Steven.Hill@imgtec.com, linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

On Sat, Jul 19, 2014 at 8:05 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Sat, 2014-07-19 at 01:10 -0400, Nicholas Krause wrote:
>> This patch removes a unneeded line from this file as stated by the
>> fix me in this file.
>>
>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>> ---
>>  arch/mips/kernel/smp-cmp.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
>> index fc8a515..61bfa20 100644
>> --- a/arch/mips/kernel/smp-cmp.c
>> +++ b/arch/mips/kernel/smp-cmp.c
>> @@ -60,8 +60,6 @@ static void cmp_smp_finish(void)
>>  {
>>       pr_debug("SMPCMP: CPU%d: %s\n", smp_processor_id(), __func__);
>>
>> -     /* CDFIXME: remove this? */
>> -     write_c0_compare(read_c0_count() + (8 * mips_hpt_frequency / HZ));
>
> That comment ends in a question mark. I wonder why...
>
>>  #ifdef CONFIG_MIPS_MT_FPAFF
>>       /* If we have an FPU, enroll ourselves in the FPU-full mask */
>
>
> Paul Bolle
>
If we need it then can I remove the FIx me comment.
Cheers Nick
