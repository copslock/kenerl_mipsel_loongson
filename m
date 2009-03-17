Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2009 17:02:23 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.182]:23912 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S21369186AbZCQRCQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Mar 2009 17:02:16 +0000
Received: by wa-out-1112.google.com with SMTP id n4so39823wag.0
        for <multiple recipients>; Tue, 17 Mar 2009 10:02:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=o/O0DAgTOtEHU8RYPwJ8tU43q8nCF8+0R641sYeP+4Y=;
        b=k3EF8wKV0u4P27Z6cCnTXLR7RMvJ6IbBWt0Idp6eIi3Rqhe2bWalFq5rMdgLWJZqBk
         XXmgId+gVHDbv9D8XKFLN60xujxMHIbUAtYqCCjAWpoaP00S7I9kJOCz8p6Cs84PoLsu
         jKByAop4fdU8zz60VhYYFAw2MaZge9nBRjnAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=EZQbcPDxYrEc/5e5NFfsf1Icz8kWFMWrglBVAXzo3D5njEHS8sNLxz7e4mcLfCian6
         mVpz5/gHm2j4LNItfMBdSgQG0O/2webxN07aqgM4dcCcfaWoQEm42yB14JHHO+/8VG5s
         GdG9m6jhZ4SGw6SxRT+QbZiu++tiTTnsFgs6U=
MIME-Version: 1.0
Received: by 10.115.32.1 with SMTP id k1mr148480waj.66.1237309334166; Tue, 17 
	Mar 2009 10:02:14 -0700 (PDT)
In-Reply-To: <20090318.010939.128619068.anemo@mba.ocn.ne.jp>
References: <1237240246.27945.6.camel@dwillia2-linux.ch.intel.com>
	 <20090317.112019.147212126.nemoto@toshiba-tops.co.jp>
	 <e9c3a7c20903162152w6b73b4b8hba8004e7b349c447@mail.gmail.com>
	 <20090318.010939.128619068.anemo@mba.ocn.ne.jp>
Date:	Tue, 17 Mar 2009 10:02:14 -0700
X-Google-Sender-Auth: a990513ae9a75193
Message-ID: <e9c3a7c20903171002n50964148v8366fa2f00e3164c@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: TXx9 Soc DMA Controller driver
From:	Dan Williams <dan.j.williams@intel.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dan.j.williams@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.j.williams@intel.com
Precedence: bulk
X-list: linux-mips

On Tue, Mar 17, 2009 at 9:09 AM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Mon, 16 Mar 2009 21:52:10 -0700, Dan Williams <dan.j.williams@intel.com> wrote:
>> > Hmm.. why idr_ref is dynamically allocated?  Just putting it in
>> > dma_device makes thing more simple, no?
>>
>> The sysfs device has a longer lifetime than dma_device.  See commit
>> 41d5e59c [1].
>
> The sysfs device for dma_chan (dma_chan_dev) has a shorter lifetime
> than dma_device, doesn't it?

No,  dma_async_device_unregister(), and the freeing of dma_device, may
finish before chan_dev_release is called.  Userspace gates the final
release of dma_chan_dev objects.
