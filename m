Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2009 12:00:42 +0100 (CET)
Received: from mail-px0-f202.google.com ([209.85.216.202]:64349 "EHLO
        mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491205AbZLILAj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2009 12:00:39 +0100
Received: by pxi40 with SMTP id 40so666038pxi.21
        for <multiple recipients>; Wed, 09 Dec 2009 03:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=857nE80KHgfbd2GB1vwxiyEimJlR66TOYfgwOmGsb8Q=;
        b=DwUxOeRzf06Ovhl2DMEPYSHHWsxrdpc5sTPHE7GDwDz3lWTc6wtzay0P6LQfF1NZkH
         AfNVut74JXG3ti6BaXkNFWkjgRx4AGKGBo+alT0S4RxPQ0Y/4x8o3V/rx9PcqgAVUdO3
         xRgrcepxGhBQXaYMtt/QseYSM8SzGKJ1RlXJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=spsgyYR8TiNOYPLc7X67OJiDF6MS66XiBmJJzfnm+TtBTWm5WkdVJ5Tor2P/3Pm4Tc
         KjXhr7/h/yv1AaGDACbyW4qlAvH5PTe0U3yh+b6wVUinJ+XRn60Pwwxuhbl2AfmZTsit
         cxABb/5rqnlMfA08rXEQqw36pzhaDOm8yxPqQ=
Received: by 10.115.134.40 with SMTP id l40mr18452260wan.41.1260356429532;
        Wed, 09 Dec 2009 03:00:29 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm6858944pzk.13.2009.12.09.03.00.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Dec 2009 03:00:28 -0800 (PST)
Subject: Re: [PATCH v9 5/8] Loongson: YeeLoong: add hardware monitoring
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
In-Reply-To: <20091208150229.GA1375@ucw.cz>
References: <cover.1260281599.git.wuzhangjin@gmail.com>
         <5e9acb4cd757075f617daa45cbd6f5fad94678ac.1260281599.git.wuzhangjin@gmail.com>
         <20091208150229.GA1375@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 09 Dec 2009 18:59:52 +0800
Message-ID: <1260356392.3926.2.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-12-08 at 16:02 +0100, Pavel Machek wrote:
> Hi!
> 
> > This patch adds hardware monitoring driver, it provides standard
> > interface(/sys/class/hwmon/) for lm-sensors/sensors-applet to monitor
> > the temperatures of CPU and battery, the PWM of fan, the current,
> > voltage of battery.
> 
> It is probably ok for now, but in future current/voltage of battery
> should be exported as power_supply class (drivers/power)...

Currently, the version based on the power_supply class have some
problems when using with gnome-power-manager(the whole system will hang
there), but works well with kpowersave, after fixing the bug, we will
use it instead of this APM Emulated one.

Thanks & Regards!
	Wu Zhangjin
