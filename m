Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 08:35:01 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:56325 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491042AbZLHHe5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 08:34:57 +0100
Received: by yxe42 with SMTP id 42so5188562yxe.22
        for <multiple recipients>; Mon, 07 Dec 2009 23:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ZeryFTn0xkSrOBJezzPmXau2gbPboPYJS9ddbaxqXfs=;
        b=pvSibhdrl/0JVUSO9iK+dEEaK9pfdy1X5n/0dGhROiNOcIKYte4zCCizoi2+WTjt9a
         sPjUpvAz08kQ4TSZmRw53vW+M09prJ8rmvE5m0VeD3ktqWbDHXA6hn4zzHY/DPSJXuTT
         KeKGqRTi4NjiMBNrlOvtNNNeIQkaYdY1zbBMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=JKWywRXUaYGSyMmbHPVUO6Yo4g0/WgwGcJQMk0C1buvRxzrVxcQbDp/Yzgjsgi+98H
         Tc+0GYeKbYwwLwAKwUd6hQUgwn9JubKwgnbIl7kNSf29BdLEvrnHNZF4NRqSrwc09pHj
         ojjDZUFv3qbrcgn4aO2cGkZtGhX5s8NE/Wi2o=
Received: by 10.90.16.35 with SMTP id 35mr12485179agp.54.1260257691397;
        Mon, 07 Dec 2009 23:34:51 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm3983455iwn.14.2009.12.07.23.34.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 23:34:50 -0800 (PST)
Subject: Re: [PATCH v8 8/8] Loongson: YeeLoong: add input/hotkey driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20091208072347.GH11147@core.coreip.homeip.net>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
         <b164d5bb79963a57621d024c22e5664de0ff8662.1260082252.git.wuzhangjin@gmail.com>
         <20091207064857.GG21451@core.coreip.homeip.net>
         <1260255131.3315.25.camel@falcon.domain.org>
         <20091208072347.GH11147@core.coreip.homeip.net>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 08 Dec 2009 15:34:18 +0800
Message-ID: <1260257658.3315.74.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-12-07 at 23:23 -0800, Dmitry Torokhov wrote:
> On Tue, Dec 08, 2009 at 02:52:11PM +0800, Wu Zhangjin wrote:
> > Hi, Dmitry Torokhov
> > 
> > I plan to send another revision of this patchset, Can I get your
> > Acked-by: for this patch?
> > 
> 
> Yes, as far as the input code goes:
> 
> 	Acked-by: Dmitry Torokhov <dtor@mail.ru>

Added, thanks!

To Ralf:

This patch is based on the sparse keymap library in:

git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input next

from Dmitry Torokhov. that sparse keymap support is also queued for
2.6.33.

Before that support going into mainline, this patch can not be compiled,
so, Ralf, this patch is not appliable before Dmitry's next branch is
pulled by linus.

Thanks!
	Wu Zhangjin
