Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 16:02:04 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:46214 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492631AbZLAPCB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 16:02:01 +0100
Received: by pzk35 with SMTP id 35so3724005pzk.22
        for <multiple recipients>; Tue, 01 Dec 2009 07:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=GTT5MgCIVkjveDLCvRThQAdqS/NvzlynFLkK9oSPUdM=;
        b=bIkiNjaFWHWT9NRz/kJ7AZ0Mfv94QXuNvm98uF7Ob8Zga7PK5c5OliNPavOota0+GI
         242+To1GsXXY/UCJqL20BLcyZfPoep8Jjc6ji/jVoREj+1htnXLX+ykNBHGmEyA6553Q
         6SFbeEvLqhCNsI6EEMKuob2hm7E4biMZI3aI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=hHbe/HBqhxjLHeN/apMOGBqlrSUlSqvoW/g0CwN3mPPhRul7NLxsJZWsa0wBQeixXM
         WO+FaCeQJBXNLwf0W3rDWe7sM7GRN1mm6uL21CNN8eK8peBZKWWYbAaPYt/YscoO1Ewe
         P1xikmmKS8cOzHpFFXIDc7IK0kPPxsAzrglck=
Received: by 10.115.80.6 with SMTP id h6mr4426657wal.108.1259679713193;
        Tue, 01 Dec 2009 07:01:53 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm127644pzk.13.2009.12.01.07.01.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 07:01:52 -0800 (PST)
Subject: Re: [PATCH v6 3/8] Loongson: YeeLoong: add backlight driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Richard Purdie <rpurdie@rpsys.net>
In-Reply-To: <20091201145745.GH14064@linux-mips.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
         <4328ee6b15dce3cb600dddf4e7151532ddc77f17.1259664573.git.wuzhangjin@gmail.com>
         <20091201140643.GC14064@linux-mips.org> <1259679137.12571.4.camel@falcon>
         <20091201145745.GH14064@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 01 Dec 2009 23:01:33 +0800
Message-ID: <1259679693.12571.8.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-12-01 at 14:57 +0000, Ralf Baechle wrote:
> On Tue, Dec 01, 2009 at 10:52:17PM +0800, Wu Zhangjin wrote:
> 
> > On Tue, 2009-12-01 at 14:06 +0000, Ralf Baechle wrote:
> > > On Tue, Dec 01, 2009 at 07:08:42PM +0800, Wu Zhangin wrote:
> > > 
> > > > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > > > 
> > > > This patch adds YeeLoong Backlight Driver, which provides standard
> > > > interface for user-space applications to control the brightness of the
> > > > backlight.
> > > > 
> > > > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > > 
> > > You split old, big driver into several individual drivers - good.
> > > 
> > > Now we can actually move things to their rightf place and for a backlight
> > > drivers that should be drivers/video/backlight/.  Convert it to a platform
> > > driver.
> > 
> > Okay, but for these drivers need the ec_kb3310b.h, so, we also need to
> > move it from arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
> > to arch/mips/include/asm/mach-loongson/ec_kb3310b.h.
> > 
> > and seems some subsystem have no maintainer, such as the hwmon driver:
> 
> Which is true and sometimes a bit of a nuisance but one we can live with.
> 

This time, I like the folks did under drivers/platform/x86/ ;) which
will be better to maintain. for all of these drivers are really only
YeeLoong platform specific ;)

> > HARDWARE MONITORING
> > L:      lm-sensors@lm-sensors.org
> > W:      http://www.lm-sensors.org/
> > S:      Orphan
> > F:      drivers/hwmon/
> > 
> > So, who should I send this patch to?
> 
> I suggest you add Andrew Morton <akpm@linux-foundation.org> and linux-kernel
> to the To: list.
> 

Okay, later, thanks!

Regards,
	Wu Zhangjin
