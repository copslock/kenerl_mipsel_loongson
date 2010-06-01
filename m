Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2010 15:55:31 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:64159 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492468Ab0FANzY convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Jun 2010 15:55:24 +0200
Received: by pwi2 with SMTP id 2so2134889pwi.36
        for <multiple recipients>; Tue, 01 Jun 2010 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nn03zRJJNROxRp77PEkebJSUxcejSKUg++yHEB+ylcI=;
        b=JFiFnSKy/UZaclhoJjch8fN3SFq7V+mT/zZEJvSICQ/Zf7TMz65ZBy1lWzhnGDUBEK
         RBwyEfAlJvOyG2ejbVQbEqZFucvS6n/z2FscfzJO266MIrUFuLoTsga+N6R1wToJN0VE
         NHeGUVUBfJ+5VjmkmwTRGAhKso5/Ub6cdP1jI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LveJY8XVTyyqk8b9Dkg1cheGx1q21b9rto6AgQ3fI1v1L4F+x4wTvUt93WxoDHyIMc
         lCAdSR74i90lwWTvq2gJ6/SkI30pBZJRMfpwbJMYm92LUmBacjOJ3wGe3yIjzvECBKyw
         3UueKc4ddkTdNykdF6O45FlvoMvWozwJiDe2A=
MIME-Version: 1.0
Received: by 10.142.67.27 with SMTP id p27mr4171673wfa.139.1275400207761; Tue, 
        01 Jun 2010 06:50:07 -0700 (PDT)
Received: by 10.142.179.7 with HTTP; Tue, 1 Jun 2010 06:50:07 -0700 (PDT)
In-Reply-To: <20100601134153.GK2519@chipmunk>
References: <1275397916-6401-1-git-send-email-wuzhangjin@gmail.com>
        <20100601134153.GK2519@chipmunk>
Date:   Tue, 1 Jun 2010 21:50:07 +0800
Message-ID: <AANLkTin_DI1LBRLlLa-01kDmnk94b1Or1zHmiMQDscDY@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Clean up the calculation of VMLINUZ_LOAD_ADDRESS
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 26965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 392

v3 is ready ;)

On Tue, Jun 1, 2010 at 9:41 PM, Alexander Clouter <alex@digriz.org.uk> wrote:
> Hi,
>
> * Wu Zhangjin <wuzhangjin@gmail.com> [2010-06-01 21:11:56+0800]:
>>
>> Changes:
>>
>> v1 -> v2:
>>   o make it more portable (feedback from Alexander Clouter)
>>     use EXIT_SUCCESS and EXIT_FAILURE as the return value, and use uint64_t
>>     instead of "unsigned long long".
>>   o add a missing return value (feedback from Alexander Clouter)
>>     return EXIT_FAILURE if (n != 1).
>>
>> We have calculated VMLINUZ_LOAD_ADDRESS in shell, which is awful. This patch
>> rewrites it in C.
>>
> s/awful/indecipherable/
>
> :)
>
>> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
>> ---
>>  arch/mips/boot/.gitignore                          |    1 +
>>  arch/mips/boot/compressed/Makefile                 |   22 ++++----
>>  arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |   55 ++++++++++++++++++++
>>  3 files changed, 66 insertions(+), 12 deletions(-)
>>  create mode 100644 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
>>
>> diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
>> new file mode 100644
>> index 0000000..81176b1
>> --- /dev/null
>> +++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
>> @@ -0,0 +1,55 @@
>>
>> [snipped]
>>
>> +
>> +     /* Convert hex characters to dec number */
>> +     errno = 0;
>> +     n = sscanf(argv[2], "%llx", &vmlinux_load_addr);
>> +     if (n != 1) {
>>
> you can drop the 'n' with:
>
> if (sscanf(argv[2], "%llx", &vmlinux_load_addr) != 1) {
>
>> +             if (errno != 0)
>> +                     perror("sscanf");
>> +             else
>> +                     fprintf(stderr, "No matching characters\n");
>> +
>> +             return EXIT_FAILURE;
>> +     }
>> +
>> +     vmlinux_size = (unsigned long long)sb.st_size;
>>
> I'm guessing this should probably be uint64_t also?
>
> Other than that, makes me happy :)
>
> Cheers
>
> --
> Alexander Clouter
> .sigmonster says: And furthermore, my bowling average is unimpeachable!!!
>



-- 
Studying engineer. Wu Zhangjin
Lanzhou University      http://www.lzu.edu.cn
Distributed & Embedded System Lab      http://dslab.lzu.edu.cn
School of Information Science and Engeneering         http://xxxy.lzu.edu.cn
wuzhangjin@gmail.com         http://falcon.oss.lzu.edu.cn
Address:Tianshui South Road 222,Lanzhou,P.R.China    Zip Code:730000
Tel:+86-931-8912025
