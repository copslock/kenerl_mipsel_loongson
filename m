Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Nov 2009 08:41:20 +0100 (CET)
Received: from mail-yx0-f193.google.com ([209.85.210.193]:50190 "EHLO
        mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491997AbZK2HlR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Nov 2009 08:41:17 +0100
Received: by yxe31 with SMTP id 31so2214336yxe.21
        for <multiple recipients>; Sat, 28 Nov 2009 23:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=kW8iACDzR8UKNAiJ3K1TOSpfaX2B03sOLrkaR2eloqM=;
        b=LXruLCThrS2bfXL/Vj/9RfmSZfazmsoQvgwhSAqRxsa7t207AaI6FUvNj+W91/KRBH
         /+hW/yAPr8WVpqbFgYhMoaIedffeu8CIT5BmspZY1ggS4dGs4lvgfZYUHgZEP7qEbch1
         Jc8b+lAiOFhMbf55YAo3P8TE8EiwpQW5TQKBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ROTkwpOaNa/GgRLPi/WVaXoxHdbE4RDEbGBLN9BKabt0CYfH/0F0NDn9h0KhKlPuv8
         IsJdjMq+obgFqbwzWd+WAXFJrrBhyLh+GG4sKovQIN7yqwq7+cOYoTJ3dDRcfRQEPd4A
         y5VAVTPFHZl0tsddempTT9DlXEHDRhoDjBXf8=
Received: by 10.150.254.7 with SMTP id b7mr4784328ybi.137.1259480470370;
        Sat, 28 Nov 2009 23:41:10 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm1213798ywh.17.2009.11.28.23.40.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 23:41:09 -0800 (PST)
Subject: Re: [PATCH v5 8/8] Loongson: YeeLoong: add hotkey driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, linux-input@vger.kernel.org
In-Reply-To: <20091129072948.GA15146@linux-mips.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
         <20091129053527.GU6936@core.coreip.homeip.net>
         <1259473802.2577.6.camel@falcon.domain.org>
         <20091129072948.GA15146@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sun, 29 Nov 2009 15:40:41 +0800
Message-ID: <1259480441.2577.18.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-11-29 at 07:29 +0000, Ralf Baechle wrote:
> On Sun, Nov 29, 2009 at 01:50:02PM +0800, Wu Zhangjin wrote:
> 
> > On Sat, 2009-11-28 at 21:35 -0800, Dmitry Torokhov wrote:
> > > On Sat, Nov 28, 2009 at 09:44:41PM +0800, Wu Zhangjin wrote:
> > > >  
> > > > +config YEELOONG_HOTKEY
> > > > +	tristate "Hotkey Driver"
> > > > +	depends on YEELOONG_VO
> > > > +	select INPUT
> > > 
> > > I think this should be depend, not select. 
> > 
> > Hmm, okay, will replace it by depend later ;)
> > 
> > > 
> > > > +	select INPUT_EVDEV
> > > > +	select SUSPEND
> > > 
> > > Does it break without SUSPEND?
> > 
> > not break, but I just want to select something for users, so, they will
> > have no need to care about which extra option is needed.
> 
> We use  select extensively on MIPS but select is dangerous and you stepped
> into its trap.  When SUSPEND is enabled by a user in
> kernel/power/Kconfig it can only be choosen if PM is enabled.  By
> "select SUSPEND" this dependency so now it is possible to have a kernel
> where SUSPEND is enabled without PM which won't work.
> 

Get it, thanks for your clarification ;)

Regards,
	Wu Zhangjin
