Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jul 2010 18:54:23 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:61571 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491937Ab0GRQyS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jul 2010 18:54:18 +0200
Received: by fxm3 with SMTP id 3so2066074fxm.36
        for <multiple recipients>; Sun, 18 Jul 2010 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=tdkpY03EtAKybHqBsPB2pi80nrm1iESFBo56rn7QgrM=;
        b=nfXAl5rlF04z4pt1ZrHwioosFeEFnTxjocga63PTaTKf7zhqw5evwikvCxCzMi3f/p
         9+kXvAd8Z+WIh0AeTKPR1uagenI0ImANG6zxkQqEfsSQQ/qxGVT/Fdne+ATiq4SzypKz
         WesVggnkaUgjCFSmMjQTYhb65O/rYYoCYD+z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=OALJ818eV69LiRNaeP5xD2QJycy8XC7fJf22PyddaPCnfL4JcpXJsVg4K1ObWV2DNF
         kN3AE7OmpxkFloBt0kzFVp1Lm8PpZU1BrNghBpzBqgfDS9vkP2FdCRGtJ8qT8FV6hwiG
         7Jb4K5Wjzu01Menh+JtGmpWr3Q+ouvyMOOmUI=
Received: by 10.223.104.130 with SMTP id p2mr2733736fao.9.1279472052962;
        Sun, 18 Jul 2010 09:54:12 -0700 (PDT)
Received: from [192.168.255.16] (a91-152-69-107.elisa-laajakaista.fi [91.152.69.107])
        by mx.google.com with ESMTPS id h4sm1655487faj.39.2010.07.18.09.54.10
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 09:54:11 -0700 (PDT)
Subject: Re: [PATCH v3] MTD: Nand: Add JZ4740 NAND driver
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
In-Reply-To: <1279368929-21193-1-git-send-email-lars@metafoo.de>
References: <1276924111-11158-18-git-send-email-lars@metafoo.de>
         <1279368929-21193-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 18 Jul 2010 19:54:08 +0300
Message-Id: <1279472048.16247.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
Content-Transfer-Encoding: 8bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2010-07-17 at 14:15 +0200, Lars-Peter Clausen wrote:
> This patch adds support for the NAND controller on JZ4740 SoCs.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-mtd@lists.infradead.org
> 

Do you expect this patch to go in via the MTD tree? I guess it might be
better if it was MIPS tree?
-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
