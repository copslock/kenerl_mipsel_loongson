Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 08:27:37 +0100 (CET)
Received: from mail-iw0-f180.google.com ([209.85.223.180]:49905 "EHLO
        mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491033AbZLHH1e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 08:27:34 +0100
Received: by iwn10 with SMTP id 10so3644347iwn.22
        for <multiple recipients>; Mon, 07 Dec 2009 23:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=SJmYjLX9hl67WFHmt0albR4iYsJIgOqjwYigMd5b57o=;
        b=ohJnKsM4PdDqA4MBEZbtxxRhZeb0Z8Lmx0nVnhPPp1kH7o4droy7MlosFxyC0tEY4h
         x0e3WVO5KANUUvBVTC2Fo8LoWvDhm6aH4PeZkPTF2lco1A5fvxx937TNEW5DehsXkPQ1
         U8RfZX17T2aP/TrsEpvILDgG4m9JH1khuN+ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ldCjAY3Y9IdUujuuHcAn3vcXEUWtNnXl7HOsx9S1I+qMFCRBkCWrTxB0HwEsm8YJyb
         FG5Hge3zWHSlRx9fGEGtfmN0k5doYDMMs92s0ng6TcxrIJoDFLl8FqtV+5nQdQRuGmvf
         +t+gneMvBa6fSfI6Fv9THfUrnnw7UVAAJZkBI=
Received: by 10.231.48.210 with SMTP id s18mr2501291ibf.3.1260257246903;
        Mon, 07 Dec 2009 23:27:26 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm3962529iwn.3.2009.12.07.23.27.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 23:27:25 -0800 (PST)
Subject: Re: [PATCH v8 5/8] Loongson: YeeLoong: add hardware monitoring
 driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20091208070915.GC12264@elf.ucw.cz>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
         <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
         <20091206084717.GD2766@ucw.cz> <1260147298.3126.2.camel@falcon.domain.org>
         <20091207080446.GB23088@elf.ucw.cz>
         <1260178870.9092.34.camel@falcon.domain.org>
         <20091207094909.GD23088@elf.ucw.cz>
         <1260183663.9092.51.camel@falcon.domain.org>
         <20091208070915.GC12264@elf.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 08 Dec 2009 15:26:50 +0800
Message-ID: <1260257210.3315.63.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-12-08 at 08:09 +0100, Pavel Machek wrote:
> > > > > That's certainly better. But... why not return signed value? Current
> > > > > flowing from the battery is certainly very different from current
> > > > > flowing into it...
> > > > 
> > > > You are totally right ;)
> > > > 
> > > > Just test it, when flowing from the battery, the value is negative, and
> > > > when flowing into the battery, the value is positive, so, no abs()
> > > > needed. thanks!
> > > 
> > > Make it return -value, then. I believe other code uses >0 values for
> > > discharge.
> > 
> > Done, but any document/standard about it?
> 
> Not sure, feel free to patch the documentation, too :-).

Okay, I will send a documentation(as a separate patch) like them:

$ ls Documentation/ABI/testing/sysfs-platform-*
Documentation/ABI/testing/sysfs-platform-asus-laptop
Documentation/ABI/testing/sysfs-platform-eeepc-laptop 

Thanks & Regards,
	Wu Zhangjin
