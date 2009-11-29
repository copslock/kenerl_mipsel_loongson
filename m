Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Nov 2009 06:35:44 +0100 (CET)
Received: from mail-yx0-f193.google.com ([209.85.210.193]:58576 "EHLO
        mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492090AbZK2Ffl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Nov 2009 06:35:41 +0100
Received: by yxe31 with SMTP id 31so2183719yxe.21
        for <multiple recipients>; Sat, 28 Nov 2009 21:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=r3OlSfdhsxmft6398W9Bw+wmLnRpdJ8txjQQRz9g3WU=;
        b=gwdbGuO9u93OptM6O3QfmEdPep09in53Ut2PXTtETghS6gzrXMqjDqPjgGwoK1TvUv
         54MG/m5s1IV2UD1htdx+dcK4aG24CXzy3vymyPrsCV1zPZxIF0JYLZrbZmpRQqjPeqim
         Cxz32pv047X2V5mNRL8ryZB7kOevwP7paipQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=g5AR/KWusRRgZHSv0W/lIm2AIqd0RGhBFlT4tLj34w/55qGHnivo/0wjEE54X57XfA
         dl1FRJ68sAdbybXUBRJ3NchuCCkO8HO4Vv/fcQgJgoZ6sXUQ5AOql+UfC7jtX8bh+Q8T
         ctinhdrZf7+YfAVPRhruofDhiz0d5o7x+1T14=
Received: by 10.150.39.1 with SMTP id m1mr4664317ybm.100.1259472931608;
        Sat, 28 Nov 2009 21:35:31 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-24-6-153-137.hsd1.ca.comcast.net [24.6.153.137])
        by mx.google.com with ESMTPS id 16sm632285gxk.15.2009.11.28.21.35.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 21:35:30 -0800 (PST)
Date:   Sat, 28 Nov 2009 21:35:27 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v5 8/8] Loongson: YeeLoong: add hotkey driver
Message-ID: <20091129053527.GU6936@core.coreip.homeip.net>
References: <cover.1259414649.git.wuzhangjin@gmail.com> <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Nov 28, 2009 at 09:44:41PM +0800, Wu Zhangjin wrote:
>  
> +config YEELOONG_HOTKEY
> +	tristate "Hotkey Driver"
> +	depends on YEELOONG_VO
> +	select INPUT

I think this should be depend, not select. 

> +	select INPUT_EVDEV
> +	select SUSPEND

Does it break without SUSPEND? I am pretty sure that it will work fine
without EVDEV (however unlikely it is not present).

-- 
Dmitry
