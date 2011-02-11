Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2011 16:09:08 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:64677 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491842Ab1BKPJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Feb 2011 16:09:04 +0100
Received: by fxm19 with SMTP id 19so2869406fxm.36
        for <multiple recipients>; Fri, 11 Feb 2011 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=7U9WCNaUDeIwDmGkV8ZoG/M4DBGZGi2W2Ut2c19CSzQ=;
        b=yB3ArXbKt5vcVqGoLXpsBOejVaFr5qhN0Xuy/wSvhW5d7YDnHaWQKwIvHip4FNd/8w
         5DhMXxr/avGOcJdbDb5W1QRxyxC/Y1DBjKmNRWhljgn0k++u8hMu8ByW+G/q0bcZOp5a
         lZxyeA+CGAkroywa7qzzeoMn+4A9Cx4h2Vvt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=v5D7z0CQADiohENIdgG6Qw3pfcDCg+m67VWS9pfK3eV0LCC+nJ46PqBKELGgajM6/t
         HSc1wLVDN2ArBG1X1ffFmvFRZY7h6Lg4Mylk3UcmrAgkUMHrtrdMk9YgN5I2c4/IT5zy
         4NsiWnnBMAOtqOzbMT4hOkpTwoQb7jm2cTqJo=
Received: by 10.223.100.16 with SMTP id w16mr610761fan.85.1297436939258;
        Fri, 11 Feb 2011 07:08:59 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id y1sm405445fak.39.2011.02.11.07.08.56
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 07:08:58 -0800 (PST)
Subject: Re: [PATCH 4/6] Platform support MSP onchip USB controller.
From:   Anoop P A <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <20110211140600.GA23348@linux-mips.org>
References: <1295943725-20308-1-git-send-email-anoop.pa@gmail.com>
         <20110211140600.GA23348@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 11 Feb 2011 20:59:27 +0530
Message-ID: <1297438167.29250.72.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2011-02-11 at 15:06 +0100, Ralf Baechle wrote:
> On Tue, Jan 25, 2011 at 01:52:05PM +0530, Anoop P.A wrote:
> 
> > +#ifdef CONFIG_MSP_HAS_DUAL_USB
> > +#define NUM_USB_DEVS   2
> > +#else
> > +#define NUM_USB_DEVS   1
> > +#endif
> 
> I thought you meant to replace CONFIG_MSP_HAS_DUAL_USB with a runtime
> check?

No. I added that as an configuration option will be used in future.
> 
>   Ralf
