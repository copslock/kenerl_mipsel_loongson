Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 07:32:23 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34189 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029006AbcEXFcUkkXCJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 07:32:20 +0200
Received: by mail-pf0-f195.google.com with SMTP id 145so957341pfz.1
        for <linux-mips@linux-mips.org>; Mon, 23 May 2016 22:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OjDPRfP2GGVtVbOhEqvPd9B9Zl83ryPkIjn2ZYxZBg0=;
        b=qejQvWXD4YUxLDXM2aRlMD0TPka1yesOjZHulsYjtphtsWw1Z76Wx0rsEQMNR9PfkG
         mljMKSv5dWI2FCEPkE5drUukMltxI+7+ficiv5otemoXWT/LKZFofWGlui9jmo2jCGuy
         vsGgGcT/Rzfj1gfVr1CRkQMEwDzmTQrx/XmWWOR9W76grZRJx3unKNg7IMhq774JEJGG
         UsMRud6dDyvqh59XiwxtFQSNOiARQGubs1E/LU/wIOP6tUa3UeMW7OYpHJnAAmIVVb9P
         5RtEDr1s+1GIPPi3Q/omHGGdiYXHcuusz3w7y87Gzo5BOxfXffrsxcpGDr6XmHzUw7qO
         7hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjDPRfP2GGVtVbOhEqvPd9B9Zl83ryPkIjn2ZYxZBg0=;
        b=kEKb5wj6+1uVAuC7EbUgVFddXcoM/z7UV0ehAsOudrsiw3DxP0hEmdvBShg98oQTnv
         7fLZrNzQf8Hbxy2CgvRvJQacDvvOE1s5KfeUwbUauK1qtB37GFD0eCUmNjfAwEG6sVSJ
         F7XfXgOMvak/CGkSJ2d5/TmLdx+qui3z5CT8stVwiPi24OTNHyuCiNLR/qkUW6lfg90h
         1gKlY/rCgkMJGBjQ5Wpvw+LGADHCyHRM/Z7maUuD4v6IwGcZx7X0/+bt7LnUn/0LoUOD
         l9t2S7mfcj/MApkAB54yMxnBbGkfMdtMhtNxV7z+P9VvxPvEIGSOznBdxfXHqoNXg/aS
         LI5Q==
X-Gm-Message-State: ALyK8tKqZCGg5JO6O20K9mDp582hGA8PuFztEZAg4TnURk0qnX1b7Gxeb3HiQDLaRAmQJA==
X-Received: by 10.98.157.146 with SMTP id a18mr3913491pfk.117.1464067934221;
        Mon, 23 May 2016 22:32:14 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:f573:6891:973c:b422? ([2601:645:c200:33:f573:6891:973c:b422])
        by smtp.gmail.com with ESMTPSA id h5sm1555849pat.0.2016.05.23.22.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2016 22:32:13 -0700 (PDT)
Message-ID: <1464067930.27173.7.camel@chimera>
Subject: [RFC PATCH] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org, Jonas Gorski <jogo@openwrt.org>,
        Mathias Kresin <openwrt@kresin.me>
Date:   Mon, 23 May 2016 22:32:10 -0700
In-Reply-To: <1464041521.5475.18.camel@chimera>
References: <574372CD.1060201@hauke-m.de> <5743777F.9060801@hauke-m.de>
         <1464041521.5475.18.camel@chimera>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

