Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 16:25:44 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:45467 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S22301802AbYJXPZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 16:25:29 +0100
Received: by ug-out-1314.google.com with SMTP id q7so524744uge.2
        for <linux-mips@linux-mips.org>; Fri, 24 Oct 2008 08:25:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=sVW5h5F/Y0I0k3bn9DjwMU1ZvTtI8osRDECUYsFgad8=;
        b=FdVUQHplx2RdPxcN/tgiY68ldfTf4agsG/iP1e8Yx1Fluu3iYy2RT+7sQNjuuMT7Qa
         Jfe9wlN5FcNbwlG4wA8ByLkvV5HDf31NT/rekqxF50swzIxJBhKxS9PWgh18U/L8Ms6a
         NF8QyPXab5JHXEdWAU4o8ZRqXqa6u8uFPn+Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=fRLWJIVt6r04wPqHwjlIvfIymsBRpCzCRlHH3mqWI+SWbk17LAuYJ5rcx9U8Qws0vR
         7g7FEopJ7R+LI1w/rt1ZrwEu1NdWkyYCpqFAUs0FYdmvvzX3cOeZQySsOeW26xe8pBhB
         J0tRjj1Dpy21JrvxsV+26qEri5wKsCa7MWP/w=
Received: by 10.103.191.12 with SMTP id t12mr1098011mup.118.1224861925491;
        Fri, 24 Oct 2008 08:25:25 -0700 (PDT)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
        by mx.google.com with ESMTPS id u26sm289471mug.5.2008.10.24.08.25.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 08:25:24 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH][MIPS] fix rb532 build error
Date:	Fri, 24 Oct 2008 17:25:12 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
References: <20081025002124.de64b4f4.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20081025002124.de64b4f4.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200810241725.12521.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello Yoichi,

Le Friday 24 October 2008 17:21:24 Yoichi Yuasa, vous avez écrit :
> arch/mips/pci/fixup-rc32434.c: In function 'pcibios_map_irq':
> arch/mips/pci/fixup-rc32434.c:46: error: 'GROUP4_IRQ_BASE' undeclared
> (first use in this function) arch/mips/pci/fixup-rc32434.c:46: error: (Each
> undeclared identifier is reported only once
> arch/mips/pci/fixup-rc32434.c:46: error: for each function it appears in.)
> make[1]: *** [arch/mips/pci/fixup-rc32434.o] Error 1
>

Adrian Bunk already submitted a similar patch few days before. This one or his 
are fine. Thank you.

> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

Acked-by: Florian Fainelli <florian@openwrt.org>
