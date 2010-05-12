Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 May 2010 08:42:26 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:35295 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491137Ab0ELGmX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 May 2010 08:42:23 +0200
Received: by pwj6 with SMTP id 6so344222pwj.36
        for <multiple recipients>; Tue, 11 May 2010 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=rY0KVxgZCoXOKE9L54+y3Kg6fmVr+QNl5vMnCMLVyPs=;
        b=BkipMLXw+vnYIwM5fbjAmVLcs2Zdw9rEDhb30f0bGEOBH9oDMFlFPyfj7lrQ02FQV+
         ew/eRXnlvoVWtnTkp9KyZNOga/0gszN4nLqFGcdYyNoS8/MY9Mt+SLnE5RgvwFR/fbIr
         EXGzikmuWJuuywRa0dP64npnBwIovc6YXCkP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=IZC4W75ucmX5wWPUd+Uyqb3i79d0AhO1SBjNQHITf4imwwY17WumWZ82V8GPAMumCu
         TJWBfq9h06hWeX9r5y7WhjjHw1NvJ/H11ony+ehzRNh3qHu4RwYErL/J0uDmmzGrjxHq
         fZ6fS/AIgSo/lqqxrGT352o6l1TEO6GyQp5GU=
Received: by 10.141.90.14 with SMTP id s14mr4634475rvl.263.1273646535451;
        Tue, 11 May 2010 23:42:15 -0700 (PDT)
Received: from [192.168.2.222] ([202.201.14.140])
        by mx.google.com with ESMTPS id b10sm3509784rvn.15.2010.05.11.23.42.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 23:42:13 -0700 (PDT)
Subject: Re: About MIPS specific dma_mmap_coherent()
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20100511184844.GA7978@linux-mips.org>
References: <1271134735.25797.35.camel@falcon>
         <s5hmxx7z4a7.wl%tiwai@suse.de> <1271218889.25872.27.camel@falcon>
         <s5hzl164kay.wl%tiwai@suse.de> <1271235619.25872.148.camel@falcon>
         <s5h633uxcje.wl%tiwai@suse.de>  <20100511184844.GA7978@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 12 May 2010 14:42:08 +0800
Message-ID: <1273646528.25828.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf & Takashi

On Tue, 2010-05-11 at 19:48 +0100, Ralf Baechle wrote:
> On Wed, Apr 14, 2010 at 05:46:13PM +0200, Takashi Iwai wrote:
> 
> > But, I remember vaguely that calling pgprot_noncached()
> > unconditionally is dangerous.  It should be checked somehow, e.g. via
> > platform_device_is_coherent().  And, this found only in
> > dma-coherence.h, and adding it to pcm_native.c would become messy like
> > below...
> > 
> > So, it'd be really better to add dma_mmap_coherent(), indeed.
> 
> We agreed that this was only meant as a stop gap meassure.  As such I do
> agree with either of
> 
>   http://patchwork.linux-mips.org/patch/1117/
>   http://patchwork.linux-mips.org/patch/1118/
> 
> Wu has tested the 1117 patch so that might make it preferable especially
> for 2.6.34 if we should go for that.
> 

Just tested 1118, it works too ;)

Regards,
	Wu Zhangjin
