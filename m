Return-Path: <SRS0=KGvN=RH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB98C43381
	for <linux-mips@archiver.kernel.org>; Mon,  4 Mar 2019 10:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4A920823
	for <linux-mips@archiver.kernel.org>; Mon,  4 Mar 2019 10:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9DXlobo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfCDKOl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:14:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40662 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCDKOl (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 4 Mar 2019 05:14:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id q1so4862163wrp.7
        for <linux-mips@vger.kernel.org>; Mon, 04 Mar 2019 02:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lCz/26aFF6OO+kiRt5HTIO2SCb5YEAIxSc38A0iW2J0=;
        b=V9DXloboo7T8EGkeYF9vhAWbY/WPWmJfgqpCpWgAjT03bXEFltuIIHZ2MKyi87G5Yx
         EKLBgbNZb8E2NdCW7UG0+W+GuaM3ELaEPM6eg3SOxcgE0R6ar2EvnjOXdbD1kTBBnBmg
         pgnziCDA6qOuO490UVI/LpDO6ywXoMO6azZ2j/pPy1yIFbkP4PQNqtpoNcoRfvBowqwg
         4ZXrx6Mig1yU+G6xdHzGaAjoqhvv5ITWQ2g+q1irvDCqO8DxOjOi0Evc+6hP7/83vMg2
         qMR0lzgjiwwHLelpCX4XQLt0039xfe42BIWPr6vRkXnbi/MA7RSlv6+rpjOp71xjVSob
         CPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lCz/26aFF6OO+kiRt5HTIO2SCb5YEAIxSc38A0iW2J0=;
        b=p6cPNeZKQEyia0QxYlFcsd6MxEiBfe5VgxTBgT4H162gkYJlohLYfSAuC+i3ArYg7N
         LLKJcccTZHmqVR1wyTsy9aXVg3D7fp7kKHSrD7mmrckf1JskSwY5ACG7jdPxen6IVnB4
         rC+5X7cAN1w2YIB0rdqGNQCXM1F9wVmzdjoqkqgg+T1q2+8BWhMMUFkeVgdx6zRwrnhU
         kjclN0tus9gf0VzllbGvWAsp/kh7O6jcNPApdV2xtAR+su2gDxPNl+nGqmM8F+8HtpJQ
         OAEOOJlO83YJ9yEfaE7Fx78dCsV9CBK1TdI9+UIIV8BZDSEvFIWZr8HB5dp9WCtHvbQf
         rMJA==
X-Gm-Message-State: APjAAAXn2UKiZzH+jOGfL6Xh/VGkITBoK0cnIik/IEnSiOSf8+MfpPjY
        Z16s0zGNAnHhd3Tq2MetDdTRfw==
X-Google-Smtp-Source: APXvYqwAusav88CSspaLqJeLBhmrxfAmN0jn80zA1Ci4IpA4OG1yJm88oHciSP20ByV3ngFs4a83Og==
X-Received: by 2002:adf:e98c:: with SMTP id h12mr12701245wrm.302.1551694479568;
        Mon, 04 Mar 2019 02:14:39 -0800 (PST)
Received: from dell ([2.27.35.194])
        by smtp.gmail.com with ESMTPSA id 62sm5818472wra.46.2019.03.04.02.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 02:14:38 -0800 (PST)
Date:   Mon, 4 Mar 2019 10:14:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Yifeng Li <tomli@tomli.me>, kbuild-all@01.org,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mfd: yeeloong_kb3310b: support KB3310B EC for Lemote
 Yeeloong laptops.
Message-ID: <20190304101437.GN4118@dell>
References: <20190302175334.5103-2-tomli@tomli.me>
 <201903040851.4ZDLoz8h%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201903040851.4ZDLoz8h%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, 04 Mar 2019, kbuild test robot wrote:

> Hi Yifeng,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.0-rc8]
> [cannot apply to next-20190301]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Yifeng-Li/Preliminary-Platform-Driver-Support-for-Lemote-Yeeloong-Laptops/20190304-005203
> config: powerpc-allyesconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.2.0 make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):

This patch isn't in my Inbox.

Who was it sent to?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
