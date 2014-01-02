Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 22:35:57 +0100 (CET)
Received: from mail-ob0-f175.google.com ([209.85.214.175]:53901 "EHLO
        mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821116AbaABVfzK81iC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 22:35:55 +0100
Received: by mail-ob0-f175.google.com with SMTP id uz6so14897412obc.34
        for <multiple recipients>; Thu, 02 Jan 2014 13:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CNaqSlQKQ8JJBTWZi+7yiNr2VVFodTUf2VIpEe//kb8=;
        b=1Gm/F3mrvH7fyEx7oLyVFr1q3wP8RhpgDlfbrMX2RJmXQ6coQvjn8J+wNxiTNGNb7q
         RK6GRYLVUwGnv5Zz9b8snCtatFP3SeW3x5VELKbJxd6qWF8DpVyGv0yrSmAJMVOeWkwz
         T8lsKDt0B8wyn2QBHy1pkSKz9AofdSzu/3nTFb38726nvcJhNDn+gzVhkqZ/8CA/+VUp
         nu7G19Yk1SlE3mBMNbWfeWSdwNgED46B/bIUfCdVpiTPYYc6eTO5V268a5na3uDuor7M
         14eE3NCI6Eil3E1Z4R3idX/ACqoKETy370H/F041kbGCAVKL1AjEdTNcZleZYnzTPb7o
         IDqA==
MIME-Version: 1.0
X-Received: by 10.182.246.39 with SMTP id xt7mr56735033obc.16.1388698548512;
 Thu, 02 Jan 2014 13:35:48 -0800 (PST)
Received: by 10.76.69.7 with HTTP; Thu, 2 Jan 2014 13:35:48 -0800 (PST)
In-Reply-To: <1388687138-8107-1-git-send-email-hauke@hauke-m.de>
References: <1388687138-8107-1-git-send-email-hauke@hauke-m.de>
Date:   Thu, 2 Jan 2014 22:35:48 +0100
Message-ID: <CACna6rw1_QXXk0g9tpWVsx5G1zbNQdun5edHkSzkabVfLuxL4A@mail.gmail.com>
Subject: Re: [PATCH 1/4] MIPS: BCM47XX: add Belkin F7Dxxxx board detection
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Cody P Schafer <devel@codyps.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38848
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

2014/1/2 Hauke Mehrtens <hauke@hauke-m.de>:
> From: Cody P Schafer <devel@codyps.com>
>
> Add a few Belkin F7Dxxxx entries, with F7D4401 sourced from online
> documentation and the "F7D7302" being observed. F7D3301, F7D3302, and
> F7D4302 are reasonable guesses which are unlikely to cause
> mis-detection.
>
> It also appears that at least the F7D3302, F7D3301, F7D7301, and F7D7302
> have a shared boardtype and boardrev, so use that as a fallback to a
> "generic" F7Dxxxx board.

Cody, Hauke: I'm starring at this patch for 10 minutes now and it's
still unclear for me.

You say 3301, 3302, 7301 and 7302 have the same board_* entries
stating they can be treated with a generic ID entry. At the same time
you define BELKIN_F7D3301 and BELKIN_F7D3302... so they are not
identical after all? Finally what about 4302? I can see it's untested,
but for some reason you assign it to the separated enum entry. Is this
not going to share config with the generic ones?

Sorry, but it looks really messy to me.
