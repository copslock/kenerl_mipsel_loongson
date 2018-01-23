Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2018 20:36:22 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:40909
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992391AbeAWTgQM2snk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Jan 2018 20:36:16 +0100
Received: by mail-lf0-x244.google.com with SMTP id h92so2079533lfi.7
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2018 11:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KnPNDa5vVgxQ1CH4HMSBawCpkT67+Y6KwqmWhTjlqz0=;
        b=phoHDO+jQ6UXTGKoUcdCQeB7HEaoiaEuDbsjS9rz8qaPHtmKYYXIMzP1Vy02Xy7+OK
         lVvQ/cOjhZzAItHGrZDTHZdWfS4PjsbFBFHrGCF+GDotRv8LSoXYtvFcJ3xjKPnjLjgP
         dVe98SCxi9jdTPTZk1GUyVeaxaOHfmnJkmVE23zWO7kgbrGFLdwv/oHXmpk1+FFETJkd
         cFaKdNwgtYhNjo6kmKr22qwUxb+wqQOSmCU+ZQOpgFujAwduE7UX9ego1UIXX1YnWg+k
         S7eccb6l9Y3ASbpecRX3lom3plMi4fdO9A/dQkAZISis+C4EyPOUOvtTGCsIrX4YyEtf
         JLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KnPNDa5vVgxQ1CH4HMSBawCpkT67+Y6KwqmWhTjlqz0=;
        b=N8CZahLXcQnp3+5XwEhYWEG3iL2oha/kgUKuh6/UYVYtLaAV5UmtuFizjlJ8n+GShH
         Ng1pR1gMVaOoVUroJNDEkRQjLkwBJpx80GbHelJvcZL9CEgS5izaa4f8jx/BmA4RSdAY
         fg/x7pjn6u1emtGHqBhkWE+UUp8RPlmMxBXFwK30A5q+YVccdrRpBDhr6G36KCR6JOvm
         hHiLmYRiRljEuaQ2pJm9YOGAodhBqmGFnO7/niw+G/u6f0ZVEOb/nmRtbRHHwJlCSIh1
         ILAkNKFNF4MpeZSSQ9I8HoCi7NiIk2KQU6t1eGqV6U10vFTpoAoc5T6iXjxvIoeNGWFz
         IIBA==
X-Gm-Message-State: AKwxytfSorOrCu6XsDXJes9+ODoHDip8j3IbUamjnkR15aECO/ZdrYQQ
        ACBV4Q3ll1VXAkHexnLEghAwpU8D
X-Google-Smtp-Source: AH8x2249XWqJVkFqpR9yv5NZMS3YUonbX7WufdPREa6YtWSw0x4XmIKpBSHGSY9dsuW+d8tQvzxCAg==
X-Received: by 10.46.58.6 with SMTP id h6mr1937388lja.2.1516736170717;
        Tue, 23 Jan 2018 11:36:10 -0800 (PST)
Received: from mobilestation ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id q77sm166816lfd.17.2018.01.23.11.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 11:36:10 -0800 (PST)
Date:   Tue, 23 Jan 2018 22:36:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] MIPS: memblock: Discard bootmem from Loongson3 code
Message-ID: <20180123193623.GC28147@mobilestation>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-13-fancer.lancer@gmail.com>
 <1516746524.20678.6.camel@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1516746524.20678.6.camel@flygoat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello Jiaxun,

On Tue, Jan 23, 2018 at 10:28:44PM +0000, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> 在 2018-01-18四的 01:23 +0300，Serge Semin写道：
> Hi Serge
> 
> > Loongson64/3 runs its own code to initialize memory allocator in
> > case of NUMA configuration is selected. So in order to move to the
> > pure memblock utilization we discard the bootmem allocator usage
> > and insert the memblock reservation method for
> > kernel/addrspace_offset
> > memory regions.
> 
> Thanks for your patch. However, In my test, the system didn't boot
> anymore with your patch. Since I don't have any lowlevel debug
> instuments(ejtag or something). I can't provide any detail about the
> problem. Just let you know that we have a problem here.
> 

Thanks for performing the tests of the patchset. I really appreciate this.
Regarding the problems you got. You must be doing something wrong, since
Matt Redfearn already did the tests on Loongson3:
https://lkml.org/lkml/2018/1/22/610
and the kernel turns out to be booting without troubles.

So could you make sure, that you did everything right? Particularly, you
said the patch (singular) isn't working. But this patch functionality depends
on the whole patchset. Did you apply all the patches I sent and fully rebuild
the kernel then?

Regards,
-Sergey

> 
> --
> Jiaxun Yang
