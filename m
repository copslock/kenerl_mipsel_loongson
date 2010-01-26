Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 21:46:50 +0100 (CET)
Received: from gv-out-0910.google.com ([216.239.58.185]:25605 "EHLO
        gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493447Ab0AZUqq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 21:46:46 +0100
Received: by gv-out-0910.google.com with SMTP id r4so388130gve.2
        for <linux-mips@linux-mips.org>; Tue, 26 Jan 2010 12:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=PBiBp8m8qZSFzf+UGIsjavv9sdtiH2SoU62x5MdR5Vo=;
        b=rIVG1JvEvBaLBsDhIJzTCYHpbIdtcWTbP1qQJSw8lm7hV3w5IOT0XEGJWVbA3ANntZ
         XOHgwiY/WZXpHYrR4iB9T+U4IfbVp/mfXnUXBvp9F/zh25uYibkt/pZkEdM73vJPpiii
         coldXJcJaTsVvr2Ev1PSwFcsppjjVAFjgZILs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qn18P9n3Ejh6Jf2n5YPCHsK0wMm6PH4Lnznhu9ZXUsli17tHChdBTtn1FAgLqVwLJH
         yC+d+TrWehG6gTma05RcF0A3Elv24pr+cdFw3tftjmdVHTERXX+RVBOtpSBxMeeV5xyC
         wXDsx3YfZClVi7V//5CBC7FfzKRvWxspn4jDE=
MIME-Version: 1.0
Received: by 10.103.80.20 with SMTP id h20mr4323772mul.88.1264538805510; Tue, 
        26 Jan 2010 12:46:45 -0800 (PST)
In-Reply-To: <hhq35v$m1q$1@ger.gmane.org>
References: <hhq35v$m1q$1@ger.gmane.org>
Date:   Tue, 26 Jan 2010 21:46:45 +0100
Message-ID: <f861ec6f1001261246y545e7a9ahe11eaf16fd587959@mail.gmail.com>
Subject: Re: [RFC] Support 36-bit iomem on 32-bit Au1x00
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     "pascal@pabr.org" <pascal@pabr.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 25691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16929

Hi Pascal,

On Sun, Jan 3, 2010 at 1:39 PM, pascal@pabr.org <pascal@pabr.org> wrote:
> Hi,
>
> I believe these changes are needed on Alchemy SoCs in order to
> use iomem above 4G with the usual platform_device machinery:
>
> - Set CONFIG_ARCH_PHYS_ADDR_T_64BIT to make resource_size_t 64-bit.
> - Increase IOMEM_RESOURCE_END so that platforms can register resources.

Have you tried to register a platform device above the 4G line?  I get an oops
inside the platform device match code  when I do.  I'll try to figure out why.

Manuel
