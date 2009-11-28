Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Nov 2009 07:14:41 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:61775 "EHLO
        mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492007AbZK1GOh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Nov 2009 07:14:37 +0100
Received: by pxi6 with SMTP id 6so1597003pxi.0
        for <multiple recipients>; Fri, 27 Nov 2009 22:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=znvHAQRETL/RcSW85K2uCUnH+85lxmxTUj785nKqnMc=;
        b=wtGDuPvNuSktCV3tW+Ox9VWD+Ds9tt67SsjyTCCVnoxRabhTOIGAqSfyRGKAznBgPg
         Xt6GvcjrqI8NhFfXdmMXzTf6dWg+wVaFQwdVSo8PBoOhKU+IBL6tUBi5bTJkGV5sEiQb
         ptCrkTAmJp4bwmOlCKLvxi6rq046dcV8I0XM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=h7pbD/mY5wHESMZGmpDlHxwLGouFS1SKSTs6szm6Rwd687C0nhrdDPDpVjOP4FISgs
         dlzoLzANnaRPCDSnHLHztICyHlBUtuywaHosL/SvWZ3NhxUcuf7MByBYeoXMFYmIzPED
         m7AIPXH7B9dSrB4Q8DCPuAGE20iYWY67ssqoo=
Received: by 10.114.189.37 with SMTP id m37mr3194119waf.67.1259388870114;
        Fri, 27 Nov 2009 22:14:30 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm1695010pzk.5.2009.11.27.22.14.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 22:14:29 -0800 (PST)
Subject: Re: [PATCH] [loongson] Cleanups of serial port support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <20091127150803.GB5971@linux-mips.org>
References: <1259067244-7487-1-git-send-email-wuzhangjin@gmail.com>
         <20091127150803.GB5971@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 28 Nov 2009 14:14:11 +0800
Message-ID: <1259388851.3149.4.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-11-27 at 15:08 +0000, Ralf Baechle wrote:
> On Tue, Nov 24, 2009 at 08:54:04PM +0800, Wu Zhangjin wrote:
> 
> > This can not be folded into the old cleanup ;)
> 
> The reason I've not applied it yet is because the patch rejects and that is
> probably because I seem to be missing another patch which needs to be
> applied before this one can be applied - but I have nothing left in
> patchworks.

Thanks, will send a new one to you.

Regards,
	Wu Zhangjin
