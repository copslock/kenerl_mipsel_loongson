Return-Path: <SRS0=KjQ3=WY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE05C3A5A1
	for <linux-mips@archiver.kernel.org>; Wed, 28 Aug 2019 23:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7AD2339E
	for <linux-mips@archiver.kernel.org>; Wed, 28 Aug 2019 23:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qb/E47jX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfH1XEx (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 28 Aug 2019 19:04:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35361 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfH1XEw (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 28 Aug 2019 19:04:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id t50so1850644edd.2
        for <linux-mips@vger.kernel.org>; Wed, 28 Aug 2019 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Q7JSnutSKY6xFT4D0TS+NhWVJ0m3aop0mXkuXZwQ1WQ=;
        b=qb/E47jXOQPuSvEFEgQZ7e41y//cnPauFgA7N4iBWYIFh6wHQFWfYFLNNfbQ4A+sb/
         /qnFd2EB8mWvqw4vz7E//rOpCQ3J8x7zvsV/DMFXEWxYoTU6ItNXRO0108vKV2kENDnm
         PpjkDlT2YtJbRTDKhSvJ3U0DqYWwfduFnp0wGBXxvtBMR3xuUQOEiJzP2XVES6qL+WVh
         ktXbUmgNkTA+t/6QApnEGFEQQq+PkfIKy5urWRJqmlEO+36R3IehsZ3pJ5Mq35rAFzFr
         vEgFYvHXzZhVXhP/w6b/yicN1Sju0q+zvBG02tORCEgOso/0Ijm9TXar209tRNN25BIs
         IZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Q7JSnutSKY6xFT4D0TS+NhWVJ0m3aop0mXkuXZwQ1WQ=;
        b=KJXy0cwnvBKU0S1y6vr7mW6GijT7uuouGd7ib8IuYQjak6RIJxSIlaToZDMS20nvj1
         alatHssXTk4sesrT6GJItaRMbRU/rbzk4uI5sJLPBDipEv5yYEMoGzfdkJNy4pZ2SeZf
         PwH7S3DGU3YfVGna5Gge/TLKicoI24OTNPH/2GLIemB+Btg7v3Rh3XTt5CHe1OVpwxEY
         +rZRNwb/BReEkZt1Wt85vNnHYRVp9dLHxOf4gEtTJIYAFYK4KUixt+7iHqL4ntKy3AiD
         PdR929uPHNV7cyjQO17DeOTdoMp43AbNZpTAk7lXcXlk/NOLu7fHEfckMVItvh/Hb12f
         ETSQ==
X-Gm-Message-State: APjAAAVQCq1jiZ0HJwx24c5UE+ro42hUNoJ92fsJA+LvEjeVzsuFFauy
        CEDnAOnBMjDa04FslQbaZmxucw==
X-Google-Smtp-Source: APXvYqzv+JrKNf2JDsSOceh0HfkjOXGNKBtr248ZuV0rxGOLR7awEnFCsvsCnef6NT1LwX6c05Rjjg==
X-Received: by 2002:a17:906:5391:: with SMTP id g17mr5530333ejo.61.1567033491155;
        Wed, 28 Aug 2019 16:04:51 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id d10sm102967ejd.86.2019.08.28.16.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 16:04:50 -0700 (PDT)
Date:   Wed, 28 Aug 2019 16:04:29 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next 09/15] net: sgi: ioc3-eth: split ring
 cleaning/freeing and allocation
Message-ID: <20190828160429.6f9abb4e@cakuba.netronome.com>
In-Reply-To: <20190828140315.17048-10-tbogendoerfer@suse.de>
References: <20190828140315.17048-1-tbogendoerfer@suse.de>
        <20190828140315.17048-10-tbogendoerfer@suse.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, 28 Aug 2019 16:03:08 +0200, Thomas Bogendoerfer wrote:
> Do tx ring cleaning and freeing of rx buffers, when chip is shutdown and
> allocate buffers before bringing chip up.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Ah, so you are moving the alloc/free to open/close, that's good.
