Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Nov 2009 06:50:44 +0100 (CET)
Received: from mail-yw0-f203.google.com ([209.85.211.203]:45306 "EHLO
        mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492090AbZK2Ful (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Nov 2009 06:50:41 +0100
Received: by ywh41 with SMTP id 41so6762641ywh.0
        for <multiple recipients>; Sat, 28 Nov 2009 21:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=/khwo3X+7XD1trJR8D6D1P9p69wfqDoDLI+uPqRvq5c=;
        b=PPxvvxuLvCe/c1s6NcwQHM+aSsYX8QZJhvEfiC3Ux/aIqQ2xXg3vXoVqyxciy1c7YX
         vSfOSxl+1GGKg0/ubE6eqP8NSgtGHZ1KFAHaGrpwnIkVzmHQCwIz425XNP7e+G1kOlC9
         ot55o3USQ3clBTPWnoK2UCsn0h3WvjWGGIypk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=QDNCg5ApRqHYMskJAO+EYyzk5C+SeKXZ6/UAzyANGxg+gP6J97uKUwYEDeRjiLRXRD
         E2oL7diITHT3pQnaRRO2QF/yg7XDliQ/T8Dz4JQoNVrIjHdK/jDfOtI/NBJ0XSwDjgIU
         2GwdPNHQ2J/gLfJPvEUVuB7y2CK/RKa7qteWA=
Received: by 10.150.244.4 with SMTP id r4mr4676212ybh.127.1259473832468;
        Sat, 28 Nov 2009 21:50:32 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 7sm1189091ywf.10.2009.11.28.21.50.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 21:50:31 -0800 (PST)
Subject: Re: [PATCH v5 8/8] Loongson: YeeLoong: add hotkey driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
        linux-input@vger.kernel.org
In-Reply-To: <20091129053527.GU6936@core.coreip.homeip.net>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
         <20091129053527.GU6936@core.coreip.homeip.net>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sun, 29 Nov 2009 13:50:02 +0800
Message-ID: <1259473802.2577.6.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-11-28 at 21:35 -0800, Dmitry Torokhov wrote:
> On Sat, Nov 28, 2009 at 09:44:41PM +0800, Wu Zhangjin wrote:
> >  
> > +config YEELOONG_HOTKEY
> > +	tristate "Hotkey Driver"
> > +	depends on YEELOONG_VO
> > +	select INPUT
> 
> I think this should be depend, not select. 

Hmm, okay, will replace it by depend later ;)

> 
> > +	select INPUT_EVDEV
> > +	select SUSPEND
> 
> Does it break without SUSPEND?

not break, but I just want to select something for users, so, they will
have no need to care about which extra option is needed.

anyway, I will use #ifdef ... #endif instead later.

>  I am pretty sure that it will work fine
> without EVDEV (however unlikely it is not present).

Yes, without EVDEV, it can be compiled, but without the EVDEV module, no
event will be sent to the user-space, as a result, we just get a broken
input support. so, let the users make their decision?

Regards,
	Wu Zhangjin
