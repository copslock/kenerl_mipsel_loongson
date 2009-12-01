Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 19:04:11 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:34982 "EHLO
        mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492943AbZLASEI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 19:04:08 +0100
Received: by pxi6 with SMTP id 6so470284pxi.0
        for <multiple recipients>; Tue, 01 Dec 2009 10:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=u1AliPVst7RdmfJDzZ7mr9CUBONmzPmQ6Gp1aCL3iPE=;
        b=tZ6M1JOgZU7k3QY3Ckt9iVAYoc5kk1+jJU1MprcpEMpvhNRPTRKt8uo28g4VwcL6yd
         9Hmbah1T5YLk2IqSoJ09HQiMUDqDKudGbuC/x5Z/M8xpsg4DwFvUNg7+CCm2PBVmLJlo
         tavc/xfygoTqF/0HH1k+ZzlTRTu29vsYs0seQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bh7eXohTDOugVKK2/7F7JcQYH+shqyvMAH6FnFENhFJ4/Lb73tKmMUTdjzSX6Mqcn/
         xpIwTPNEBUeS3rjktL9QW888+MjbQJXL0pIyvTGr0Q8v5FtYehbbjzwll+ShtBepo73E
         mxK9OAEkZF14Opd39+FwzRVYM8XGKCRqu1MOs=
Received: by 10.114.214.24 with SMTP id m24mr11666600wag.93.1259690639846;
        Tue, 01 Dec 2009 10:03:59 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-24-6-153-137.hsd1.ca.comcast.net [24.6.153.137])
        by mx.google.com with ESMTPS id 22sm410727pxi.14.2009.12.01.10.03.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 10:03:58 -0800 (PST)
Date:   Tue, 1 Dec 2009 10:03:50 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        zhangfx@lemote.com
Subject: Re: [PATCH v6 8/8] Loongson: YeeLoong: add hotkey driver
Message-ID: <20091201180350.GB19259@core.coreip.homeip.net>
References: <cover.1259664573.git.wuzhangjin@gmail.com> <939c1425f653e3bda05799345c53198dfd2c1dcc.1259664573.git.wuzhangjin@gmail.com> <20091201154050.GJ14064@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091201154050.GJ14064@linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 03:40:50PM +0000, Ralf Baechle wrote:
> On Tue, Dec 01, 2009 at 07:12:37PM +0800, Wu Zhangin wrote:
> 
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This patch adds Hotkey Driver, which will do relative actions for The
> > hotkey event and report the corresponding input keys to the user-space
> > applications.
> 
> This one also should become a platform driver.  And is probably a
> candidate for drivers/input/keyboard.
> 

Umm, it still mixes up bunch of stuff not directly related to input. I'd
vote for drivers/platform/mips (since we have a few of kitchen-sink
style drivers for x86-based laptops in drivers/platform/x86).

Thanks.

-- 
Dmitry
