Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2010 20:05:00 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:64621 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491039Ab0L2TE4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Dec 2010 20:04:56 +0100
Received: by iyj21 with SMTP id 21so10063166iyj.36
        for <multiple recipients>; Wed, 29 Dec 2010 11:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=sdS+9Tb9CMMuLaCtjOmvUpvAUZSSusEs21gxhy1ATfE=;
        b=QcdPA0TxTc5vyIY4w3Akz/nEoquYMFqhQkMwegghDNdsQc45ZE0WrfooXfUfX0+YaY
         ewX2HOH6wg0CzsSDJYps63acNIkxaIEv0IvNKy8HlSfj8bztfhM87z9p6QKJOP7X3wyw
         dHx8debBb9/7IP1dY7K61AbBrFXImsoHynsyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=sKlKcjqsM4+bSNtl9BkYbZ9ESmAAPOlUmKBXXvxbWPnSZ3zgDSYqMsPjwsVpa7TkBo
         yHyiObS1/Qgdw9xv4rtmWYtMNFYqpOXnUe5c65v3uxPtMWB+JyC5FDqeRKAgetUYGZWA
         urD2pSLXNRCJIdXuGc6JqhsNP4dHZSSqXf4Ak=
MIME-Version: 1.0
Received: by 10.231.10.141 with SMTP id p13mr14941968ibp.131.1293649489472;
 Wed, 29 Dec 2010 11:04:49 -0800 (PST)
Received: by 10.231.161.84 with HTTP; Wed, 29 Dec 2010 11:04:49 -0800 (PST)
Date:   Wed, 29 Dec 2010 11:04:49 -0800
Message-ID: <AANLkTimKSauYdv-cfSmc3cxQo3-YE4sOpLQ7sepwJf==@mail.gmail.com>
Subject: [PATCH RESEND] MIPS: Add local_flush_tlb_all_mm to clear all mm
 contexts on calling cpu
From:   Maksim Rayskiy <maksim.rayskiy@gmail.com>
To:     linux-mips <linux-mips@linux-mips.org>,
        "Kevin D. Kissell" <kevink@paralogos.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <maksim.rayskiy@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksim.rayskiy@gmail.com
Precedence: bulk
X-list: linux-mips

