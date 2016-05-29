Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 May 2016 21:26:58 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34250 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27039115AbcE2T04rCsxg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 May 2016 21:26:56 +0200
Received: by mail-pa0-f48.google.com with SMTP id bz2so25565124pad.1
        for <linux-mips@linux-mips.org>; Sun, 29 May 2016 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lAOnMWwF4qAQcVeNjQH4AwmlxKBfK+M5jR0kCak5yWA=;
        b=cWlQgp5s/hrsqVAZcNsmSt6keRLcRHizD1bYm9fmK8od8zXszWCaylZhxR9lX1FL6/
         zsxy4n3FcmXCrI9Of/TZpqlw+DMQiBCq6OqL+8Eobc79GPzMdgntihRPV2piNsq63/Dv
         kb2OIbsbSnlb265bnGoo++Dfcsi5PgQVRmhgyssVh1gqob6k+z2Em0OvcyDqfWc1LQZg
         bH7HEcgcmXApKR6mXvUfWgMML01XcButHEWyG4gAQmiGBDAQwBpxnTMAL3ZcxrQ8OKQw
         ULTpr1Gx36IpsROcBZEiUrAdvxb2uzt+P5RLqNWZnK3cda6gat4LiHALfHptR35NMSwR
         fqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lAOnMWwF4qAQcVeNjQH4AwmlxKBfK+M5jR0kCak5yWA=;
        b=Q9wNcBcxf3txL2+9pGeagtizqwyll2A/O0juserijpINg3uguAtSa+dAMSp/BRFSw6
         HFJp9yVKWfCMmO+7CzzjgQfK/8HH79ELqq5b34SFLfViM8QAx9Z/p6KiT4UHIuVfU5cP
         rHBoSBSPxoDx/0gTvbRZK46iHLhe1HSoQ1aYWBN5N0qgQy7cvWzYsrzcaEygVFoTDbeY
         C6NuneXKqtXKurCZ+LZiY1B4eAOXtuQqEnG79OApUrAIHVUiXIuqtz+g1gGUimhXjag8
         fn2SxOqu7Mgsv7VJzM2IrbWXnrrfws110pvirOOMyHIRR/T/ga2oTSCWk99Mb3BkmHB2
         Thfw==
X-Gm-Message-State: ALyK8tLxKTkQELWTVrECtQL7cLbrQ+YPA/3DiqyOn7i4CxxOSGDRbARDIFk5kAbAPr6saw==
X-Received: by 10.66.26.37 with SMTP id i5mr40596602pag.15.1464550010743;
        Sun, 29 May 2016 12:26:50 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:b546:9ef3:e6a7:b5eb? ([2601:645:c200:33:b546:9ef3:e6a7:b5eb])
        by smtp.gmail.com with ESMTPSA id to9sm41987841pab.27.2016.05.29.12.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 May 2016 12:26:50 -0700 (PDT)
Message-ID: <1464550007.5020.39.camel@chimera>
Subject: Re: [PATCH v2] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mips@linux-mips.org, hauke@hauke-m.de, openwrt@kresin.me,
        antonynpavlov@gmail.com
Date:   Sun, 29 May 2016 12:26:47 -0700
In-Reply-To: <9757c228-5835-422f-2b8c-bbced1d15df4@openwrt.org>
References: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
         <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
         <c481d3b1-bee1-89c9-bbb8-ef17d91570bf@openwrt.org>
         <1464547128.5020.32.camel@chimera>
         <16b32a30-b0b4-d69e-b53d-827b9640c0cb@openwrt.org>
         <1464548936.5020.37.camel@chimera>
         <9757c228-5835-422f-2b8c-bbced1d15df4@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53697
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

On Sun, 2016-05-29 at 21:22 +0200, Jonas Gorski wrote:
> That still leaves the question which one should be preferred in case
> both
> are present.

In the already merged code, the appended one is preferred, so I would
favor that.
