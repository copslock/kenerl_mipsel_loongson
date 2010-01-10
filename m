Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2010 10:13:45 +0100 (CET)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:49800 "EHLO
        mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490960Ab0AJJNl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Jan 2010 10:13:41 +0100
Received: by fxm3 with SMTP id 3so10513471fxm.24
        for <multiple recipients>; Sun, 10 Jan 2010 01:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=gSIDD2UwK/s2Ohzf7D4aI/Vd4VyjdH9TRFQ14eUZmK8=;
        b=Uti590pAvA5NHbxLJdKMUaOmCX8ZTutvXBklUFpuao0c8eWFhqpFKEuet70dw5VrM3
         GwJDUSleED8Hf0GRKjVQNnvesPIYVi2KdsFWx0uilBb6nXEmnIhCyzP96acu+lh/ssJU
         ndjF1nvgctksonyuVZ7DMBz7B/RyjY2+g+g78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=R8fAYG/t/seKEhkBFjU415KtNSqNm0hcJSjNDlNVs6NbZmnk6FC7E531j8H1pR6CON
         eNrPVQrk2F/i1wd5qyaGH+8nkhO2Shd6d/9hXOxINyp8PmtyELblYIU3Q0sgMwmXxk/1
         2HegeJwNxqmSaL/F0HSRJzGBAhOgmqXrLjG1M=
Received: by 10.223.5.90 with SMTP id 26mr7821286fau.59.1263114816011;
        Sun, 10 Jan 2010 01:13:36 -0800 (PST)
Received: from ?192.168.255.16? (a91-152-69-107.elisa-laajakaista.fi [91.152.69.107])
        by mx.google.com with ESMTPS id 14sm9058245fxm.3.2010.01.10.01.13.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Jan 2010 01:13:35 -0800 (PST)
Subject: Re: [PATCH 4/4] MTD: include ar7part in the list of partitions
 parsers
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>, ralf@linux-mips.org
In-Reply-To: <1263114681.7315.136.camel@localhost.localdomain>
References: <201001032117.37459.florian@openwrt.org>
         <1263114681.7315.136.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 10 Jan 2010 11:13:33 +0200
Message-Id: <1263114813.7315.137.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
Content-Transfer-Encoding: 8bit
X-archive-position: 25553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6454

On Sun, 2010-01-10 at 11:11 +0200, Artem Bityutskiy wrote:
> On Sun, 2010-01-03 at 21:17 +0100, Florian Fainelli wrote:
> > This patch modifies the physmap-flash driver to include
> > the ar7part partition parser in the list of parsers to
> > use when a physmap-flash driver is registered. This is
> > required for AR7 to create partitions correctly.
> > 
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> 
> Taken this to my l2-mtd-2.6/dunno tree.

And removed after looking at the discussion :-)

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
