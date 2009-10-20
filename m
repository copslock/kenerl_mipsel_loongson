Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 00:17:09 +0200 (CEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:40096 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493595AbZJTWRC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 00:17:02 +0200
Received: by fxm25 with SMTP id 25so7234143fxm.0
        for <multiple recipients>; Tue, 20 Oct 2009 15:16:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=XaUSnduxeDoXgBmT+YclK1/ijvTkXjGQnQZ/74sNJe4=;
        b=N6BZGohFA2cLRTdwMuW2C7NZ+gm+bWEJhSHk82bMhPqgQqelPeDbEJkeKHch3OJcGQ
         CaM1NSSNJPeAq2v+KkQNkZH57vh5IOEttPSCkKKh+1oiaqxmt/JojzcdxsEb1q89M8NG
         6MrmItb3O1SD6xILcEiLkVG0fMU5khenB+WKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BWyLvb2x+26qEHNXClkdv2Yz9YaXFdN1fVm+lSqCGaLRYIW8XaZ2dxVjM5L44X6d0a
         yU3TiZkgst7exiiBH2VQvTkPJiLD5+hUcxKbIqmTPzr1bnBzBBWiT9kU776DWxOfTmdB
         fYmINKyPOQOw9YtWGg1M87o5BvUMv90QR5BjI=
MIME-Version: 1.0
Received: by 10.204.152.154 with SMTP id g26mr6934284bkw.54.1256077016670; 
	Tue, 20 Oct 2009 15:16:56 -0700 (PDT)
In-Reply-To: <4ADE3225.5050001@caviumnetworks.com>
References: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
	 <alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
	 <4ADE3225.5050001@caviumnetworks.com>
Date:	Wed, 21 Oct 2009 00:16:56 +0200
Message-ID: <63386a3d0910201516r71100657y92e3e6c2fab38db9@mail.gmail.com>
Subject: Re: [PATCH] Make MIPS dynamic clocksource/clockevent clock code 
	generic
From:	Linus Walleij <linus.ml.walleij@gmail.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Thomas Gleixner <tglx@linutronix.de>,
	Linus Walleij <linus.walleij@stericsson.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org, Mikael Pettersson <mikpe@it.uu.se>,
	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.ml.walleij@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.ml.walleij@gmail.com
Precedence: bulk
X-list: linux-mips

2009/10/20 David Daney <ddaney@caviumnetworks.com>:

>> Please do not make that functions inline. They are too large and there
>> is no benefit of inlining them.
>
> If that is the case, then perhaps they should not be defined in a header
> file.

Of course not. There are apropriate places to put them, but as stated
I think the use as it is today warrants having them inlined.

Linus Walleij
