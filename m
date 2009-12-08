Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 08:18:40 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:41686 "EHLO
        mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491038AbZLHHSh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 08:18:37 +0100
Received: by gxk2 with SMTP id 2so4616706gxk.4
        for <multiple recipients>; Mon, 07 Dec 2009 23:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=xo93w+wTVQGNGLw9rJoV2rEM1jHwT7Txodgu503bGRU=;
        b=kMYdpYclPsbT4OCB+xpM5m3ymhE8C/kPLkJK06bqzWS++MtK6VtXKJul0+I3Bl5PWE
         Ky5qY0YxEBJwJ0Q+rm4kV0lIXL0FQxIryDXVo0Vzph0jovDBxqapOsmjjPuO7KCxwgDM
         eJZVLglnoWFRkUI6Slxctyh9aED/+uEF0N7Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Jkum7aRvZyzYxxlsf6l4dshJgDuBx2uo4ryvGCwWNpbXOsgSPRwl4GtoKjhgjH0XHt
         cmrP/YNJdbM1YElSC2HQ6aqh+6XQT9t3Wm19khOIf+h12NIM1Mo1wZj2O+GBpjYUACoE
         r8tbm683ooI70+WbmngqAzoxZIFyb1qAA8VRI=
Received: by 10.91.81.18 with SMTP id i18mr12550542agl.47.1260256711291;
        Mon, 07 Dec 2009 23:18:31 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 39sm2905858yxd.63.2009.12.07.23.18.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 23:18:30 -0800 (PST)
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
In-Reply-To: <20091208070643.GB12264@elf.ucw.cz>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
         <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
         <20091206084717.GD2766@ucw.cz> <1260147298.3126.2.camel@falcon.domain.org>
         <20091207080446.GB23088@elf.ucw.cz>
         <1260178870.9092.34.camel@falcon.domain.org>
         <20091207094909.GD23088@elf.ucw.cz>
         <1260255056.3315.23.camel@falcon.domain.org>
         <20091208070643.GB12264@elf.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 08 Dec 2009 15:18:01 +0800
Message-ID: <1260256681.3315.54.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-12-08 at 08:06 +0100, Pavel Machek wrote:
> On Tue 2009-12-08 14:50:56, Wu Zhangjin wrote:
> > Hi, Pavel Machek
> > 
> > After fixing the get_battery_current(), can I get your Acked-by: for the
> > next revision of this patch?
> 
> Yes... you can add my ack for 4-6/8.

Thanks, will add your ack and resend the patchset later ;)

Regards,
	Wu Zhangjin
