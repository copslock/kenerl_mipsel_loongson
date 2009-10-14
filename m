Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:17:50 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:48158 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493710AbZJNTRW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 21:17:22 +0200
Received: by fxm21 with SMTP id 21so115237fxm.33
        for <multiple recipients>; Wed, 14 Oct 2009 12:17:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=VUgJxaVGvS3rJDFxDUgZ5w26ZgHdJ/UC1oq9dK893tY=;
        b=MHKcEvtBka71T7e1Gaz+8wZPp+AOhgleN4HpGrzfslsTclSOaN0FYNIJP3i0MNTDi6
         JOkofrX+ZPf6lV9YWWtNVE1vjHBJ1lt2fusaGu9ffTy7hPY9FptJ7OTYo19E6Xir48WY
         VS96ZievuyYDNffkv4u9nafSlJ7BNec6mAh1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UbpeofGl4bN9iHF14r2ZfN3TfEMwM3facUF0uZ51N/rMLvpgRcYDq7UCNEe0SpL7Mj
         Bt+AJWWSo8r2Ym7X33iO+L3jD01AyPFlSK7qVICe/uhKt0SKo919U7+rIS6lmusRR3CI
         2/U3oDrA95FFFv2+w11sV0XxqkC1DR8PlcMFc=
MIME-Version: 1.0
Received: by 10.223.17.144 with SMTP id s16mr2207235faa.41.1255547837027; Wed, 
	14 Oct 2009 12:17:17 -0700 (PDT)
In-Reply-To: <f861ec6f0910141212h562eda08le338842f90690419@mail.gmail.com>
References: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com>
	 <1255546939-3302-4-git-send-email-dmitri.vorobiev@movial.com>
	 <f861ec6f0910141212h562eda08le338842f90690419@mail.gmail.com>
Date:	Wed, 14 Oct 2009 22:17:16 +0300
Message-ID: <90edad820910141217x65406d02x183935dd56e60fdf@mail.gmail.com>
Subject: Re: [PATCH 3/3] [MIPS] remove an unused header file
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Oct 14, 2009 at 10:12 PM, Manuel Lauss
<manuel.lauss@googlemail.com> wrote:
> On Wed, Oct 14, 2009 at 9:02 PM, Dmitri Vorobiev
> <dmitri.vorobiev@movial.com> wrote:
>> Nobody includes arch/mips/include/asm/mach-au1x00/prom.h, so remove
>> this header file now.
>
> My compiler disagrees:

Hi Manuel,

Thanks for testing this and sorry for the untested patch. Ralf, please
drop this one; the other two in the series must be OK since I
build-tested them.

Thanks,
Dmitri
