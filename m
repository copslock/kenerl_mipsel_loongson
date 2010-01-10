Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2010 10:11:33 +0100 (CET)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:34216 "EHLO
        mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490960Ab0AJJL3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Jan 2010 10:11:29 +0100
Received: by fxm3 with SMTP id 3so10512912fxm.24
        for <multiple recipients>; Sun, 10 Jan 2010 01:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=ZZicUQyWLfCzVN/FEFiEydjV6gLDiCFlcP6/gk2vSjc=;
        b=wzbXuSoUDjaO2AbxBUw9UKWUZ4IYAxkH18GAdmrvU7p+XatSvNCq2terGa3+EknqEx
         1wSrmkpHKsKZttgDkhr47VMtiInnfcY7/dWnknXV4V6D9oAFwUujTId7Yn/xkzuzpsaW
         1RBGQAWNe5KUASlADHI+1tAd5R8KWBlXeB104=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=lOI3GOFQKwhIQDFXdyQ9UDnFxA3l/PmzxFUfMyCcv+6ZzEI/0ozicDz8qYDpxdZ6Yz
         6XhzZvzxRwTZKa3i39AYxgDVTAac9y7OQZeML4J6L8pbFE85KkOWbcCVSy5+DTfcS8cB
         JBQcn4jmy/z3+LfVz8enf6TCwqorHSXt9oaR8=
Received: by 10.223.75.136 with SMTP id y8mr7775189faj.69.1263114683792;
        Sun, 10 Jan 2010 01:11:23 -0800 (PST)
Received: from ?192.168.255.16? (a91-152-69-107.elisa-laajakaista.fi [91.152.69.107])
        by mx.google.com with ESMTPS id 15sm9046197fxm.2.2010.01.10.01.11.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Jan 2010 01:11:22 -0800 (PST)
Subject: Re: [PATCH 4/4] MTD: include ar7part in the list of partitions
 parsers
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>, ralf@linux-mips.org
In-Reply-To: <201001032117.37459.florian@openwrt.org>
References: <201001032117.37459.florian@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 10 Jan 2010 11:11:21 +0200
Message-Id: <1263114681.7315.136.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
Content-Transfer-Encoding: 8bit
X-archive-position: 25552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6452

On Sun, 2010-01-03 at 21:17 +0100, Florian Fainelli wrote:
> This patch modifies the physmap-flash driver to include
> the ar7part partition parser in the list of parsers to
> use when a physmap-flash driver is registered. This is
> required for AR7 to create partitions correctly.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Taken this to my l2-mtd-2.6/dunno tree.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
