Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2011 16:19:56 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:40055 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491061Ab1DGOTx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2011 16:19:53 +0200
Received: by wyb28 with SMTP id 28so2758609wyb.36
        for <multiple recipients>; Thu, 07 Apr 2011 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=OyXlaeCrGn3/nT1W/FGnZRrv5BU64jomkUEKgasbYQg=;
        b=cBqA23WSIzDzOd/ubcorMAARoz74vf1JGWq5e4It76RHI/Ls9tXusdMA7FQs6SE5z0
         sHVkHJ62bo4+Qmu0V1JkNCX86sfTVPiCTXfxZs2xrFkNFzIPeF9/852l4XGZwrLBGpzL
         dVxn9Hlhg6Xs2jik2v7WE2QWLFpnlZJeTQcXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=kVN7semO6gNIrQtO9sh2ZGPaC3yXqTbDTd884SurVj2w4F+yHWFG2/GsUzzgwl8Jb8
         8ISbAr59Ztt4aA3yL4YRF/lUz4mOFRyO7eCHXPWclgZQc503F1lBbCNxARvEGq0c8qeC
         2YCq+lW5dYfrkSHApP7JIuLo8Vvf7GwnK+7F0=
Received: by 10.227.202.149 with SMTP id fe21mr935624wbb.205.1302185988031;
        Thu, 07 Apr 2011 07:19:48 -0700 (PDT)
Received: from ?IPv6:::1? (shutemov.name [188.40.19.243])
        by mx.google.com with ESMTPS id w12sm1087618wby.7.2011.04.07.07.19.45
        (version=SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 07:19:46 -0700 (PDT)
Subject: Re: [PATCH V8] MIPS: lantiq: add NOR flash support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <4D9DC4B7.2080706@mvista.com>
References: <1302013192-8854-1-git-send-email-blogic@openwrt.org>
         <4D9DC4B7.2080706@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 07 Apr 2011 17:17:03 +0300
Message-ID: <1302185823.2407.48.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Content-Transfer-Encoding: 8bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

I've taken this patch to l2 tree, but I can change it with a new version
easily.


-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
