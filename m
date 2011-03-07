Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2011 10:00:15 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:39872 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491036Ab1CGJAM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Mar 2011 10:00:12 +0100
Received: by wwe15 with SMTP id 15so4239072wwe.24
        for <multiple recipients>; Mon, 07 Mar 2011 01:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=nmM6ASsNO7sMYFATQoqN5B7MvJ2AU85hJ3FaMo5bKq8=;
        b=ohPeP8oGV2DnIURDzKtFn1PjtIduq8AsqgJyc/94GPoGYoRglKui7ZqLLN/gNJfFif
         MIXJn/r+b4mLNbFrNDzH0nU7APQEP2TwqjXZv3rRK+H2diDQNJGGC9vjz0VZO5SPWSUu
         hFei6JpSEABsL8W6lb2des2hp0U9c/ZPr33yU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=JdqkfNuPfv1cQKHE8WeN/vvyIvtCb+Fia66Ic1JjV8vFeL9T70dHt+I6VA/6W9tjWm
         E5caDZ+wL1uI430hIWRoNaJKm8d286D5lxMLMsWMA6v9iyTZZ9nSVC6UWCTcSinU3jXc
         Ntne4ev8o18K6au7kRvB4rJQJFs4W3wt+w1qU=
Received: by 10.216.221.14 with SMTP id q14mr2165055wep.49.1299488406259;
        Mon, 07 Mar 2011 01:00:06 -0800 (PST)
Received: from ?IPv6:::1? (shutemov.name [188.40.19.243])
        by mx.google.com with ESMTPS id n1sm1156660weq.7.2011.03.07.01.00.02
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 01:00:04 -0800 (PST)
Subject: Re: [PATCH V2 06/10] MIPS: lantiq: add NOR flash support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1298996006-15960-7-git-send-email-blogic@openwrt.org>
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org>
         <1298996006-15960-7-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 07 Mar 2011 10:58:40 +0200
Message-ID: <1299488320.2746.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.1 (2.32.1-1.fc14) 
Content-Transfer-Encoding: 8bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2011-03-01 at 17:13 +0100, John Crispin wrote:
> NOR flash is attached to the same EBU (External Bus Unit) as PCI. As described
> in the PCI patch, the EBU is a little buggy, resulting in the upper and lower
> 16 bit of the data on a 32 bit read are swapped. (essentially we have a addr^=2)
> 
> To work around this we do a addr^=2 during the probe. Once probed we adapt
> cfi->addr_unlock1 and cfi->addr_unlock2 to represent the endianess bug.
> 
> Changes in V2
> * handle the endianess bug inside the map code and not in the generic cfi code
> * remove the addr swizzle patch
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-mtd@lists.infradead.org

There are a couple checkpatch.pl warnings, would you please address them
and resend?

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
