Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 11:54:17 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:54954 "EHLO
        mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492297AbZLBJng (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2009 10:43:36 +0100
Received: by pxi6 with SMTP id 6so19680pxi.0
        for <multiple recipients>; Wed, 02 Dec 2009 01:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=/dFU7o7IW9jD7R+RUbEEXoUN1R26RqHlDSkmPSYKG2U=;
        b=OXHBhnW9bKiGgjuTEPCtO7shHmC3jfhkWdMvJ8/i0K7BZzoaN9z8nXVcamQnRXSIqd
         a6C3BnCqGABl85cqZm1o86hO8dDoYjwfhmLyx/LqjGRTpEAtD2nWTKfunZ9Xc/fFUfFQ
         a5ml8QC/NHbEO8z/OZXZgHliMgHyFs4sVI68c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=uHsjj/D63ihVEhDJ+IBqKv4DmEShfHyG6YwM9kkRQc51vI1ke4ce3YExgv6mXJ2Jsx
         1CFTAZpLUzhE+lyIVlyVeP8J2tKAv1lvqGXpGfUoWFwQA3/UWeYwOzT6JxaH1OBc3gbe
         L4dbf/k4yUzyfN/eXzCBDOcJsnGDvUSnb2bKw=
Received: by 10.115.98.40 with SMTP id a40mr1749547wam.97.1259747006938;
        Wed, 02 Dec 2009 01:43:26 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm721931pzk.8.2009.12.02.01.43.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 01:43:25 -0800 (PST)
Subject: Re: [PATCH v6 8/8] Loongson: YeeLoong: add hotkey driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        zhangfx@lemote.com
In-Reply-To: <20091201180350.GB19259@core.coreip.homeip.net>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
         <939c1425f653e3bda05799345c53198dfd2c1dcc.1259664573.git.wuzhangjin@gmail.com>
         <20091201154050.GJ14064@linux-mips.org>
         <20091201180350.GB19259@core.coreip.homeip.net>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 02 Dec 2009 17:43:00 +0800
Message-ID: <1259746980.7254.29.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25266
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-12-01 at 10:03 -0800, Dmitry Torokhov wrote: 
> On Tue, Dec 01, 2009 at 03:40:50PM +0000, Ralf Baechle wrote:
> > On Tue, Dec 01, 2009 at 07:12:37PM +0800, Wu Zhangin wrote:
> > 
> > > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > > 
> > > This patch adds Hotkey Driver, which will do relative actions for The
> > > hotkey event and report the corresponding input keys to the user-space
> > > applications.
> > 
> > This one also should become a platform driver.  And is probably a
> > candidate for drivers/input/keyboard.
> > 
> 
> Umm, it still mixes up bunch of stuff not directly related to input. I'd
> vote for drivers/platform/mips (since we have a few of kitchen-sink
> style drivers for x86-based laptops in drivers/platform/x86).
> 

Hello,

Do you mean we go back to drivers/platform/mips/yeeloong_laptop.c? (or
split the input stuff into yeeloong_input.c)

For considering the next platform support of LynLoong PC and the future
other MIPS netbooks/PC(e.g. gdium), perhaps drivers/platform/mips is
really the good place to put them in. and benefit from it, we maybe
easier to share the functions, variables. of course, the problem about
the API modification will also be there:

"Experience has shown that drivers for a particular subsystem are best
combined in a single menu, in a single directory.  Otherwise any changes
to subsystem's internal APIs will become a major pain.  Which in the end
means arch/ is usually the place for drivers that don't fit into any
established cathegory." -- Ralf

Best Regards,
	Wu Zhangjin
