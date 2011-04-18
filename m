Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2011 20:24:32 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:48836 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493115Ab1DRSY1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2011 20:24:27 +0200
Received: by pwi8 with SMTP id 8so2835382pwi.36
        for <multiple recipients>; Mon, 18 Apr 2011 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uotnw6pBAl+DSn7zUSezkGJ3ev3wSyh69y6Qw5FOS/I=;
        b=xn7agZ2nDjLhxxaSw/OHQesL6MeKQoKIfgVIuQLWfviZTmbGfq7+TsTnw6rm0tBevG
         YIWEUjicKC0r10mcOY5J3eq3dRXOTfTQOztt/Ea/7V34jvaeztd3R0t8Ts8VOOuI9SFg
         whUPNfyPHZQYMd1X9gtD+AhoHYqkMCfDDdRng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nt1Ja5cLNKIq9iBaXwjx8lcyxMBRY3JZopsyetdcEUpb4b2u3joVB39h84zoyqZnkN
         B16j6mQbWSz4mn1qIh/mwnWV2hJ99UiboyiSjfGirWqlx+fTe940CJMvcZri1PBd6/yP
         kPCnm4XPaQYRNqoLriLgQBZzfaDo+xkJy/o2E=
MIME-Version: 1.0
Received: by 10.68.1.36 with SMTP id 4mr7711657pbj.251.1303151060325; Mon, 18
 Apr 2011 11:24:20 -0700 (PDT)
Received: by 10.68.46.169 with HTTP; Mon, 18 Apr 2011 11:24:20 -0700 (PDT)
In-Reply-To: <4DAC75C6.2060504@caviumnetworks.com>
References: <7aa38c32b7748a95e814e5bb0583f967@localhost>
        <4DAC75C6.2060504@caviumnetworks.com>
Date:   Mon, 18 Apr 2011 11:24:20 -0700
Message-ID: <BANLkTinbFNvez+G4LpmF7uwwJrH_J1NK8w@mail.gmail.com>
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
From:   Kevin Cernekee <cernekee@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Apr 18, 2011 at 10:32 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> How much testing have you done on non-RI/XI CPUs?

On a non-RIXI CPU I was able to boot the system, run a basic GUI
application, create R/W shared mappings to /dev/mem, insert/remove
kernel modules, run a broken program that dumps core, etc.

I guess it would be a good idea to make sure swap still works.  Didn't
try that yet.

Can you think of anything else that might exercise the bits that were
touched by the patch?  Were there any tests you ran during the
development of RIXI support which uncovered subtle issues?

Thanks.
