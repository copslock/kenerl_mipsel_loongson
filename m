Return-Path: <SRS0=6l1E=OM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDC8C04EB9
	for <linux-mips@archiver.kernel.org>; Mon,  3 Dec 2018 23:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF0D2073D
	for <linux-mips@archiver.kernel.org>; Mon,  3 Dec 2018 23:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="KNi9zgE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF0D2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbeLCXzu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:55:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46603 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCXzu (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 3 Dec 2018 18:55:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id y20so16013344qtm.13
        for <linux-mips@vger.kernel.org>; Mon, 03 Dec 2018 15:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FI09+sngpXMj7quYXCmc3LVwfpHFIBd9RO5BLY9DHOg=;
        b=KNi9zgE903r0qaKw4y0NqQRJ/3iSswS9Zs9aHeovO09HFweL3B1T1i4EfQA/ds67v3
         1ZfdcWanGzG3ajAvH+iWUxHxXSbE/iS1Mv0W6PyrIdjzWRL3zeGCwQB2RD5/n9jyQdnW
         uhSq0MeADVf+h7/9ey6rA/ZFgIzxixF+9pHQOHhqvoJOpOHnKjJaXdjshtjn6no2Mpv6
         EYxvKuNFIwaYGDHKckJVH6dTZskQAw/oTBxd4ZCp2x+8T/UPhz1TI4sNoNp6E32vv1Mv
         xuk28nu2HIioF0ntnWLc4CxRysPOzneEgBab2TkXzYiHlsBOpJuSHKccAMPGlgF2G6nF
         Zylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FI09+sngpXMj7quYXCmc3LVwfpHFIBd9RO5BLY9DHOg=;
        b=Qsm302i8ko5GDhRZMmiIU1yQgglETLWby939YW2Wxj+zqoocIvO/bCUTiJ05Bv6fK5
         M6UWEI1zLphZE2D6IZJDYScah5GcWJAf6feEL+a3zSpW+rnQzuNl07hKr2vL280HNUq+
         A8zQap8Vq+2YwAjnMRAAGD17R+4AhKtR4EVrqCz523VF/TMt9eskVFSF7X4Wl+S4mMA5
         q/5z06CvwdP0+KlsxSksuzXPOBmKJ6tReY1Pz5CpUyl4TYQnujbG6DdKQFHfxACZjFzk
         NPVJOatzMPqUx3NQoMFGqFcFEZ65/ZDPXR8D+06i2dtD5KCCGyG8lAhOUbddhVFXXVGD
         3J8w==
X-Gm-Message-State: AA+aEWazGFDYrvoRpND++VkV0cFK8PAeGgN2NWgj+3XPjXPHrnKmrfdD
        r3AOUYW2Hfthd0CTSqK8fCrKqw==
X-Google-Smtp-Source: AFSGD/UxCD7SmAPZUy4XEf+THMaVviqfWQq4fHOroe3JK5fN6n16V/tjCNk8XKP/d6c6l4E4H5a6BA==
X-Received: by 2002:ac8:76c3:: with SMTP id q3mr17406745qtr.48.1543881349217;
        Mon, 03 Dec 2018 15:55:49 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m1sm12621214qkh.15.2018.12.03.15.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:55:49 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:55:45 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Paul Burton <paul.burton@mips.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 bpf] mips: bpf: fix encoding bug for mm_srlv32_op
Message-ID: <20181203155545.6eb5520a@cakuba.netronome.com>
In-Reply-To: <MWHPR2201MB1277C127DA9E9CABBC6F96BEC1AE0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1543876074-4372-1-git-send-email-jiong.wang@netronome.com>
        <MWHPR2201MB1277C127DA9E9CABBC6F96BEC1AE0@MWHPR2201MB1277.namprd22.prod.outlook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, 3 Dec 2018 22:42:04 +0000, Paul Burton wrote:
> Jiong Wang wrote:
> > For micro-mips, srlv inside POOL32A encoding space should use 0x50
> > sub-opcode, NOT 0x90.
> > 
> > Some early version ISA doc describes the encoding as 0x90 for both srlv and
> > srav, this looks to me was a typo. I checked Binutils libopcode
> > implementation which is using 0x50 for srlv and 0x90 for srav.
> > 
> > v1->v2:
> > - Keep mm_srlv32_op sorted by value.
> > 
> > Fixes: f31318fdf324 ("MIPS: uasm: Add srlv uasm instruction")
> > Cc: Markos Chandras <markos.chandras@imgtec.com>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: linux-mips@vger.kernel.org
> > Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Acked-by: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Jiong Wang <jiong.wang@netronome.com>  
> 
> Applied to mips-fixes.

Newbie process related question - are the arch JIT patches routed via
arch trees or bpf-next?  Jiong has more (slightly conflicting) JIT
patches to send - I wonder how they'll get applied and whether to wait
for the mips -> Linus -> net -> bpf merge chain.
