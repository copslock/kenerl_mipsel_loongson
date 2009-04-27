Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 14:22:40 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.147]:58435 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023221AbZD0NWe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2009 14:22:34 +0100
Received: by ey-out-1920.google.com with SMTP id 13so456145eye.54
        for <multiple recipients>; Mon, 27 Apr 2009 06:22:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=grdNPYwjksEKsFujTna0sKnuHpL9rAOvQEmoGkc7X7w=;
        b=kpufrjX0mP6bzEqyMtz+pPzOcKEmpNDjQ1xPTTLhwBAppn2QShHzKhM9dMK/6+Qc38
         ev1OM2YBwAU32dijyUTzGD3HGKj2WuZiH5lsJChOVysCE0krERNJygSDYV2c1ziVps34
         C3KR7rvE5lSQmsampSg1IYztB5MEGRnJ7Z0mY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=SgCQzqLMk2plU962K3GYa6FKYbVlIlnAgJnbvsW70jrawNmAY0+4XtNIiMwqzhF2Hc
         m6KmcNX+3rJUynTXfyrEsLYm0Bpm61V+or/ZM0r2EEfpkKBHTm2tIQxxRALPg2Ei5Y5b
         hsB4f7lrJ7yHgqQp59dQ08tVL1xvzx0T+TbjA=
MIME-Version: 1.0
Received: by 10.210.68.17 with SMTP id q17mr2604685eba.55.1240838553290; Mon, 
	27 Apr 2009 06:22:33 -0700 (PDT)
In-Reply-To: <20090427130952.GA30817@linux-mips.org>
References: <E1LyQQX-00047N-6E@localhost>
	 <20090427130952.GA30817@linux-mips.org>
Date:	Mon, 27 Apr 2009 15:22:33 +0200
X-Google-Sender-Auth: b6da3c5aebbabfe1
Message-ID: <10f740e80904270622u730ba067g660257847dc526de@mail.gmail.com>
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Shane McDonald <mcdonald.shane@gmail.com>,
	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 27, 2009 at 15:09, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Apr 27, 2009 at 06:59:17AM -0600, Shane McDonald wrote:
>
>> There have been a number of compile problems with the msp71xx
>> configuration ever since it was included in the linux-mips.org
>> repository.  This patch resolves these problems:
>>  - proper files are included when using a squashfs rootfs
>>  - resetting the board no longer uses non-existent GPIO routines
>>  - create the required plat_timer_setup function
>>
>> This patch has been compile-tested against the current HEAD.
>>
>> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
>> ---
>>  arch/mips/pmc-sierra/msp71xx/msp_prom.c  |    3 ++-
>>  arch/mips/pmc-sierra/msp71xx/msp_setup.c |    8 ++------
>>  arch/mips/pmc-sierra/msp71xx/msp_time.c  |    7 ++-----
>>  3 files changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_prom.c b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
>> index e5bd548..1e2d984 100644
>> --- a/arch/mips/pmc-sierra/msp71xx/msp_prom.c
>> +++ b/arch/mips/pmc-sierra/msp71xx/msp_prom.c
>> @@ -44,7 +44,8 @@
>>  #include <linux/cramfs_fs.h>
>>  #endif
>>  #ifdef CONFIG_SQUASHFS
>> -#include <linux/squashfs_fs.h>
>> +#include <linux/magic.h>
>> +#include "../../../../fs/squashfs/squashfs_fs.h"
>
> No way.  You're reaching deep into the internals of squashfs for no good
> reason.  The only use of anything from squashfs_fs.h is a cast and casting
> to void * would work just as well.

He needs the definition of struct squashfs_super_block to access the .bytes_used
field. Alternatively, the offset of that field must be hardcoded.

BTW, the magic is __le32, and bytes_used is __le64, so there are some
le{32,64}_to_cpu()
missing.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
