Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 14:51:57 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:37270 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492370AbZKCNvu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 14:51:50 +0100
Received: by bwz21 with SMTP id 21so7562525bwz.24
        for <multiple recipients>; Tue, 03 Nov 2009 05:51:41 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8ZkPcMGP42Xcs+idWTxXEVBk47m+ARs72sG01biypAM=;
        b=q/hOeF4LjB+c8vhmPZe/HQ3S/gHYOgprKWj2IowIC0uzYk0+jAjQjJiYN9A1MG+Glm
         GeosKiyPb2dPWhz2k4+zVjGvhIIyCmmWCTvUALURMvHr2NVd80vap6C4gG+iNa00UUWU
         g3uFgof80SYyA6AcJ8ZXh7s6/5ry4heYZXKs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HdQ/i/EF2yJyeswXdZY+BWkHA0KjSITcy1iKKeFfv1peMR8P3JrYPRTO+G6qt4A7xA
         LK2nQDhVaR9n7BsGuavU/1CgT3PXSQDrdzBXWQt5Qd5Idxwmp0yXbRsBzWbzUsy3SRHk
         oEVf/Gkp5Ev/JwbTO3kI8p0W0se8X/OMq1Log=
MIME-Version: 1.0
Received: by 10.204.32.16 with SMTP id a16mr4717249bkd.190.1257256301602; Tue, 
	03 Nov 2009 05:51:41 -0800 (PST)
In-Reply-To: <63386a3d0910251518i42149642g183f2d3f6c43384f@mail.gmail.com>
References: <1256078002-27919-1-git-send-email-linus.walleij@stericsson.com>
	 <63386a3d0910251518i42149642g183f2d3f6c43384f@mail.gmail.com>
Date:	Tue, 3 Nov 2009 14:51:41 +0100
Message-ID: <63386a3d0911030551j1accd6fby7038895df544385b@mail.gmail.com>
Subject: Re: [PATCH] Make MIPS dynamic clocksource/clockevent clock code 
	generic v2
From:	Linus Walleij <linus.ml.walleij@gmail.com>
To:	Thomas Gleixner <tglx@linutronix.de>
Cc:	Linus Walleij <linus.walleij@stericsson.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org, Mikael Pettersson <mikpe@it.uu.se>,
	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <linus.ml.walleij@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.ml.walleij@gmail.com
Precedence: bulk
X-list: linux-mips

2009/10/25 Linus Walleij <linus.ml.walleij@gmail.com>:
> 2009/10/21 Linus Walleij <linus.walleij@stericsson.com>:
>
>> Changes v1->v2:
>> - Fixed Mikaels comments: spelling, terminology.
>> - Kept the functions inline: all uses and foreseen uses
>>  are once per kernel and all are in __init or __cpuinit sections.
>> - Unable to break out common code - the code is not common and
>>  implementing two execution paths will be more awkward.
>> - Hoping the tglx likes it anyway.
>
> Ping on tglx on this, I will uninline the functions if you think
> it's better in the long run, just tell me, else can you pick this
> patch?

Ping again...

Linus Walleij
