Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 14:43:39 +0100 (CET)
Received: from mail-fx0-f216.google.com ([209.85.220.216]:35995 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492482AbZKWNnc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 14:43:32 +0100
Received: by fxm8 with SMTP id 8so5746353fxm.27
        for <multiple recipients>; Mon, 23 Nov 2009 05:43:27 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CTeZBBFnn9wrxExzmiKMCgjJGH4pw/wD9Y7CE9wvs3M=;
        b=N07Z5ilF/q5QOFhoX2Q5HA63MHAn2OcdvYrmCNpyaNdglJGGX1jyL5PSC60UD59Sz3
         CJIEfI8hQN+abazE0qoUiPquLygqg2TqhttFqHM+I7psEOixjPTIKOQqINuSRdOVCFlN
         2+cSU6bLW0XDau/Sw7p1zAUbeuVhg5wDpmwQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KXvMgeJO1ecVlIVo6gJJq6PYF2y2sUeIDo1RR/hv8B97khlej2BjFVSr1YEYwRzHR+
         7BirK6kA8YVhTLTZKs1H8TC13AIf8VND4ggusQQrJpGM7+j/b9fEFIT0rPzRCMW7BAxR
         7eNotqHq9HNyYhNuTVJZYKs8fIhs4hCn41wA4=
MIME-Version: 1.0
Received: by 10.223.15.86 with SMTP id j22mr736011faa.47.1258983807040; Mon, 
	23 Nov 2009 05:43:27 -0800 (PST)
In-Reply-To: <20091123.222609.74748367.anemo@mba.ocn.ne.jp>
References: <1258977217-25461-1-git-send-email-dmitri.vorobiev@movial.com>
	 <20091123.222609.74748367.anemo@mba.ocn.ne.jp>
Date:	Mon, 23 Nov 2009 15:43:27 +0200
Message-ID: <90edad820911230543i64f1e33fg86770f3ab2b6510b@mail.gmail.com>
Subject: Re: [PATCH] [MIPS] Move several variables from .bss to .init.data
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	dmitri.vorobiev@movial.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Nov 23, 2009 at 3:26 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Mon, 23 Nov 2009 13:53:37 +0200, Dmitri Vorobiev <dmitri.vorobiev@movial.com> wrote:
>> Several static uninitialized variables are used in the scope of
>> __init functions but are themselves not marked as __initdata.
>> This patch is to put those variables to where they belong and
>> to reduce the memory footprint a little bit.
>>
>> Also, a couple of lines with spaces instead of tabs were fixed.
>>
>> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
>> ---
>>  arch/mips/ar7/platform.c        |    2 +-
>>  arch/mips/sgi-ip22/ip22-eisa.c  |    4 ++--
>>  arch/mips/sgi-ip22/ip22-setup.c |    2 +-
>>  arch/mips/sgi-ip32/ip32-setup.c |    2 +-
>>  arch/mips/sni/setup.c           |    2 +-
>>  arch/mips/txx9/generic/setup.c  |    2 +-
>>  arch/mips/txx9/rbtx4939/setup.c |    4 ++--
>>  7 files changed, 9 insertions(+), 9 deletions(-)
>
> NAK, at least for txx9 parts.  The struct mtd_partition arrays will be
> referenced by mtd map drivers via platform_data.

You are right, thanks. What do you think about moving the variables to
file scope then?

Dmitri

>
> And for console option strings parts, I doubt these can be marked as
> __initdata.  Theoretically, the console driver might be a module,
>
> ---
> Atsushi Nemoto
>
>
