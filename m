Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2011 11:34:21 +0200 (CEST)
Received: from arroyo.ext.ti.com ([192.94.94.40]:34768 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490985Ab1GYJeO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jul 2011 11:34:14 +0200
Received: from dlep34.itg.ti.com ([157.170.170.115])
        by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6P9Y6NY014927
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 25 Jul 2011 04:34:07 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
        by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p6P9Y6r0005934;
        Mon, 25 Jul 2011 04:34:06 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
        by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6P9Y6Cj008700;
        Mon, 25 Jul 2011 04:34:06 -0500 (CDT)
Received: from dlelxv22.itg.ti.com (172.17.1.197) by dlee74.ent.ti.com
 (157.170.170.8) with Microsoft SMTP Server id 8.3.106.1; Mon, 25 Jul 2011
 04:34:06 -0500
Received: from [172.24.64.9] (h64-9.vpn.ti.com [172.24.64.9])   by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6P9Y5QG015447;      Mon, 25 Jul
 2011 04:34:05 -0500
Message-ID: <4E2D388C.1080407@ti.com>
Date:   Mon, 25 Jul 2011 10:34:04 +0100
From:   Liam Girdwood <lrg@ti.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V4 2/3] ASoC: Add a DB1x00 AC97 machine driver
References: <1311502311-16916-1-git-send-email-manuel.lauss@googlemail.com> <1311502311-16916-3-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1311502311-16916-3-git-send-email-manuel.lauss@googlemail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-archive-position: 30708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lrg@ti.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17497

On 24/07/11 11:11, Manuel Lauss wrote:
> Add a machine driver suitable for the AC97 part on the DB1000/DB1500/DB1100
> boards.
> 
> Run-tested on DB1500.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

Acked-by: Liam Girdwood <lrg@ti.com>
