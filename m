Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 12:19:13 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:47341 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493188AbZKDLSy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 12:18:54 +0100
Received: by pzk32 with SMTP id 32so4765113pzk.21
        for <multiple recipients>; Wed, 04 Nov 2009 03:18:47 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=vwy46/FFG5kpl3mowxK/0JajC/VrcqsMriAeYxEm0n4=;
        b=Mf/dS60nzsmx064e0rDIGnlw/WBaGrpikN22kubwccFu+W2VGwA1F4gSA/szxPex6f
         kjTFkBCy2l6RhwJ7UJUv/dz8BX0e2351pdbi6OBBLUlVJ3JX7W/65E3u+sAezerj/SJU
         to/mXfa2vknM+mx7VDyPyXPwqC5hNO8n3rokc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=bWkwf5R9qWDLJZJZME5btonNRxjMnSGTUxnPhlq/EOfwuP/jW+TGk5CtbUfps9cj3G
         H9U23Q2ui0YwaqZPyeOuMgRsmzkf3FVSiOUv5xMT9TzF5yKiouTuV/zfXJpbS/39PZ8y
         lYS5UKObIKwNTCP9quNS+dewke05PQNHMfo24=
Received: by 10.115.87.7 with SMTP id p7mr1770986wal.161.1257333527364;
        Wed, 04 Nov 2009 03:18:47 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm567828pxi.7.2009.11.04.03.18.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 03:18:46 -0800 (PST)
Subject: Re: [PATCH -queue v0 5/6] [loongson] rtc: enable legacy RTC driver
 on fuloong2f
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
In-Reply-To: <m3eioetvx5.fsf@anduin.mandriva.com>
References: <cover.1257325319.git.wuzhangjin@gmail.com>
	 <e13ed33a99dbf14f223360d414aa2b2c5caa9b1f.1257325319.git.wuzhangjin@gmail.com>
	 <m3eioetvx5.fsf@anduin.mandriva.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 04 Nov 2009 19:18:47 +0800
Message-ID: <1257333527.8716.20.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 2009-11-04 at 11:40 +0100, Arnaud Patard wrote:
> Wu Zhangjin <wuzhangjin@gmail.com> writes:
> 
> Hi,
> 
> > RTC_LIB is selected by MIPS by default, and therefore, the legacy RTC driver is
> > disabled. but unfortunately, RTC_LIB not works on fulong, so, enabling the legcy
> > RTC driver is needed, otherwise, the tools like hwclock will not work.
> >
> > because loongson family machines, including fuloong2e, fuloong2f and
> > yeeloong2f need to enable legacy RTC driver, so we use MACH_LOONGSON
> > here.
> 
> There are loongson machines which are working fine with RTC_LIB (for
> instance the gdium which is using a m41t83 on i2c) so would be better to
> be more restrictive imho.

In reality, fuloong2e, fuloong2f and yeeloong2f work fine with RTC_LIB,
but relative patches need to append to drivers/rtc/rtc-cmos.c and also
need a RTC platform device. If what I remembered is right, Gdium also
need corresponding patches to make it work with RTC_LIB.

Herein, I just let the basic support for those machines work, and then,
the RTC_LIB support will be sent out later.

and a small question: if legacy RTC driver works well on these machines,
why should we forbid people to use it? I think it's better to remove the
"select RTC_LIB" line for MIPS, and then, the people will be free to
choose what they want, and even for the users whose platform not support
RTC_LIB.

Regards,
	Wu Zhangjin
