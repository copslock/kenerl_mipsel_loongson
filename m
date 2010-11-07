Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Nov 2010 19:27:15 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:34010 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491828Ab0KGS1L convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 7 Nov 2010 19:27:11 +0100
Received: by fxm11 with SMTP id 11so3473809fxm.36
        for <multiple recipients>; Sun, 07 Nov 2010 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2NWAvIHGANjKHWGwjifJYmK+ZblCR8LW0bShuUlvTYw=;
        b=LnJb7/hTdIYprWwZkZQqr3fgKrzRJi95+itaqbAKImSv1c3oG02bDT0ujfB9kXvvRd
         g1e7BRegbjAeiMYHfJJEFfxEp3A97eS1jZ1E1Qu+KQ+5/zGOMfThCX+iDR3G7/WTAdcJ
         kKz5W22jfbbg/UQpsRk6iXROjNU57gznJoDBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z9s40Z5SlwCjnIH3/tu5FKG+hVsGee3AIIz8TC6/WMTvkZus9JF66/Nj7YUDx/bI8A
         F6cgkLSAk1xQvSV7+Bpj49kcBqlszAxBn1I150gLF0FLlhNol7+q3KZXLZlZkR3QylBn
         vBYJs3Knc0Nf3FWchk5cA5e1O003mnAaiFIt8=
MIME-Version: 1.0
Received: by 10.223.97.13 with SMTP id j13mr2957154fan.146.1289154422724; Sun,
 07 Nov 2010 10:27:02 -0800 (PST)
Received: by 10.223.78.134 with HTTP; Sun, 7 Nov 2010 10:27:02 -0800 (PST)
In-Reply-To: <20101013075346.GA24052@linux-mips.org>
References: <f3f140ca90dc9dac2f645748bc3a0150@localhost>
        <20101013075346.GA24052@linux-mips.org>
Date:   Sun, 7 Nov 2010 10:27:02 -0800
Message-ID: <AANLkTinmorJRk+bEvpyQB33sUxsZ=bEWcyiGr3iWpFab@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] MIPS: HIGHMEM DMA on noncoherent MIPS32 processors
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     dediao@cisco.com, ddaney@caviumnetworks.com, dvomlehn@cisco.com,
        sshtylyov@mvista.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Oct 13, 2010 at 12:53 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> The good news is that Peter Zijlstra has rewritten kmap to make the need
> for manually allocated kmap types go away and his patches are queued to
> be merged for 2.6.37.  So I'd like to put this patch on hold until after
> his patches are merged.

v4 of this patch applies cleanly to 2.6.37-rc1 and tests OK on my hardware:

http://patchwork.linux-mips.org/patch/1695/

What do you think about queuing it for 2.6.37?
