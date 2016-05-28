Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2016 21:05:17 +0200 (CEST)
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33936 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27037735AbcE1TFPfXxFd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 May 2016 21:05:15 +0200
Received: by mail-pf0-f176.google.com with SMTP id 62so7410236pfd.1
        for <linux-mips@linux-mips.org>; Sat, 28 May 2016 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ym1YrwcGj0Y1h+EE96SvPkyIaE5x7tNPmdsGXHFefCk=;
        b=Gl/oCmKcMc+KISatzKOdins5AnQho62/QorXKmlhkf9lLTTrjv0BhrsG1QsoDm6PG/
         q8mWedFZdTOVLct+lUs4HW4S9J2SuJ5hUBjvnJkpxDh5TvBiTbZd89NfEUt7rtU2JU/M
         hoSNIujXNitHW/9axdyKeKIPQfeZu7t85dH2FThi0zNd68AwuIFd7FWILWW2BGjwAf27
         zFtn1p2DTbFo9OGUwoQls85uEHag546l3+kCahC/nGzTBzkUJn9NKO+byD+MQTDGyu2m
         mcg2mYL90+POBwZnO5zKjcoDuT5AtLHil65hTpmkp9ye4XqQTitPu88mQ/B4aUjHK7eU
         0FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ym1YrwcGj0Y1h+EE96SvPkyIaE5x7tNPmdsGXHFefCk=;
        b=bD5Y7oxVN0593OuvEmLaK8onesGbLLjj3U9u9VepLm4iH//TcxkZ5c69S7MO8XZ29E
         t5IZD/VzeXMglmFo/DYxrOp9vdRFf64VDW3+xdwAp6zDCuRqzfisJkx3sL1EYNeiEFMi
         RytWinSQHwcbZPIiSolLZ2qyvQ4x4E9zakzHEVmvyx9733PeJyBgjUJacqYGq9LPal5f
         hL4nSDjH2m/qUinqYZCDw+LvBQ9VzZEucRVbTuECSiUmvcd+s9byec+Kih5ZFmkkD9At
         2kfWZrgQdlxe6e7C0y4yUroI440pwWCUbBoecuXOdEiJqSNM9ffEz4WzdYTX53u/0x+p
         SU/w==
X-Gm-Message-State: ALyK8tIwwcOkckxsPytNUqSSL2g4FaXKZPQ2irf/U6ja+U0a1EnBW40Dai895S+gK4TIPQ==
X-Received: by 10.98.91.195 with SMTP id p186mr31892151pfb.81.1464462309444;
        Sat, 28 May 2016 12:05:09 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:b546:9ef3:e6a7:b5eb? ([2601:645:c200:33:b546:9ef3:e6a7:b5eb])
        by smtp.gmail.com with ESMTPSA id a19sm22311605pfc.57.2016.05.28.12.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 May 2016 12:05:08 -0700 (PDT)
Message-ID: <1464462306.5020.25.camel@chimera>
Subject: Re: [PATCH v2] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org, hauke@hauke-m.de, jogo@openwrt.org,
        openwrt@kresin.me
Date:   Sat, 28 May 2016 12:05:06 -0700
In-Reply-To: <20160528133152.cc8b7fad8665b20a3519f4e0@gmail.com>
References: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
         <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
         <20160528133152.cc8b7fad8665b20a3519f4e0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53689
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

On Sat, 2016-05-28 at 13:31 +0300, Antony Pavlov wrote:
>   Can we use 'if' instead of preprocessor's '#if' here?
> 
>   If we use regular C 'if' operator with IS_ENABLED() instead of
> '#if/#ifdef'
>   then the compiler can check all the code.
> 
>   E.g. please see this barebox patch:
> 
> 
> http://lists.infradead.org/pipermail/barebox/2014-February/017834.html

Sigh. I guess I will resubmit again…
