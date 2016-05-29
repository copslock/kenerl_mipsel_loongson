Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 May 2016 20:39:01 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34231 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033624AbcE2SjAAcHnR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 May 2016 20:39:00 +0200
Received: by mail-pa0-f65.google.com with SMTP id x1so2633625pav.1
        for <linux-mips@linux-mips.org>; Sun, 29 May 2016 11:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agoAcopy9CohOT0cha7RemVsa5qOHj1Rpxxsmocz2m4=;
        b=uWnGWLfZwuSTYwfVZevBEORf1v+h91plJwSxIIRVjpmE1a/+C18TZdZAapKsWBbjYy
         2ulRmyZ10Ndej8976r8kyeHOjL7EmRfHf1oUgODOk/zqLpg2JDOnioyFNfzVe6lUzl7o
         aB83aRMqF2TMDzAikH5nBibaZUdzleXlrekYicqW70atC5MyWp9ru70cwZL+a2HE1/tq
         3raD5sqN1Vkq70ui73zorsOdvZCZPR5KgWFnQbOBNDgdCeIIFUHaAS0UoySNPsI51SSv
         QRAmuQUzLrtrUCiD6Yj+rvzyWEcAN8rGvEbRM1ocPLCpQkzw5/z1iGf3Kp8YiWoRccgB
         c+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agoAcopy9CohOT0cha7RemVsa5qOHj1Rpxxsmocz2m4=;
        b=PN3a9cAd2Ht6ALiNCCSPRMOEdnFWbva+10ucJ6ECjOsp909AYmr5EypcvfEamf7wju
         9dmOi2Lx2kJMmN7+wCbl40+2fEJOAQMKuijWJESgxANOXNRjrQ+OlF6mN6uBSq7frXZo
         DwYQ519Q0iRlWDztYIG3kRqH45E4qDFnM2DpsqOo0EMcaU3Je04i/ELk57XCqdXckVDX
         x3p1oVxVM+P1kl3VXwyW5o6ybNY1pUPNTfLFA6IKt/Xo8MnH6pdZdhUPpbYj97Pncv1f
         t+gGnDhc3EE7wKQEUP1Gmk3OBYtnXcftN7tboyVWKX6Ib5slQvkC2S2vd8LA2sA3J+JY
         UsAQ==
X-Gm-Message-State: ALyK8tJSC9xI499UdO3gdnrxMKKg3xLjJMm/DS3XU7ubiPmzsJGgoSIQhNnmsHJk/c5QcQ==
X-Received: by 10.66.90.196 with SMTP id by4mr40087577pab.117.1464547133874;
        Sun, 29 May 2016 11:38:53 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:b546:9ef3:e6a7:b5eb? ([2601:645:c200:33:b546:9ef3:e6a7:b5eb])
        by smtp.gmail.com with ESMTPSA id dh4sm41857733pad.37.2016.05.29.11.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 May 2016 11:38:53 -0700 (PDT)
Message-ID: <1464547128.5020.32.camel@chimera>
Subject: Re: [PATCH v2] Re: Adding support for device tree and command line
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mips@linux-mips.org, hauke@hauke-m.de, openwrt@kresin.me,
        antonynpavlov@gmail.com
Date:   Sun, 29 May 2016 11:38:48 -0700
In-Reply-To: <c481d3b1-bee1-89c9-bbb8-ef17d91570bf@openwrt.org>
References: <20160524194818.9e8399a56669134de4baee1e@gmail.com>
         <1464383198-6316-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
         <c481d3b1-bee1-89c9-bbb8-ef17d91570bf@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53693
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

On Sun, 2016-05-29 at 12:53 +0200, Jonas Gorski wrote:
> This will break/won't compile for ZBOOT_APPENDED_DTB as __appended_dtb
> is
> part of the wrapping decompressor, and the kernel has no knowledge of
> this
> this symbol.

If this were true, it wouldn't compile with the code you added to
compressed/head.S, either. You're referencing it as an external symbol,
which is exactly the same thing I'm doing here. Your proposed
alternatives are functionally almost equivalent to your earlier rejected
patches:
https://patchwork.linux-mips.org/patch/7274/
https://patchwork.linux-mips.org/patch/7313/
