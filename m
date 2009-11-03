Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 12:00:32 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:46621 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492488AbZKCLA0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 12:00:26 +0100
Received: by bwz21 with SMTP id 21so7376491bwz.24
        for <linux-mips@linux-mips.org>; Tue, 03 Nov 2009 03:00:19 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aumaoU3oI9QiklaCjaVx2Ydyf1j0792gr99oYvUrwqU=;
        b=WE8Amo11mwmn+ZCBGwqDcNHYKGnwF8zXqZOgb64iJMUYEy8tVqNWkW5GDST0rhnSYJ
         /m+nt2KrWtHjWaAFsXHH58Zz/+Y1aIwsHDeOEMp5Gd0YJOACVH8lp1sgTvrz2bineccb
         K5DhGwxymdfWf0pR/eVH/zkrB+Q2LFrVJ7drk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Unja0W2u4ifhS5REKSCZd0VgvnPjO+OGWF5BKg/bXeSEJkHnWPBC53M0wLJMbq4/9x
         tsp3imuP2BnaZRtN4MD1rcIvVw3/9tID128pJ4T+RT4odfQ5RF5pwXavTw0EJPDOgTX6
         kRiC/VcfBiOYAnBIZxYOeo7ULcIgtnG9p9j+4=
MIME-Version: 1.0
Received: by 10.223.6.17 with SMTP id 17mr938223fax.93.1257246019789; Tue, 03 
	Nov 2009 03:00:19 -0800 (PST)
In-Reply-To: <20091103104337.GA26068@opensource.wolfsonmicro.com>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
	 <1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
	 <20091103104337.GA26068@opensource.wolfsonmicro.com>
Date:	Tue, 3 Nov 2009 12:00:19 +0100
Message-ID: <f861ec6f0911030300l130e58cl8d4915af5eec9238@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] MIPS: Alchemy: DB1200 AC97+I2S audio support.
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 3, 2009 at 11:43 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Nov 02, 2009 at 09:21:44PM +0100, Manuel Lauss wrote:
>> Machine driver for DB1200 AC97 and I2S audio systems, intended as a
>> proper reference asoc machine for Alchemy-based systems.
>> AC97/I2S can be selected at boot time by setting switch S6.7
>>
>> Cc: alsa-devel@alsa-project.org
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>
> This looks good for me.  The patch touches both ASoC and MIPS trees -
> I'm happy with it being merged though either.

Thanks for having a look!  I'd rather have it go through the MIPS tree,
otherwise there's a higher chance of merge conflicts.

Manuel Lauss
