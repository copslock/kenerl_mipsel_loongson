Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 23:18:29 +0100 (CET)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:46013 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492897AbZJYWSV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Oct 2009 23:18:21 +0100
Received: by fxm25 with SMTP id 25so11938690fxm.0
        for <multiple recipients>; Sun, 25 Oct 2009 15:18:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4GXgr56fTVB+Rn8WdnMYQ78RCRyGTK+8HG7ZUHeoqoY=;
        b=FcdA5P9tbokMnI+5OLhJ8QZmALUBzSjqA9Jp6X7AEcQblupIRL4rWPX9EXFg+hTl8M
         8jP/MyMhwvBkZcoG+EKhjf1J5FTmVSD64J77dpJ5HdH2ob0fP/KU+A6MFRrXn7oQc2sL
         z5qlLgOwKQ89UGKreIq+rjBFVX4Wj9HD9l150=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WQdoq6E0PZx7Ar8pF1KRtuPElCHziLYhRFr1V12++d7XMiNIzbAy9FBFd083zXy/nL
         TwYF77HzRfw3MGkGRv/wynM1ZONXiMk0XfYHPAqXFRHQIFe6MbN9FzZZ9loWIxISFcJI
         b6JS4cTu+UQtooS8vW0RkLssahHvAFmX5gqXQ=
MIME-Version: 1.0
Received: by 10.204.141.4 with SMTP id k4mr5770835bku.28.1256509092338; Sun, 
	25 Oct 2009 15:18:12 -0700 (PDT)
In-Reply-To: <1256078002-27919-1-git-send-email-linus.walleij@stericsson.com>
References: <1256078002-27919-1-git-send-email-linus.walleij@stericsson.com>
Date:	Sun, 25 Oct 2009 23:18:12 +0100
Message-ID: <63386a3d0910251518i42149642g183f2d3f6c43384f@mail.gmail.com>
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
X-archive-position: 24496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.ml.walleij@gmail.com
Precedence: bulk
X-list: linux-mips

2009/10/21 Linus Walleij <linus.walleij@stericsson.com>:

> Changes v1->v2:
> - Fixed Mikaels comments: spelling, terminology.
> - Kept the functions inline: all uses and foreseen uses
>  are once per kernel and all are in __init or __cpuinit sections.
> - Unable to break out common code - the code is not common and
>  implementing two execution paths will be more awkward.
> - Hoping the tglx likes it anyway.

Ping on tglx on this, I will uninline the functions if you think
it's better in the long run, just tell me, else can you pick this
patch?

Linus Walleij
