Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 15:58:33 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:40568 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493126AbZLDO62 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 15:58:28 +0100
Received: by pzk35 with SMTP id 35so2396582pzk.22
        for <multiple recipients>; Fri, 04 Dec 2009 06:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=0X4PB8dLtgTx1Cf3U8eQuOxnB7xriRauhhJHNpQ/IYI=;
        b=NQAGY0VAuKPMfMSfY8xOLpklTHhtxgAl+FKOgVAcO4thJ/eWOr6cSP6NOkMT75D4qY
         hFICR4oxUTKu9u3hjK1/Ey6My0/0gMtwPLepy+HZipcK4wnKJ+fVtUEaruk03T1YFzdA
         MxerEA2v/D39qPDlq93K0dcPalsQqsWityeb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=EPZPEzkB3o795LYQpfs0BZ8eseFgujXpogQsUkaR4qMrd/bEtEefCSI0xHQhxhnk6L
         BH9+puMokwGSVY4xWDSXyjDZ8Lx4HctoDeqFK81RKTGe937pJcEuAS7PCgD6LsPqSH4X
         NmFGe58TaFcndi9J4UwgjjlxZ7gigOXbuASAY=
Received: by 10.115.38.32 with SMTP id q32mr4294224waj.8.1259938701966;
        Fri, 04 Dec 2009 06:58:21 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm59451pxi.9.2009.12.04.06.58.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 06:58:21 -0800 (PST)
Subject: Re: [PATCH v7 8/8] Loongson: YeeLoong: add input/hotkey driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20091204081402.GD1540@ucw.cz>
References: <cover.1259932036.git.wuzhangjin@gmail.com>
         <7e96d37889c49c2d6d284e21773aef90dd3aac25.1259932036.git.wuzhangjin@gmail.com>
         <20091204081402.GD1540@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 04 Dec 2009 22:57:52 +0800
Message-ID: <1259938672.9554.3.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-12-04 at 09:14 +0100, Pavel Machek wrote:
> Hi!
> 
> 
> > +#define NO_REG		0
> > +#define NO_HANDLER	NULL
> 
> Don't obfuscate code like that.

Will remove it later, thanks!
