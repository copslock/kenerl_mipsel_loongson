Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2011 15:00:54 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:62199 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491171Ab1DENAv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Apr 2011 15:00:51 +0200
Received: by bwz1 with SMTP id 1so318312bwz.36
        for <multiple recipients>; Tue, 05 Apr 2011 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=SJpkY1fQtx8wcehJXAEfOQcnNAz/OEkUkK2T/Wpp0WA=;
        b=wZKhIBwjevF5rHEobZtp6GjXH/ZXR+jlRNeFaFD4QIucpL3pHt563pWw3JWApKdADI
         w5/j8mMkO7mNdQwILLHZPXtEchweiIjnOUxHH4N8ILAERWZ/SpqiIxpaTvU9zsCOinhU
         ZSUvDGKxHv5Wl5nrlL1VQFnt+2MBJ3EjCww6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=F4zE06evtq1vxpPQoTudC+8bhXVkKjEiefFDahz0lSZrxNppZqpFxlTsWs+jyZA0JE
         3+a6tki4Vh/QY4iU9gBFmWTkrrk5lJ1qB4djw9kwsDoPcpYXqHzvuaBLqKCV2xcwD4WL
         2TCcGvxSY6V5Mr2BubwGsxf4uDTzKgeYQARps=
Received: by 10.204.57.135 with SMTP id c7mr7261738bkh.88.1302008444113;
        Tue, 05 Apr 2011 06:00:44 -0700 (PDT)
Received: from ?IPv6:::1? (shutemov.name [188.40.19.243])
        by mx.google.com with ESMTPS id k5sm3743870bku.4.2011.04.05.06.00.42
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 06:00:43 -0700 (PDT)
Subject: Re: [PATCH V7] MIPS: lantiq: add NOR flash support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <4D9B11C5.3030308@openwrt.org>
References: <1302006830-10345-1-git-send-email-blogic@openwrt.org>
         <1302006995.2760.120.camel@localhost>  <4D9B11C5.3030308@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 05 Apr 2011 15:58:04 +0300
Message-ID: <1302008284.2760.129.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Content-Transfer-Encoding: 8bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2011-04-05 at 14:57 +0200, John Crispin wrote:
> we could dynamically allocate the instance of struct map_info and then
> use map_priv_1 to indicate whether the device is probing or not.

Yeah, may be you could indeed use map_priv_1 instead of the global
variable already now? 

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
