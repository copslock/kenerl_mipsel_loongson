Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Jan 2014 00:32:04 +0100 (CET)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:45814 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825752AbaACXcAL6SXA convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Jan 2014 00:32:00 +0100
Received: by mail-wi0-f180.google.com with SMTP id hm19so997176wib.7
        for <multiple recipients>; Fri, 03 Jan 2014 15:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zou0raCQopsBHrwHoLGUhusDAEASsgZLQsvPN7AriQg=;
        b=XY9KdhBjnh0YUJehXUC4OXFLmYs/H/w/P3kicezpRHrw2wRqHBSjpDRsNmDgSqx8Jm
         0ldM374RhLIcD3TI89ag6dNDqn9qM8xNm9Z/sRVWJUjk+Twwo7AKaWygrHS+H7ucVGZ1
         imAYuOnrdi9HE30lyCSu0KT9Nc+McO8aE/l/Hmp01IBFot9+SusURlaVBk5k7qE8Z6uS
         yK2f4PxKqvurTGqy5LfcMTWs/+7VRE0QRcMvx2YBChNLmzYfKadZ1UXE3R+Dp1u6VhYt
         Pa2I4xnryQjA8UydJwEX2MU2p0WsFGAGpPVTRfENJ1fJmHYwuuwen+mgrkI8dNc+Lx9w
         ovGQ==
MIME-Version: 1.0
X-Received: by 10.194.61.211 with SMTP id s19mr1682076wjr.73.1388791914598;
 Fri, 03 Jan 2014 15:31:54 -0800 (PST)
Received: by 10.216.161.137 with HTTP; Fri, 3 Jan 2014 15:31:54 -0800 (PST)
In-Reply-To: <1388778120-24880-2-git-send-email-hauke@hauke-m.de>
References: <1388778120-24880-1-git-send-email-hauke@hauke-m.de>
        <1388778120-24880-2-git-send-email-hauke@hauke-m.de>
Date:   Sat, 4 Jan 2014 00:31:54 +0100
Message-ID: <CACna6ryT_aT=Exg20K3e7GFhUug27GCT5137UKfMvU9gOYq_dg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] MIPS: BCM47XX: add board detection for Linksys
 WRT54GS V1
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

2014/1/3 Hauke Mehrtens <hauke@hauke-m.de>:
> This adds board detection for Linksys WRT54GS V1.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Rafał Miłecki <zajec5@gmail.com>
