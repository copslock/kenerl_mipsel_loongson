Return-Path: <SRS0=PETI=R5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D40C43381
	for <linux-mips@archiver.kernel.org>; Tue, 26 Mar 2019 15:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A282075E
	for <linux-mips@archiver.kernel.org>; Tue, 26 Mar 2019 15:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q13xFeYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbfCZPVu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:21:50 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:55074 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbfCZPVt (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 26 Mar 2019 11:21:49 -0400
Received: by mail-it1-f169.google.com with SMTP id w18so20152210itj.4;
        Tue, 26 Mar 2019 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ut/KxZ/NxspP3PhpdUgOZaF02FJjx1Uz1wElp+fptX0=;
        b=Q13xFeYPcmy0npkL81YbMLiJyIB2ebTbElq/LvZxagwnuZSNc6AnTACp3x5Q9Lxn8G
         NuMx+AuulOM5aDkWwPBCVelsd7ZQdPuLVQ5xpKWYA0mDcQiUu6YVSdnGsTg+6qtnVW62
         MkUSOPeT6VRljjcF0oS0/2wBcelXIzGyGFNh1jSdilicyzdfduCy45uukhqvqjiLlp+x
         WWmGfdYTCgvfVISqMH5xC3ce04rAQKfnTjabaSOuFIY0QpQAyMyRcOlp6yMEnK3yPCYV
         KZQ/qZMye/wNQzZc2VFppdD2mDsdYpXojvr0PIBixVlLo+ogl9LTmsedF0qMhpx5Q43H
         qS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ut/KxZ/NxspP3PhpdUgOZaF02FJjx1Uz1wElp+fptX0=;
        b=S2U/zyKbL1UtwB13GfUS4944wvH5tc/0gTCkQto2wPjcizIVFrZddN6wVygdm97Hmh
         D9VZGH+pixw8H++xn8YnMMYI06SyGgQP+wVOBTofzDP+KixLMi1Njo0zVBi89bMr5Tls
         RRNs/Ydz1yXyxz7xtElRkBsXZwG3iRnb/zDAVdgHyLyme7rSnPXl54aM+uE02aI2nbOL
         1UZcviMw5AdD6h9Ms1kfT0G9dV4O0ZN+WbjajlRcox1QiySRz404dIPeySYIXWJppQ4v
         /+cQ8d2LaWGpEpVCStGNTH2e428SerRyQoQ1xF3f0EuAn9bQNWEf8ieWKG2hqd90wHEs
         66ng==
X-Gm-Message-State: APjAAAUhQHFO/GnkwxJMAH9w91KSzXy/cyRCrfSvLQMOyXbl5/5Mk7BW
        e/ILZBCNigfJ6LwreQecKco=
X-Google-Smtp-Source: APXvYqxZ9zj+T5ksTOLi+uIEgzH1z6x3LUMgbXokunZoxirMHSOy9VlH9LLgJXX+hpXlYMOEHI8HUg==
X-Received: by 2002:a24:4383:: with SMTP id s125mr665205itb.55.1553613708297;
        Tue, 26 Mar 2019 08:21:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id w14sm6861045iol.32.2019.03.26.08.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:21:47 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] staging: mt7621-mmc: correctness fixes
Date:   Tue, 26 Mar 2019 09:21:37 -0600
Message-Id: <20190326152139.18609-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Coding style fixup and rebase of v3, and resubmit of the Kconfig patch
that got dropped from v2.  No other changes.

Thanks for your continued attention and reviews!

George


