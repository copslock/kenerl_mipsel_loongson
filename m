Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 May 2012 00:58:57 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33323 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903649Ab2EIW6w convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 May 2012 00:58:52 +0200
Received: by lbbgg6 with SMTP id gg6so778428lbb.36
        for <multiple recipients>; Wed, 09 May 2012 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VYCMPmXwMcXrGgFXUlmLo6c/YiKk2vP8GQr6OQWVuYE=;
        b=E3g5qGhpcH21IBuz3/p5vo/xQKfW5cwa408aFYaRe0Xfo23ByQ4sqfedG2ltTzR68v
         gClYnLJpJziUGujHrIcgRBuO7NpBcKVubDZeB51I/QtbAd4dZ5ynJ14kRqpCKmFzYLbw
         pWX2wHS8T9G4CFZN0E7cPrQVgRicQR8y+u7tcv1eUI4huJHLSIzQ+rFtQzmjMNotGHMk
         /fZ5ZiY8yv1xCLpBdzHN14IquzeuFu5JzIcJ3g9dHNxsszVwEoJZGKdbt696dHZjEPkU
         yfXMz0cSet4013xHMTgpVNsR8kx8JTTErEW02SS16beuKm0CSvFIEbi9aOZ28TEayVfo
         XCMA==
Received: by 10.112.99.198 with SMTP id es6mr786935lbb.66.1336604326426; Wed,
 09 May 2012 15:58:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.12.15 with HTTP; Wed, 9 May 2012 15:58:16 -0700 (PDT)
In-Reply-To: <20120508165118.GA11750@merkur.ravnborg.org>
References: <20120428205651.GA7426@merkur.ravnborg.org> <20120428205919.GC7442@merkur.ravnborg.org>
 <4FA460AB.6060309@suse.cz> <20120505082916.GA14006@merkur.ravnborg.org>
 <CA+8MBbKd9zAouJy5JvUnLwUHMJ65HsYgCTfBgv42nm32EnMPFA@mail.gmail.com> <20120508165118.GA11750@merkur.ravnborg.org>
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Wed, 9 May 2012 18:58:16 -0400
X-Google-Sender-Auth: hBZjgnkToQiuUDj08rIywATPKZ8
Message-ID: <CAP=VYLobO--uwxv_hiMYBnjD-AU_0fqyQJD6argQygnkHnm5Vg@mail.gmail.com>
Subject: Re: [PATCH 3/4] kbuild: link of vmlinux moved to a script
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Tony Luck <tony.luck@gmail.com>, Michal Marek <mmarek@suse.cz>,
        linux arch <linux-arch@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaud Lacombe <lacombar@gmail.com>,
        Andi Kleen <andi@firstfloor.org>, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, May 8, 2012 at 12:51 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Tony.
>
> On Mon, May 07, 2012 at 04:15:44PM -0700, Tony Luck wrote:
>> This patch is now in linux-next (tag next-20120507). But it looks to have
>> broken the ia64 build. I see this error:
>>
>>   CC      init/version.o
>>   LD      init/built-in.o
>>   KSYM    .tmp_kallsyms1.o
>> ld: .tmp_kallsyms1.o: linking constant-gp files with non-constant-gp files
>> ld: failed to merge target specific data of file .tmp_kallsyms1.o
>> make: *** [vmlinux] Error 1
>>
>> which looks like we used the wrong compile options when building
>> .tmp_kallsyms1.o
>
> Thanks for testing!
>
> Could you try if this helps.
>
>        Sam
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 26c5b65..1f4c27b 100644
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -78,8 +78,8 @@ kallsyms()
>                kallsymopt=--all-symbols
>        fi
>
> -       local aflags="${KBUILD_AFLAGS} ${NOSTDINC_FLAGS}                     \
> -                     ${LINUXINCLUDE} ${KBUILD_CPPFLAGS}"
> +       local aflags="${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL}               \
> +                     ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS}"

All the linux-next builds for mips are failing, which I tracked down to this.
Applying the above update doesn't help.  What is happening is that MIPS
gets KBUILD_CPPFLAGS double-quoted, and then you get:

+ mips-wrs-linux-gnu-nm -n .tmp_vmlinux1
+ scripts/kallsyms
+ mips-wrs-linux-gnu-gcc -D__ASSEMBLY__ <..snip..>  -D__KERNEL__
'-D"VMLINUX_LOAD_ADDRESS=0xffffffff81100000"' '-D"DATAOFFSET=0"' -c -o
.tmp_kallsyms1.o -x assembler-with-cpp -
<command-line>:0: error: macro names must be identifiers
<command-line>:0: error: macro names must be identifiers
make[1]: *** [vmlinux] Error 1

Note the  '-D"VMLINUX_LOAD_ADDRESS=0xffffffff81100000"' '-D"DATAOFFSET=0"'
part -- that is what triggers the two above errors.

Paul.

>
>        ${NM} -n ${1} | \
>                scripts/kallsyms ${kallsymopt} | \
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
