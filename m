Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2009 09:22:59 +0200 (CEST)
Received: from mail-pz0-f196.google.com ([209.85.222.196]:43114 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492489AbZILHWv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Sep 2009 09:22:51 +0200
Received: by pzk34 with SMTP id 34so1372643pzk.25
        for <multiple recipients>; Sat, 12 Sep 2009 00:22:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=BYfes+zK7C0QrRX59HJns71yQgIMusYiQ4nZojFPVWg=;
        b=g9H6mtBPKhSe8IGifgFQIv0y/Oz3EmQGlipzps5XlaYuzvB56dQUwlwRoOgdHafwZ9
         smKuFnW2qEhF1GO2cKZKc1lww1fpGS3IEXGBijJZ4mbF0aAMy3DHCk5D8cXS3z2+Gzjs
         3E7iXoFsOZELr/ODjzQ9v+3vjYI2oajEjTPow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=kVElTN3oryoBOHPcgT/LgC+poKPhTuTX7tc3M01PI9YoXDjRPcBjx2R4hfxlPCt51J
         B/0hUVUG47xe05glhIW4g2MTlj3KPXDP5H3kVREmjA61kOZ/T7cNY9z5PWfYNpJzMeyT
         JtnlJYzhsypIcFsReHLr34R1zBTyl1EhFLmFw=
MIME-Version: 1.0
Received: by 10.142.74.4 with SMTP id w4mr330649wfa.195.1252740163196; Sat, 12 
	Sep 2009 00:22:43 -0700 (PDT)
In-Reply-To: <4AAA73A4.9010601@caviumnetworks.com>
References: <4AA991C1.1050800@caviumnetworks.com>
	 <1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
	 <200909111633.00665.mb@bu3sch.de>
	 <4AAA73A4.9010601@caviumnetworks.com>
Date:	Sat, 12 Sep 2009 09:22:43 +0200
X-Google-Sender-Auth: 42a0362e6b437612
Message-ID: <10f740e80909120022m72ad5ea7t692fba93cd3114e9@mail.gmail.com>
Subject: Re: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable() 
	to compiler.h
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Michael Buesch <mb@bu3sch.de>, linuxppc-dev@lists.ozlabs.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux-mips@linux-mips.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
	linux-am33-list@redhat.com, Helge Deller <deller@gmx.de>,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Richard Henderson <rth@twiddle.net>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, Kyle McMartin <kyle@mcmartin.ca>,
	linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux390@de.ibm.com,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 11, 2009 at 17:58, David Daney<ddaney@caviumnetworks.com> wrote:
> Michael Buesch wrote:
>>
>> On Friday 11 September 2009 01:56:42 David Daney wrote:
>>>
>>> +/* Unreachable code */
>>> +#ifndef unreachable
>>> +# define unreachable() do { for (;;) ; } while (0)
>>> +#endif
>>
>> # define unreachable() do { } while (1)
>>
>> ? :)
>
> Clearly I was not thinking clearly when I wrote that part.  RTH noted the
> same thing.  I will fix it.

However, people are so used to seeing the `do { } while (0)' idiom,
that they might miss
there's a `1' here, not a `0'.

So perhaps it's better to use plain `for (;;)' for infinite loops?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
