Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2009 20:28:24 +0200 (CEST)
Received: from mail-yx0-f176.google.com ([209.85.210.176]:58680 "EHLO
	mail-yx0-f176.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493451AbZIGS2Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Sep 2009 20:28:16 +0200
Received: by yxe6 with SMTP id 6so3284579yxe.22
        for <multiple recipients>; Mon, 07 Sep 2009 11:28:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sozatdNewOWwECRibP9qaU47jH3DVLRnapILv5bPyv4=;
        b=JMMUxiduwuyIP/xXZWqjj36JXj5j9u4XcFTFxRlFeiqVibjDmOzL+j7vYl8t6Kxtvk
         KQwvmiBYtoFLmWit32XBQemKd+Te78IIBxCnQaStZlJscZspk1vsKdoHffhptwV02RD3
         zpAQBLrJSTAuif6z70p7A8idPcI/40NmRA++0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vjXXJMpY7DYcGb4oowmgSY6+bKBfMm2b8oXi8w/QWS+EK4a/8Re99/C5Xy/JC0214r
         q1P3jjxPCvNn16PjDFROluRT0ETnqthRKEDsm0nObSDRhz0RiFZ6xT//lGyPxZr9fXMb
         kO0W7kX+KZXCACC5dMq1zg6mi0iaM3ZCYTqo0=
MIME-Version: 1.0
Received: by 10.150.1.12 with SMTP id 12mr23205352yba.148.1252348088601; Mon, 
	07 Sep 2009 11:28:08 -0700 (PDT)
In-Reply-To: <20090907102613.GA25295@linux-mips.org>
References: <197625223d8cb6ec3fc3e7da4501dd65@localhost>
	 <20090907102613.GA25295@linux-mips.org>
Date:	Mon, 7 Sep 2009 11:28:05 -0700
Message-ID: <347733d50909071128v63b2d8a1hd6a87a361c14017e@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Machine check exception in kmap_coherent()
From:	Kevin Cernekee <cernekee@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Sep 7, 2009 at 3:26 AM, Ralf Baechle<ralf@linux-mips.org> wrote:
> Too complicated.  The fault is happening because the non-SMTC code is trying
> to be terribly clever and pre-loading the TLB with a new wired entry.  On
> SMTC where multiple processors are sharing a single TLB are more careful
> approach is needed so the code does a TLB probe and carefully and re-uses
> an existing entry, if any.  Which happens to be just what we need.
>
> So how about below - only compile tested - patch?

That is an interesting idea.  However, I am not sure we want the IPI
ISR to overwrite copy_user_highpage()'s TLB entry.  That means that
when the interrupt returns, our coherent mapping will likely point to
a different page.  It will avoid the machine check exception, but it
will potentially cause silent, intermittent data corruption instead.

Taking another cue from the SMTC implementation, though - my v2 patch
adds an extra set of fixmap addresses for the in_interrupt() case,
avoiding the VA conflict entirely.  What do you think?

I tested this scheme on non-SMTC.  I suspect that the same change is
required for MT + MP cores like the 1004K, but probably not MT only
cores like 34K which don't use cacheop IPIs.
