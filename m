Return-Path: <SRS0=TQVq=ON=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6B1C04EB9
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 00:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46542082D
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 00:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="R2tlUdeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46542082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbeLDAXV (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:23:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40551 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeLDAXU (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 3 Dec 2018 19:23:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so8571373qki.7
        for <linux-mips@vger.kernel.org>; Mon, 03 Dec 2018 16:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=E0QkDkvm+wq48hcMoh0su/XUdfxjFwi3Pwu8Jr24hR0=;
        b=R2tlUdeERnwA5Yi+md8vWioIUyhE782mGQTfWmZMXGRzvTBTuKa3MFjk8FsJKqgrDv
         OXK95MkSXUysyB6w1s7049RxFrDswdrXxbRcLyCm6ZlEg3h1MYQxo8S1obL79JEZ88PF
         OybogmTZ6dWiE1cNetmXJsm0e3ts8xGhAcLSFgef4s91VqwhpMlmjmuuRbUcaEQBpA0h
         7ZrGAqcyRCfeDoXUv644kOCGI1fheTYu4umnpz4U29ZLVL6+ah84hHUNVN2JrhaV5Q0w
         TMfE5Rf9jxzm1fdSFV72iFuTWsgnTGlCZZK0nigQPIRxo6g5yx8fNLmDedXWGkoegYxX
         tFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=E0QkDkvm+wq48hcMoh0su/XUdfxjFwi3Pwu8Jr24hR0=;
        b=YLFiFpvJHkF4/Kmaws6mc8hsP/hDuMmQQV6+ZdMkXqrd41IeG5G43HMNjZnFQDrj+1
         3jpFw5Q9M4O47g9cueAUv/OSqmZwfUFMyqLg0M9T6veQXH8EEMSIMyW8GDChad0+xLsz
         MPOEe4uZ3kRPCHSdinv4E/Q9wYYDuCg4FvPUSD1/37yARTPUD6RZLcKLEhSIrGWOqDSK
         nC+U1lINT6GorjOfTxDn6SrJB5d3QYGYiiO9FecKR/QhgxerBrvS42GoM2wAlmBNQtts
         Fzn78bLJfuqqGLpz06//thRLtl/tOm3tAVFo+ig8U9KoxrtHow4cNUkWMSaF+JzExIg4
         WC5A==
X-Gm-Message-State: AA+aEWZVXucI+ifaXpVrMZHbNJqhzwI7zRsbrgUuzV0rIZVzxbS1lAEc
        +dwXv8jT0ROu0MF6rBiIJerjfQ==
X-Google-Smtp-Source: AFSGD/VZn13SWMH5S3/j5MM88vpA8NfWJLpod+USWjQ8m7BmKPDaaZV8P34oE2EE2TGqNIC94AkxCQ==
X-Received: by 2002:a37:e406:: with SMTP id y6mr16634099qkf.216.1543882998797;
        Mon, 03 Dec 2018 16:23:18 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id w185sm7927461qka.88.2018.12.03.16.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 16:23:18 -0800 (PST)
Date:   Mon, 3 Dec 2018 16:23:15 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        Jiong Wang <jiong.wang@netronome.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 bpf] mips: bpf: fix encoding bug for mm_srlv32_op
Message-ID: <20181203162315.548ad882@cakuba.netronome.com>
In-Reply-To: <20181204000623.6tmqntmxi2dydrlz@pburton-laptop>
References: <1543876074-4372-1-git-send-email-jiong.wang@netronome.com>
        <MWHPR2201MB1277C127DA9E9CABBC6F96BEC1AE0@MWHPR2201MB1277.namprd22.prod.outlook.com>
        <20181203155545.6eb5520a@cakuba.netronome.com>
        <20181204000623.6tmqntmxi2dydrlz@pburton-laptop>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, 4 Dec 2018 00:06:24 +0000, Paul Burton wrote:
> If you have related patches the best thing to do would be to submit them
> together as a series. Then after the maintainers involved can see the
> patches we can figure out the best way to apply them.

Right, in hindsight that could've worked better, but for netdev/bpf
patches posting fixes and features in one series is a no-no :)

I guess the best way forward would be for Jiong to post the dependent
set (BPF_ALU | BPF_ARSH support) as an RFC and then decide.  The
conflict will be trivial, yet avoidable if we wait for this to
propagate to bpf-next.
