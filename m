Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 09:24:07 +0100 (CET)
Received: from mail-fx0-f214.google.com ([209.85.220.214]:32927 "EHLO
        mail-fx0-f214.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491839Ab0A1IYD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jan 2010 09:24:03 +0100
Received: by fxm6 with SMTP id 6so152707fxm.27
        for <multiple recipients>; Thu, 28 Jan 2010 00:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OI0qWfKljTOOzuJEEIRIYvBGy921ufSq0DR/S8wYo7E=;
        b=BvLUM+SnZ7O3aZsm8eWd6Zl9fY6qCb9VAtac5AO0XjpLAllVWzBzVWhdxT7y2xf2sC
         1jLwkms57Nm2JM9ZybJCEdf+sovENZZX9sveD5G4W6r7A2nDOeO4K5ZgKFXQxMf5S+12
         o6lmtH+CeU5ntbmjsdYaBgr9mbr2vAwlZjfXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Sq72/NrAMO4fOmKb52+LEc35l7/WmtFv/w81JQPhFs0kdzgfn0qAQo8cJL9yM4KbRH
         eF0dSpi1Gp3m3bQeYhLGdpYDD6kYUALHxy0teEbHvgXj7mIYnQlxgVWSrtXo/gd8jFlx
         R6e01FdhDdFhz+jzfc2PjOm2gVrhkS1wQDfOQ=
MIME-Version: 1.0
Received: by 10.223.64.84 with SMTP id d20mr2109531fai.76.1264667036233; Thu, 
        28 Jan 2010 00:23:56 -0800 (PST)
In-Reply-To: <20100127221818.GB26426@linux-mips.org>
References: <1264534773-24909-1-git-send-email-manuel.lauss@gmail.com>
         <20100127221818.GB26426@linux-mips.org>
Date:   Thu, 28 Jan 2010 09:23:56 +0100
Message-ID: <f861ec6f1001280023n7753c77wfd626d731ddc690a@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Alchemy: fix dbdma ring destruction memory 
        debugcheck.
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 25708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18085

>> This fix is only necessary with the SLAB allocator and CONFIG_DEBUG_SLAB
>> enabled;  non-debug SLAB, SLUB do return nicely aligned addresses,
>> debug-enabled SLUB currently panics early in the boot process.
>
> Queued for 2.6.34 - should this also go into 2.6.33?

2.6.33 and .32 at least.  That code has been in there since the dawn of 2.6;
the fact that nobody has tripped over this so far means that noone build kernels
with slab debugging (I tripped over this while looking for something else) or
the slab allocator behaviour changed recently.


> Have you considered increasing the value ARCH_KMALLOC_MINALIGN which
> defaults to 8?  Or your own slab cache of suitable alignment?  The latter
> is more something for frequent allocations.

I have to admit I know nothing about Linux' memory management.  Are slab
caches not affected by the what I presume are "guard bytes" inserted into
the memory areas when slab debug is on?

Manuel
