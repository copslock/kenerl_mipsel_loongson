Return-Path: <SRS0=ZcmI=YZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B5CA9ECF
	for <linux-mips@archiver.kernel.org>; Fri,  1 Nov 2019 23:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708B221897
	for <linux-mips@archiver.kernel.org>; Fri,  1 Nov 2019 23:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572650877;
	bh=UrABuFjHpV0UNTIkTU02ofs6wUHFw5pLOL8tbuuOp4o=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=Y0Ao4NvzXX1FOFGMbkDuutEEf6iHx0545ycTmyaLoSCUoIQ3sFLJrsudoJ0rGKxpj
	 5VXAqg/RMrIu206ZSOn9Ke3ctizAXjMf5aa/q87O9SJTqfbDctPrw8G1tQWoPKnpLD
	 SBinUHihpFAY0QUsol9RAMJSibJvA09T3T31pdoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfKAX15 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Nov 2019 19:27:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33621 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKAX14 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 1 Nov 2019 19:27:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id c184so8056192pfb.0
        for <linux-mips@vger.kernel.org>; Fri, 01 Nov 2019 16:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=iV3ujg0jL8w3DL1Ebd85AybMgp6/+r6kGZKYeAJn2hE=;
        b=PRFGaYbRtet14KsG7auy8FmwvUPO2Oe524L9E7QwhBWV0GT7EMYouRcKXwBE9mYIbv
         u7hPEf+U1QwGspLkBzcp0gpDaozLtO8kTNf7pwgTMWmApfgrKROdmvWEviVmDhqXuVZX
         ePa5VW9iHIB/g6mKOv1W8dTjRn3vCy6eASKrjPu12KcZuGYOjS0cQaarFgyQ4cgkkxW1
         0ENUMYzCaX776DOqDbw6VPaSqD3XRTwTXh8BK981PdnCWtcj9hcRJ3BnK7L+TbPlBpti
         eWUUbURDa3UbsDqr3xn1VOlCPAf0L2ZRLVK21dGq1Hbt5Wm2GXkZUuyrYUMBhRtfR4/c
         0o+g==
X-Gm-Message-State: APjAAAUN+VjoW14MF8ty4Ewie87CwQue/MxvlvSJT6BgrTVFyUbLIz6B
        35mwWQwt2a+yynaQUJFNpABVsutlLEoPxg==
X-Google-Smtp-Source: APXvYqzJ5qUwiRrjAR7kPN4X4jDdL7eq3EK6QtgwDcEcVCAJ14zbNwunKgV92kFcvrja0CXVA/ugew==
X-Received: by 2002:a63:5b1d:: with SMTP id p29mr15982643pgb.209.1572650876009;
        Fri, 01 Nov 2019 16:27:56 -0700 (PDT)
Received: from localhost ([2601:646:8a00:9810:9d6:9cca:ff8c:efe0])
        by smtp.gmail.com with ESMTPSA id v10sm7032121pfg.11.2019.11.01.16.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 16:27:55 -0700 (PDT)
Message-ID: <5dbcbf7b.1c69fb81.fd4c5.6083@mx.google.com>
Date:   Fri, 01 Nov 2019 16:27:55 -0700
From:   Paul Burton <paulburton@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     linux-mips@vger.kernel.org
CC:     chenhc@lemote.com, paul.burton@mips.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH 2/6] MIPS: Fork loongson2ef from loongson64
References:  <20191020144318.18341-3-jiaxun.yang@flygoat.com>
In-Reply-To:  <20191020144318.18341-3-jiaxun.yang@flygoat.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Jiaxun Yang wrote:
> As later model of GSx64 family processors including 2-series-soc have
> similar design with initial loongson3a while loongson2e/f seems less
> identical, we separate loongson2e/f support code out of mach-loongson64
> to make our life easier.
> 
> This patch contains mostly file moving works.

Applied to mips-next.

> commit 71e2f4dd5a65
> https://git.kernel.org/mips/c/71e2f4dd5a65
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> [paulburton@kernel.org: Squash in the MAINTAINERS updates]
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
