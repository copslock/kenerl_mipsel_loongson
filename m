Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2011 16:11:00 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:60735 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491008Ab1BKPK5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Feb 2011 16:10:57 +0100
Received: by ewy20 with SMTP id 20so1290232ewy.36
        for <multiple recipients>; Fri, 11 Feb 2011 07:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=AaTELkS8wascqy7RHWheT+rb/vKhU8A2wXQvy2T0mcM=;
        b=kZr7oXXF6mbAofw2Xqa8foaf2nFpsUqdLA68B9tv+u2ugbzT0xmbqVTwBTxxBHpHPw
         0I/PZ+j8sMOFlkluQbWKwbW7gzezNTo/H1y097JyxcrgFxcXcCpVkDBuslzqODeBlk7T
         Cxk7mrThC9YxMMYVYR+bRJOT4EVlbgORAOcks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=N+SyU5zsRYZnlNRLc6YuNwf85TBg4H1+5E9kl/YFvbLYXsdiNGatIHP26v60lpb+wf
         AT1h7KtII8lzaM1nS7he0JYoj3axNmyly5A1/3GqhibHchqIPEWTlZ9rw7IahBFu0jj+
         rba63EMRjgv8bTSlPUhNLLpDUSvuwTQheqdbA=
Received: by 10.102.244.8 with SMTP id r8mr379738muh.4.1297437051952;
        Fri, 11 Feb 2011 07:10:51 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id l3sm414576fan.0.2011.02.11.07.10.49
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 07:10:51 -0800 (PST)
Subject: Re: [PATCH 6/6] Cpu features overrides for msp platforms.
From:   Anoop P A <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <20110211150403.GG23348@linux-mips.org>
References: <1295943797-20467-1-git-send-email-anoop.pa@gmail.com>
         <20110211150403.GG23348@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 11 Feb 2011 21:01:20 +0530
Message-ID: <1297438280.29250.74.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2011-02-11 at 16:04 +0100, Ralf Baechle wrote:
> Queued for 2.6.39, thanks!
> 
> But: this is a rather short cpu-feature-overrides.h file.  You can shrink
> the kernel significantly and get a little performance boost by further
> defines in that file.  In particular defining the symbols for cache and
> TLB properties such as the cpu_dcache_line_size and cpu_icache_line_size
> are very effective.
Can you point me to reference file ?.
> 
>   Ralf
