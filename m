Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 02:43:03 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:65520 "EHLO
	mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493467AbZGAAm4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2009 02:42:56 +0200
Received: by pzk3 with SMTP id 3so455697pzk.22
        for <multiple recipients>; Tue, 30 Jun 2009 17:37:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=FV8MVlJrrX0IUOmNDUGpuv82Q+7eozF0fA+58wE5AM4=;
        b=psa4rNY0atdtXqC0kMOHC2+FQC+ZqLtp3CKNrfqd4Fpc+gCNdRM4h5kWYaQdPlp5vu
         pQrNWGFi8G8MQNkTQ5PbwhIeceN4bE7Mo02BKpu/7VCpCC9Xl198HDHhNzjPcWRGXh0n
         5HYkysFx3MM2PhMkWMPHoOVhqoheHSBnWgdVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=CjRgMme691O7m7C7I7ncXb60QMhzWDs7QxpdZ+zJjsWTVmw0tDrnP56Uq0Rzywcv0X
         Vbduri8cz1Q1ANiX8qze+owHZ/IYn9S2hbiKmxUinsGwOslDAZ7bQ4QZ4W3T8a27ORhM
         FyQskDiP6kbvOtyEenVr1A3jNv6UDqftJxE7w=
Received: by 10.142.240.19 with SMTP id n19mr861863wfh.198.1246408651115;
        Tue, 30 Jun 2009 17:37:31 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 29sm1988246wfg.1.2009.06.30.17.37.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 17:37:30 -0700 (PDT)
Subject: Re: [BUG] MIPS: Hibernation in the latest linux-mips:master branch
 not work
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	yanhua <yanh@lemote.com>
Cc:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Pavel Machek <pavel@ucw.cz>, Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <4A4AAB93.6040306@lemote.com>
References: <1246372868.19049.17.camel@falcon> <4A4AAB93.6040306@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 01 Jul 2009 08:37:16 +0800
Message-Id: <1246408636.12459.3.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-07-01 at 08:19 +0800, yanhua wrote:
> Wu Zhangjin 写道:
> > Hi,
> >
> > I just updated my git repository to the master branch of the latest
> > linux-mips git repository, and tested the STD/Hibernation support on
> > fuloong2e and yeeloong2f, it failed:
> >
> > when using the no_console_suspend kernel command line to debug, it
> > stopped on:
> >
> > PM: Shringking memory... done (1000 pages freed)
> > PM: Freed 160000 kbytes in 1.68 seconds (95.23 MB/s)
> > PM: Creating hibernation image:
> > PM: Need to copy 5053 pages
> > PM: Hibernation image created (4195 pages copied)
> >
> > and then, the number indicator light of keyboard works well, but can not
> > type anything. 
> >
> >   
> Are there any other information about it? such as: it just freezes
> there, or IDE irq lost messages after some time?
>
> Is it duplicable every time?

Yes, it is reproductive, I'm tracing it!

Thanks!
