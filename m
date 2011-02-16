Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Feb 2011 11:27:05 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:37566 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491000Ab1BPK1C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Feb 2011 11:27:02 +0100
Received: by qwj9 with SMTP id 9so1088913qwj.36
        for <multiple recipients>; Wed, 16 Feb 2011 02:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zEdiJweVd+rTvAK4pRLeM8dTfaoxhDkmNctL+0ZcT84=;
        b=bHHB5HpzS3oT6gBOyQvgNYTqOLqOICSt20/ksmLKSq4nglu3EUT5RfTKih7SiDk+bA
         nfjjEBwbK/j8pWPgj2oq3HcTkJ3mM1dFBjcAPeGgDEUFpS1W/lP9oUBXama+WOO/h6Qp
         6nur7142pHK6miyYOe5vO62wM+Y/sGCaax7KA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ERHXk3ntjzsqpCGXeRBfHjPQv6Pimn04m7adKzkPbhaOUi0M0r9vdS7qNhPkWI/u8M
         j4wY6pLaldgA6f++hEaOA31LDCpxeqAfP/yfTv1F+RseK/mf0IhgIBJToKjTDtIdBtXg
         Ty60QP7BfyUPpx4BnM09LRoCBA0LxNwCVpSUM=
MIME-Version: 1.0
Received: by 10.229.212.133 with SMTP id gs5mr464563qcb.192.1297852015851;
 Wed, 16 Feb 2011 02:26:55 -0800 (PST)
Received: by 10.229.36.193 with HTTP; Wed, 16 Feb 2011 02:26:55 -0800 (PST)
In-Reply-To: <20110216011203.GA5773@linux-mips.org>
References: <20110215220929.1cc6e9d4.nledovskikh@gmail.com>
        <4D5AD6A6.8090505@gmail.com>
        <AANLkTiks9rG2CzM2LabNerK3zgJ+R+weytQgvXxDbNe7@mail.gmail.com>
        <4D5AE52B.80002@gmail.com>
        <AANLkTinnCOEXF835yhNeJDfBdKjx_dss6TFeUmjL-Yk2@mail.gmail.com>
        <4D5AFB3B.6080407@gmail.com>
        <4D5AFBCB.1090907@gmail.com>
        <20110216011203.GA5773@linux-mips.org>
Date:   Wed, 16 Feb 2011 10:26:55 +0000
Message-ID: <AANLkTimP1r1A6nzcfh7kP=Hmcq9Cgha5Du28hE3zOs0x@mail.gmail.com>
Subject: Re: [PATCH] ath5k: Use mips generic dma-mapping functions to avoid
 seqfault on AHB chips
From:   Nikolay Ledovskikh <nledovskikh@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jiri Slaby <jirislaby@gmail.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, lrodriguez@atheros.com,
        mickflemm@gmail.com, me@bobcopeland.com, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <nledovskikh@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nledovskikh@gmail.com
Precedence: bulk
X-list: linux-mips

So, the problems are in openwrt platform patches that should be rewriten:
1. Changes needed to avoid using code like "mem=res->start" without ioremap.
2. Changes needed to avoid using NULL in first argument of
dma_alloc_coherent and others.

Without these changes ahb patch won't get into the kernel and we'll be
lack of wisoc devices support?
Is there any chance for the patch to get into the kernel and what
should be done for it?

(PS: Sorry for my english.)
