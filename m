Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 14:00:26 +0100 (CET)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:51427 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826558Ab2KKNAZ1dFrM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 14:00:25 +0100
Received: by mail-oa0-f49.google.com with SMTP id l10so5222041oag.36
        for <multiple recipients>; Sun, 11 Nov 2012 05:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UBPOtYl5dH0pF6Mxnpz8ei6bn8daNlKm3yFQuWQjM/A=;
        b=SpYlKhBShNjWsrggX19esn3YkyTjYq9PXg69zviaFt8aS47n0dflIF+4lsYbRYO1la
         jIJiLcJgVWs16j9ov6EIBIMn21mUesaifGhctsZyg54lyWZFPsdOAvSydcX+awuGdNXu
         2frylgu8O4mhy1rpjXBRlK5x9RRMXoDhJwZJbIQgl1WDCZbHKPZgNN6AEKUe9R9wJWbt
         S5m3k+47Q+jv+GS0370Cy7qOoPukCwlkw15PYty1jiJj/gIEkOFlAyYx2YoYuXyu/5pt
         Ry05pA/NdwZZmrQUJ3Kh8GRVmElzWW3hqTvcQd1EjTsMH9a+gN1kwDg9gnKLaZNoE33f
         w/Hg==
Received: by 10.60.27.166 with SMTP id u6mr12026781oeg.86.1352638818941; Sun,
 11 Nov 2012 05:00:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.28.70 with HTTP; Sun, 11 Nov 2012 04:59:58 -0800 (PST)
In-Reply-To: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sun, 11 Nov 2012 13:59:58 +0100
Message-ID: <CAOiHx==bS=ZGk7TGrs16zT_UM3zjj1mKhb3NHdOBnhrCaxLoxA@mail.gmail.com>
Subject: Re: [RFC] MIPS: BCM63XX: add initial Device Tree support
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

> [RFC] MIPS: BCM63XX: add initial Device Tree support

Disregard that, I can't git :-(

That obviously should have been 0/15 and so on (even if many patches
work stand alone). To not spam the lists, I'll wait for some comments
before resending the patch series (with proper numbering).

Jonas
