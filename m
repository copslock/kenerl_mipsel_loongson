Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 13:17:40 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:35682 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903656Ab1KHMRc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Nov 2011 13:17:32 +0100
Received: by wwf4 with SMTP id 4so507760wwf.24
        for <multiple recipients>; Tue, 08 Nov 2011 04:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1Cy5F8i0WtgjUy585/dOkHAW7K2Ti9dD/ThHNqzMa4Q=;
        b=A3O7H0019g7etFPQDbQJiPMzBi1k7ODkaSH/5YrtXuLVxtQOq9ssFepWiG48+Fj2fR
         KcbpWfjbsGNp/L3D7EDd2VBvn+gly5Kf47toKanDIuFgez8DF4mmTB03xNByL6ifRxSo
         +tU+KcSW0B8GjG3fXd2hiBHw4PMkpk29igZS0=
MIME-Version: 1.0
Received: by 10.216.24.41 with SMTP id w41mr4409760wew.69.1320754647249; Tue,
 08 Nov 2011 04:17:27 -0800 (PST)
Received: by 10.216.45.11 with HTTP; Tue, 8 Nov 2011 04:17:27 -0800 (PST)
In-Reply-To: <20111107120752.GA5142@linux-mips.org>
References: <CAJd=RBC=_+qAnbTaYXgTOoiVdfgppRt-rBs4cnKoZKxHD14nuw@mail.gmail.com>
        <20111104151603.GB13043@linux-mips.org>
        <20111107120752.GA5142@linux-mips.org>
Date:   Tue, 8 Nov 2011 20:17:27 +0800
Message-ID: <CAJd=RBD6VBi8-HA1CjgTCwwjt1WvVL642-T=n=fHjHpEAXk7CQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add fast get_user_pages
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6656

On Mon, Nov 7, 2011 at 8:07 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> Hitting this one in a non-hugepage build of upstream-sfr:
>
>  CC      arch/mips/mm/gup.o
> arch/mips/mm/gup.c:70:51: error: redefinition of ‘get_huge_page_tail’
> include/linux/mm.h:379:51: note: previous definition of ‘get_huge_page_tail’ was here
> make[2]: *** [arch/mips/mm/gup.o] Error 1
> make[1]: *** [arch/mips/mm] Error 2
> make: *** [arch/mips] Error 2
>
> I fixed this one up by removing the local definition of get_huge_page_tail
> but you may want to re-test.
>

Hi Ralf,

It is my fault. While preparing the patch, Andrea shared the function in
parallel, and I missed his update in linux/mm.h.

thp: share get_huge_page_tail()
author		Andrea Arcangeli <aarcange@redhat.com>	
		Wed, 2 Nov 2011 20:37:36 +0000 (13:37 -0700)
committer	Linus Torvalds <torvalds@linux-foundation.org>	
		Wed, 2 Nov 2011 23:06:58 +0000 (16:06 -0700)
commit		b35a35b556f5e6b7993ad0baf20173e75c09ce8c


Test will be rechecked soon, and thanks for your fixup.

Best regards

Hillf
