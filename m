Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Sep 2009 16:09:04 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:55981 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492641AbZI1OI6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Sep 2009 16:08:58 +0200
Received: by bwz4 with SMTP id 4so3535984bwz.0
        for <multiple recipients>; Mon, 28 Sep 2009 07:08:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=bto3pdl+OfOMAU0j2Xws7LA9ky2ID9dK6FvGxm4Ql70=;
        b=JObWCGYSsEfpaNU+e+a+/XatXrdrsuRoywKU/soYp2e6UXTD5PoaqoLlFkm9SAyqKL
         otSYenOHIk7tF54B/4ueoFEAf/j3+4sXAsiHlnw3sEmfaxGw3A8c6b27hWUmYc68EQHN
         vgUDg3w1aO51DS+J60bQJct1vPvpJszQpxXq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FPaC3pgUGi1uVtXaYP0lWN+tfLqqQomUe/RLGkgWCNuQ7eOBY4XInt8/lUpVIuFPPE
         mB/70HM0wVnYWrEIAYrn7oN1JLnWR82GspYcmrIKq+D/BtG+MjUILtiVrhCiMrLB7iLl
         bhbPj4hhbNEBCBoC6Y8u4amnvTRJVJ+L50LpY=
MIME-Version: 1.0
Received: by 10.103.50.28 with SMTP id c28mr1272297muk.17.1254146932571; Mon, 
	28 Sep 2009 07:08:52 -0700 (PDT)
In-Reply-To: <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com>
References: <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com>
Date:	Mon, 28 Sep 2009 16:08:52 +0200
Message-ID: <f861ec6f0909280708o42ceb334u4d33e141b9c51efa@mail.gmail.com>
Subject: Re: [PATCH -v1] MIPS: add support for gzip/bzip2/lzma compressed 
	kernel images
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Alexander Clouter <alex@digriz.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Wu!

On Mon, Aug 10, 2009 at 10:49 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> This patch will help to generate smaller kernel images for linux-MIPS,

I just gave it quick spin on my Alchemy boards, works quite well!

For the debug code (dbg.[ch]) I suggest you leave the actual uart-banging
to board code (either in the form of cpp macros or inlined functions)
because most chips either don't have a 16550 compatible uart or (in the
alchemy case) have a 16550 with non-standard register layout.

Thanks you for your work!
        Manuel Lauss
