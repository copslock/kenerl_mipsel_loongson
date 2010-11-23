Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 21:09:54 +0100 (CET)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:56320 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490959Ab0KWUJv convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 21:09:51 +0100
Received: by pvg7 with SMTP id 7so2369001pvg.36
        for <linux-mips@linux-mips.org>; Tue, 23 Nov 2010 12:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8NPN/Ypb4QgqG/qA53vAWl2/2Vk05roJqseATyBbm8k=;
        b=XWqB3Rk6P9y6td33r9mzO/b053wxP82iO4/SNYVjNxnP4OlSbuMQZsmt2ABczKxwQm
         rVbeoxUK6s4IUvfk7tMN5C5r3COQd5XDWzczh1Tt6OtfIYVt2xj6File+0/MkWpktZnT
         jBSPRB6GhusTUCNw0wvMLS70b/97UPiB1iJc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UWIfxwraR5O49z9mESDOVb1f0C1/hDNnwUkFW7cQ137f0rZ3OddOLoPZSpyT0jPNCC
         l2dFw1KUoVld/LrfljUacLxupI1tvTLJ62cfrJpYQwo3zhyKikuYQUO+b7qXQmRevepM
         r2EjupbVFQglu/28uZel/zmajXEyXvK/4oJoo=
MIME-Version: 1.0
Received: by 10.229.213.80 with SMTP id gv16mr6677538qcb.110.1290542983620;
 Tue, 23 Nov 2010 12:09:43 -0800 (PST)
Received: by 10.229.182.3 with HTTP; Tue, 23 Nov 2010 12:09:43 -0800 (PST)
In-Reply-To: <1290532165.30543.374.camel@gandalf.stny.rr.com>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
        <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
        <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
        <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
        <4CEB37F8.1050504@bitwagon.com>
        <1290532165.30543.374.camel@gandalf.stny.rr.com>
Date:   Tue, 23 Nov 2010 15:09:43 -0500
Message-ID: <AANLkTikO+MK2CCyZqXLDtVnjbfJLVa06wTdZ1bZcG-Vg@mail.gmail.com>
Subject: Re: Build failure triggered by recordmcount
From:   Arnaud Lacombe <lacombar@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Reiser <jreiser@bitwagon.com>, linux-mips@linux-mips.org,
        wu zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <lacombar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lacombar@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, Nov 23, 2010 at 12:09 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 2010-11-22 at 19:41 -0800, John Reiser wrote:
>> It looks to me like the change which introduced "virtual functions"
>> forgot about cross-platform endianness.  Can anyone please test this patch?
>> Thank you to Arnaud for supplying before+after data files do_mounts*.o.
>>
>>
>> recordmcount: Honor endianness in fn_ELF_R_INFO
>
> Arnaud, can I get a "Tested-by" from you.
>
allyesconfig kept building for +1h30 or so, until some unrelated
SoundBlaster16 ioctl size check issue[0], with manual application of
John's patch. I'll restart a full build tonight, in the mean time, I
guess we can assume it is fixed.

Reported-by: Arnaud Lacombe <lacombar@gmail.com>
Tested-by: Arnaud Lacombe <lacombar@gmail.com>

Thanks John!

 - Arnaud

[0] Ralf, is there any specific reason mips keeps defining its own
_IOC_SIZEBITS ?
