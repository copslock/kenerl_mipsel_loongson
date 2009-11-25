Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 17:14:55 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:46673 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493065AbZKYQOw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 17:14:52 +0100
Received: by pwi15 with SMTP id 15so5197134pwi.24
        for <multiple recipients>; Wed, 25 Nov 2009 08:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=mfiShkuU2asD3QvquOVy1t80TLzI0BVmFMikoq0fgBI=;
        b=v/zRtgEEAK6eODaidC/QhkGjCvZ3mxdQ1nGzEf/CAb4uJH7u1bgWs04g1/SRI6Wfbn
         20xBqcTZagL+CqRsJyy3ni5KQysvXCoQ1/pJFELm+anOwNZUFT8ym9z6MSmzgNYUpivn
         dHkJL2d75uFIRH3Vrrabqv4xU0khVakmLd4Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=KeE9NUkE9Xmj9/kM0NOukfd/KI2funYUIgxbN/Y7mxzHFUHwuXOMSW0EnqGt3R+ydw
         E1zYul3sB6bG42siBEoiOxyn87afv2MN/0En64j0d2ra1KuCJ0H0w1Afo27N0SBAtrSB
         PM6ptU/WSEtrwTiR5lE9Hnn0TtkM+7185JXZ4=
Received: by 10.114.250.36 with SMTP id x36mr3281844wah.21.1259165685616;
        Wed, 25 Nov 2009 08:14:45 -0800 (PST)
Received: from ?192.168.1.100? ([118.132.131.118])
        by mx.google.com with ESMTPS id 23sm4112638pxi.9.2009.11.25.08.14.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 08:14:43 -0800 (PST)
Subject: Re: how to support more than 512MB RAM for MIPS32 ?
From:   "Figo.zhang" <figo1802@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Kevin Hickey <khickey@netlogicmicro.com>, linux-mips@linux-mips.org
In-Reply-To: <20091125160047.GA10490@linux-mips.org>
References: <c6ed1ac50911242234p12817b55r1a062d59949308bf@mail.gmail.com>
         <1259159857.4675.11.camel@kh-d280-64> <1259163074.2049.6.camel@myhost>
         <20091125160047.GA10490@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 26 Nov 2009 00:17:01 +0800
Message-ID: <1259165821.2049.14.camel@myhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-11-25 at 16:00 +0000, Ralf Baechle wrote:
> On Wed, Nov 25, 2009 at 11:31:14PM +0800, Figo.zhang wrote:
> 
> > how to do map extra RAM to any ouside I/O space?
> > it is just motify:
> > 
> > 1. arch/mips/kernel/setup.c: bootm_init()function, motity the define
> > "HIGHMEM_START", for me: 
> > #define HIGHMEM_START 0x2000,0000   //512MB
> 
> Leave HIGHMEM_START unchanged; it should always be 512MB no matter what
> the actual memory addresses of a particular platform are.  The kernel
> needs to treat anything above 512MB differently because it's not
> permanently mapped and HIGHMEM_START stands for this limit.
> 

HIGHMEM canot directly invoke __get_free_pages() to allocate pages, so
it would slow performance ?

Is it anyother solution in current linux-mips kernel? for example,
directly map extra RAM to 0x40000000~0x80000000, the user space
decreased, only 0x0~0x40000000.

Best,
Figo.zhang

>   Ralf
