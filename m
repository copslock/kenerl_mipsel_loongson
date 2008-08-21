Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Aug 2008 15:16:18 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.181]:43819 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20031255AbYHUOQK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Aug 2008 15:16:10 +0100
Received: by wa-out-1112.google.com with SMTP id k22so3286waf.20
        for <linux-mips@linux-mips.org>; Thu, 21 Aug 2008 07:16:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :in-reply-to:references:x-mailer:mime-version:content-type
         :content-transfer-encoding:sender:message-id;
        bh=V6nQgfKX3k9He2LmO7DKGlVV6Mzsc2ScFpUy6IlIOCU=;
        b=FP1xxTbUx/MIX5x5obJhMXp3B/GygLWDT480LoVeZehBLitKUfcgZpkPUu5RWYfsl4
         fzSu1ISgBWFh9l58CVxiUfwcWZIHQwez1lVRJqvv7xEFkNYBe9MtWe2yrM8qd8bBbeuS
         4V2HRRQynXf56xA6RqtjrETgX7aK5/0xs2BoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding:sender
         :message-id;
        b=QiayY3i+V9bZ+zHCNesJBGN3EJHR/YeaJjOXkL+a96fkihv9ZFa//hXvO+Ubv68M8+
         8gFlCplFOuYgP69fIYtJCRXkBwbpZlwCOqr0NRZJLNrAyEViTt33rLInKUpsluNzP2Fl
         iaMv/PZVvzMM+Db/z1v+xbHCExJoaUq0ceGXw=
Received: by 10.114.57.15 with SMTP id f15mr1424137waa.116.1219328167977;
        Thu, 21 Aug 2008 07:16:07 -0700 (PDT)
Received: from delta ( [125.30.7.41])
        by mx.google.com with ESMTPS id 9sm3480943yxs.5.2008.08.21.07.16.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 07:16:07 -0700 (PDT)
Date:	Thu, 21 Aug 2008 23:16:03 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	yoichi_yuasa@tripeaks.co.jp,
	"linux-mips" <linux-mips@linux-mips.org>, ralf@linux-mips.org
Subject: Re: [PATCH] cobalt: group UART definition into header
In-Reply-To: <200808211555.14603.florian@openwrt.org>
References: <200808211303.44865.florian@openwrt.org>
	<48ad7195.c505be0a.3500.4a15@mx.google.com>
	<200808211555.14603.florian@openwrt.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID: <48ad78a7.8905be0a.05df.ffffc44d@mx.google.com>
Return-Path: <tripeaks@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Thu, 21 Aug 2008 15:55:12 +0200
Florian Fainelli <florian@openwrt.org> wrote:

> Hi,
> 
> Le Thursday 21 August 2008 15:45:52 Yoichi Yuasa, vous avez écrit :
> > NAK
> >
> > This value is only used in serial.c.
> > Please define in serial.c.
> 
> console.c also uses it, which was the rationale for my patch.
> 

Sorry, it's my fault.

Yoichi
