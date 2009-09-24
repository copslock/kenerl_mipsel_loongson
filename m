Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 11:24:58 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:40978 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492326AbZIXJYw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Sep 2009 11:24:52 +0200
Received: by bwz4 with SMTP id 4so1207168bwz.0
        for <linux-mips@linux-mips.org>; Thu, 24 Sep 2009 02:24:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=AstFJ06D68nZbPy4uPs7cEXDrD1fDTQkqvqQD/4Lk5U=;
        b=fJRcbufMn9ugW747YC92HDZ769wDJ+1q5kX6+AnhOUrxMHq9uU8f/wZ7kIMj6i3qe/
         hMcg5+1Dp/7Kh/Coab6utSaPQUuPiFvft8eltZswb4VkdkFsWuPzwjIl4LFPXYO913qW
         XINO3d6nzhX8F5z/ktww+GlnMlgPRcDIxroP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LjQVnKRFdBw8lu819WO4NiBdv9zNHl7ZN2FQOo3PMndKom7Dv46JNv+FIyG09DNlJR
         T7xZjRJMvJl17MyGbBiEetyjpfAF72FQB/YM4tOs+vZcP/CRv3ivXYs6VpKcvEj28iub
         lKn6u6fTUMVCm0zxrdR0t3sn5uMr25AyPrcXY=
MIME-Version: 1.0
Received: by 10.103.80.18 with SMTP id h18mr1367551mul.65.1253784285976; Thu, 
	24 Sep 2009 02:24:45 -0700 (PDT)
In-Reply-To: <20090924091539.GA929@merkur.ravnborg.org>
References: <f861ec6f0909232344s72af6bax5bd77f1a5be45b4f@mail.gmail.com>
	 <20090924091539.GA929@merkur.ravnborg.org>
Date:	Thu, 24 Sep 2009 11:24:45 +0200
Message-ID: <f861ec6f0909240224m4b5dcbd9hc835409e7a66102d@mail.gmail.com>
Subject: Re: MIPS: Alchemy build broken in latest linus-git
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

> I'm away from my machine atm.
> Could you try to add the following to arch/mips/kernel/makefile:
>
> CPPFFLAGS_vmlinux.lds += $(KBUILD_CFLAGS)
>
> This should fix it.

Thank you, that did it.

        Manuel Lauss
