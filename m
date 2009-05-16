Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2009 02:15:58 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.243]:22623 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023540AbZEPBPw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2009 02:15:52 +0100
Received: by rv-out-0708.google.com with SMTP id k29so1244102rvb.24
        for <multiple recipients>; Fri, 15 May 2009 18:15:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=lPbdgSe1NScph2HA71NztWlaO9idDejtwn/Mo684+04=;
        b=tPb5X6fQnijHqHlMIEyq8kyRVD4WcN2C8t4A7Ou2RIZ6jniXadU7JyNb7xDKa0S983
         0NedBPOArM+TIMbEqKaaltvgO1A4uiXUmm9l7EmjTxp6iJKiNcS4Bkljl6KdJJuRlMm3
         rA6MrOY93cG9jGgXmX4ZXRVkBHDry6Mx5sxxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=wTJd861BVXwqf0wl9DT5VreohgHHqxAe/FPuc7QvMh+ooIJrX/tzJW61u4WrhrtD62
         fFF9qIgRnJEDZVmip1hfhtkfM9mafEEvAipul+lM++K2vzwkNrjuh34/d5V0xO3xhmBf
         PLvfYOnEsRCTF0yshhMmxCMRfJYqaoeIVkb9c=
Received: by 10.141.198.2 with SMTP id a2mr1578329rvq.207.1242436550145;
        Fri, 15 May 2009 18:15:50 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id k37sm5611396rvb.8.2009.05.15.18.15.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 18:15:49 -0700 (PDT)
Subject: Re: [PATCH 23/30] loongson: CS5536 MFGPT as system clock source 
 support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	john stultz <johnstul@us.ibm.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <1f1b08da0905151739v6bc2e5f6t57cb8e06cdda2673@mail.gmail.com>
References: <1242426182.10164.168.camel@falcon>
	 <1f1b08da0905151739v6bc2e5f6t57cb8e06cdda2673@mail.gmail.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 09:15:41 +0800
Message-Id: <1242436541.10164.194.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-05-15 at 17:39 -0700, john stultz wrote:
> On Fri, May 15, 2009 at 3:23 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> > +static struct clocksource clocksource_mfgpt = {
> > +    .name = "mfgpt",
> > +    .rating = 1200,
> 
> Minor nit. Please read the comment over the struct clocksource
> definition in include/linux/clocksource.h for a guide to setting the
> rating value for your clocksource.
> 

as the comment describes, just like the 8253 Timer, the precision of
cs5536 mfgpt Timer is not good, the rating of it should be in the range
of 100-199? Functional for real use, but not desired?

thanks!
Wu Zhangjin
