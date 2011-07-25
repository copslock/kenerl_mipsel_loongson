Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2011 11:34:49 +0200 (CEST)
Received: from comal.ext.ti.com ([198.47.26.152]:40902 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490985Ab1GYJeo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jul 2011 11:34:44 +0200
Received: from dlep36.itg.ti.com ([157.170.170.91])
        by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6P9YbE6025056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 25 Jul 2011 04:34:37 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
        by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6P9YbQH024352;
        Mon, 25 Jul 2011 04:34:37 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
        by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6P9Yb0B009684;
        Mon, 25 Jul 2011 04:34:37 -0500 (CDT)
Received: from dlelxv22.itg.ti.com (172.17.1.197) by dlee74.ent.ti.com
 (157.170.170.8) with Microsoft SMTP Server id 8.3.106.1; Mon, 25 Jul 2011
 04:34:37 -0500
Received: from [172.24.64.9] (h64-9.vpn.ti.com [172.24.64.9])   by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6P9YaJc015516;      Mon, 25 Jul
 2011 04:34:36 -0500
Message-ID: <4E2D38AB.6050307@ti.com>
Date:   Mon, 25 Jul 2011 10:34:35 +0100
From:   Liam Girdwood <lrg@ti.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V4 3/3] ALSA: deprecate MIPS AU1X00 AC97 driver
References: <1311502311-16916-1-git-send-email-manuel.lauss@googlemail.com> <1311502311-16916-4-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1311502311-16916-4-git-send-email-manuel.lauss@googlemail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-archive-position: 30709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lrg@ti.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17498

On 24/07/11 11:11, Manuel Lauss wrote:
> Now that an ASoC variant is available, tell users that this
> driver is now living on borrowed time...
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> V4: no changes.
> V3: mark driver DEPRECATED instead of removing it outright.
> 

Acked-by: Liam Girdwood <lrg@ti.com>
