Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 23:19:00 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.157]:6339 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20035765AbYANXSv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 23:18:51 +0000
Received: by fg-out-1718.google.com with SMTP id d23so2296998fga.32
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2008 15:18:51 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=YYv1KfuIn7g+SPQZzfWtOsRWWPdYQgNPm6New0WwIgI=;
        b=tFuJu9ifvYijoco8s/ygtNPlfjt8cTYhfemEC7E+n2DX7dNHt8qcYwRagH4dmuDQvIkb3dT7XdtGsByMLcj9NXoGtaFDV1DqLABzKN2ZG97P/yHTzjCP/hgGue8Kf4v7eRwhVcvha32SvPNPy8ATVMFwC5SAh01hDJcYm8XTo34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=vZ2vW1PgFtBqOn1Gh8F+jwTK+x3lQuAA9UunfNzYcT2RPY2tvGQihJS4cUV7GMDqrKHZ1Ga8GJim5tOZZztxoNl7BDumwijLMKoYMOFvXHlc7yE9s3qzPJN7sep0SLvX1CaDbBYjK0iEAPea1qc/UmrE4nC8lUNUeQYpZVn6L6I=
Received: by 10.86.58.3 with SMTP id g3mr6773116fga.1.1200352731206;
        Mon, 14 Jan 2008 15:18:51 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.28.153])
        by mx.google.com with ESMTPS id 3sm7105615fge.7.2008.01.14.15.18.49
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jan 2008 15:18:50 -0800 (PST)
Message-ID: <478BEDD7.6070100@gmail.com>
Date:	Tue, 15 Jan 2008 02:18:47 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SPAM] [PATCH][MIPS] Add Atlas to feature-removal-schedule.
References: <478BD0D2.2060004@gmail.com> <Pine.LNX.4.64.0801142302001.2335@anakin>
In-Reply-To: <Pine.LNX.4.64.0801142302001.2335@anakin>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
> On Tue, 15 Jan 2008, Dmitri Vorobiev wrote:
>> Ralf Baechle on Atlas board support in the linux-mips mailing list:
>>
>> Maciej is promising to fix it up since a few years ;-)  Aside of that it's
>> safe to say the Atlas is dead like a coffin nail.
>>
>> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
>> ---
>>  Documentation/feature-removal-schedule.txt |    8 ++++++++
>>  1 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
>> index 20c4c8b..c053318 100644
>> --- a/Documentation/feature-removal-schedule.txt
>> +++ b/Documentation/feature-removal-schedule.txt
>> @@ -333,3 +333,11 @@ Why:	This driver has been marked obsolete for many years.
>>  Who:	Stephen Hemminger <shemminger@linux-foundation.org>
>>  
>>  ---------------------------
>> +
>> +What:	Support for MIPS Technologies' Altas evaluation board
>                                                ^^^^^
> 					       Atlas

This is what happens when doing things in a rush. Thanks, Geert.

I'll post a corrected version soon.

> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
