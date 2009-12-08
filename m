Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 08:24:04 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:61601 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491038AbZLHHYB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 08:24:01 +0100
Received: by pwj1 with SMTP id 1so560018pwj.24
        for <multiple recipients>; Mon, 07 Dec 2009 23:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9Azll/cri+PmH84SlqOfxxcldTFkyAX/9I1WJuJEunQ=;
        b=JM1wv0vmxdZL3UNHDY0/6z+VY8c56S3xg3+7xV2LfcnOe+s/GhystTakGF91W29pWC
         dzRANrb2uLIaOyF4rjFzXn/OeK2rwXFnt7/u6fvacnDFHRIO3YaUq4FAcdvu7tBuWv9J
         k4xpFxjC2jNjluPfAccBEQ15O4/GUY8Czi8/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TRuO+TsH5dThIkZWPiy+sdlAEU/lkKd//0W6OS1G8S7B3Jv72P7mWR+LF4SZFXNbnk
         Uj4k5VJ9coCp191TOHwE/KJ54dBq60+WS86zMU/K060MxHahcR1Cuy/TN6AMjg8UNwZL
         csDz5rf/4Q/DKQoHvbK4B6ijecNFtggIgeU0E=
Received: by 10.115.86.7 with SMTP id o7mr14312754wal.50.1260257032395;
        Mon, 07 Dec 2009 23:23:52 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-24-6-153-137.hsd1.ca.comcast.net [24.6.153.137])
        by mx.google.com with ESMTPS id 20sm5768379pzk.13.2009.12.07.23.23.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 23:23:51 -0800 (PST)
Date:   Mon, 7 Dec 2009 23:23:47 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v8 8/8] Loongson: YeeLoong: add input/hotkey driver
Message-ID: <20091208072347.GH11147@core.coreip.homeip.net>
References: <cover.1260082252.git.wuzhangjin@gmail.com> <b164d5bb79963a57621d024c22e5664de0ff8662.1260082252.git.wuzhangjin@gmail.com> <20091207064857.GG21451@core.coreip.homeip.net> <1260255131.3315.25.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1260255131.3315.25.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 08, 2009 at 02:52:11PM +0800, Wu Zhangjin wrote:
> Hi, Dmitry Torokhov
> 
> I plan to send another revision of this patchset, Can I get your
> Acked-by: for this patch?
> 

Yes, as far as the input code goes:

	Acked-by: Dmitry Torokhov <dtor@mail.ru>

Thanks.

-- 
Dmitry
