Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 17:22:20 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:57307 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493523AbZLCQWR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2009 17:22:17 +0100
Received: by pwi18 with SMTP id 18so163210pwi.24
        for <multiple recipients>; Thu, 03 Dec 2009 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=T0My0j9+uGkzY71mXA8b8lJxPCm1236YpIVf1RI2404=;
        b=Ex8ygWNpwscXKGDy9lwTkMTggXSFViEMqnT0pq0a10iT1CtEVlKXfA852UTfIow9oN
         48JCt0mUNEcfVNjNq4pc6wtmWUnTCTaPJglu9B8fiAUeapuRN0JkWzn4tBTApzyuswYp
         VSshb2vRrwarPCHYyUYO4XlRps+JBclFMAyG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ojvbU/+kOeX1K56eHSoY3PrfQ0zeUpLQTyBPmNn91oNoAHODjarLxrHSkJJs8bNtfh
         idmnmfx13W5F4zvX/rrCPQ5w37M3heRnJSelGs7rgngESzH/i8/A2gqk1GFUr+g4jrkV
         8WD6tQipGqtGdLIyAvNPQq22816BT9elOJVuQ=
Received: by 10.115.39.8 with SMTP id r8mr2573919waj.104.1259857330058;
        Thu, 03 Dec 2009 08:22:10 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1784822pzk.10.2009.12.03.08.22.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 08:22:09 -0800 (PST)
Subject: Re: [rtc-linux] Re: [PATCH v1 1/3] RTC: rtc-cmos.c: fix warning
 for MIPS
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Alessandro Zummo <a.zummo@towertech.it>
Cc:     rtc-linux@googlegroups.com, ralf@linux-mips.org,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20091203171400.163e6f66@linux.lan.towertech.it>
References: <cover.1257383766.git.wuzhangjin@gmail.com>
         <a91e34bf2595157830d599cb66becd52247b1819.1257383766.git.wuzhangjin@gmail.com>
         <20091203155604.GC28957@linux-mips.org>
         <20091203171400.163e6f66@linux.lan.towertech.it>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 04 Dec 2009 00:21:45 +0800
Message-ID: <1259857305.7536.20.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-12-03 at 17:14 +0100, Alessandro Zummo wrote:
> On Thu, 3 Dec 2009 15:56:04 +0000
> Ralf Baechle <ralf@linux-mips.org> wrote:
> 
> > Ping.
> > 
> > This patch is now nearly a month old and I haven't yet heared anything.
> > This was actually meant to be 2.6.32 material.
> 
>  I supposed MIPS things were handled by the MIPS tree. If there's
>  urgency a submitter should specify the intended delivery path
>  (trivial, mips, rtc, directly to Andrew) and kernel release.
>  
>  Acked-by: Alessandro Zummo <a.zummo@towertech.it>

Hi, Alessandro Zummo

Could you please review the left two(only patch 2/3 for rtc tree) for
2.6.33 in http://patchwork.linux-mips.org/bundle/ralf/rtc/ ?

[v1,2/3] RTC: rtc-cmos.c: enable RTC_DM_BINARY of RTC_LIB for fuloong2e
and fuloong2f
[v1,3/3,loongson] RTC: Registration of Loongson RTC platform device

(Sorry, I can not find them in my Email client currently, so can not
reply the old Email thread directly, If necessary, I will resend them,
thanks!)

Best Regards,
	Wu Zhangjin
