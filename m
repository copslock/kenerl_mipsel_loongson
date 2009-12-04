Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 15:57:41 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:48890 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493126AbZLDO5h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 15:57:37 +0100
Received: by pzk35 with SMTP id 35so2396052pzk.22
        for <multiple recipients>; Fri, 04 Dec 2009 06:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=XjyTHMJSFyf90Rinkj9NvvBvMf04c9cqRuyH2J8n0XE=;
        b=M7gs3+oSNnFqdrHOEJ114o4ZTMUDSsnPqydUQq+4QCPTmxguKUaysGV+QnJqUEJiLw
         9Lj0EPOMLFX079hmbo+E2HUfsSyfFLTV7Kaf8ybhgVfFjyvw0lYAFMWQeFTWWiljrBsY
         18g5wLxez+qeguIdJmRD5gIWfecgkQAlBM65I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=KHcsB1oqf6TG1swTmld3i6ApEtURPxP/3BHRU69x+5qQzIul16/tiriuQr017MbODn
         luIYtfQiGvgup9tblyjx6uONT2gwCm73dLhbEX6Aos9567phpxs12suQeJJz9V4MhpJT
         cWXyBOJAKFKcejdXNpgmIre64ohy0VuOexZuw=
Received: by 10.114.2.40 with SMTP id 40mr4190289wab.181.1259938648948;
        Fri, 04 Dec 2009 06:57:28 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm2555395pzk.6.2009.12.04.06.57.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 06:57:28 -0800 (PST)
Subject: Re: [PATCH v7 4/8] Loongson: YeeLoong: add battery driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-laptop@vger.kernel.org, Hongbing Hu <huhb@lemote.com>
In-Reply-To: <20091204080408.GA1540@ucw.cz>
References: <cover.1259932036.git.wuzhangjin@gmail.com>
         <059fa216d70771a6341edb2db4cc559e958273e9.1259932036.git.wuzhangjin@gmail.com>
         <20091204080408.GA1540@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 04 Dec 2009 22:56:54 +0800
Message-ID: <1259938614.9554.2.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-12-04 at 09:04 +0100, Pavel Machek wrote:
> On Fri 2009-12-04 21:34:17, Wu Zhangjin wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This patch adds APM emulated Battery Driver, it provides standard
> > interface(/proc/apm) for user-space applications(e.g. kpowersave,
> > gnome-power-manager) to manage the battery.
> 
> It would be nicer if this went to drivers/power, and used its
> interface -- providing not only percentage but also other values.

There is a version basic on the power supply interface, but it is buggy.

Regards,
	Wu Zhangjin
