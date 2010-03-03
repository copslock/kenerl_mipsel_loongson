Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 17:34:34 +0100 (CET)
Received: from mail-gx0-f224.google.com ([209.85.217.224]:41758 "EHLO
        mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492180Ab0CCQeb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 17:34:31 +0100
Received: by gxk24 with SMTP id 24so635484gxk.7
        for <multiple recipients>; Wed, 03 Mar 2010 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=s3ViADiP22IoAQyguDqntN640mhHos1Ss0CiUswtWeA=;
        b=UqGIDDc3p6pQwaOKXwY7pRBt1wxkNAqEKjkxdTua92xUxg61mB4cjH8xB1hI2E2VRj
         M/DsqpijUB+aPUQnk9mzE0GaMyvPxYGFleTgY7/85Orga++zelQMZ61ehL9WSKN2F7Aq
         WYDsaLSDxeN41gzzNp8GmkSlf5bzB1X/19aAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ga+qZNo/L2nTT8uk3nRdan/k7+8ONNtZ0l3RfeMEtVNyDIp1o/Irt/zjK+/oiIExIQ
         xQVS412HRKWOV1zc1ozoXNhP44jAC+gfze8dqCYNIOt8j16CleldGVGTIDZao0hNN0CI
         f963NWisN53bCwHR389VtYNjEGLYIwdki2Juw=
MIME-Version: 1.0
Received: by 10.90.38.27 with SMTP id l27mr4992343agl.6.1267634063016; Wed, 03 
        Mar 2010 08:34:23 -0800 (PST)
In-Reply-To: <20100303110527.11233.20400.stgit@muvarov>
References: <20100303110527.11233.20400.stgit@muvarov>
Date:   Thu, 4 Mar 2010 00:34:22 +0800
Message-ID: <e997b7421003030834r7bec3295s7917bb91a3fa2d27@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS kexec,kdump support
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Maxim Uvarov <muvarov@gmail.com>
Cc:     linux-mips@linux-mips.org, kexec@lists.infradead.org,
        horms@verge.net.au, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

2010/3/3 Maxim Uvarov <muvarov@gmail.com>:
> Hello folks,
>
> Please find here MIPS crash and kdump patches.
> This is patch set of 3 patches:
> 1. generic MIPS changes (kernel);
> 2. MIPS Cavium Octeon board kexec/kdump code (kernel);
> 3. Kexec user space MIPS changes.
>
> Patches were tested on the latest linux-mips@ git kernel and the latest
> kexec-tools git on Cavium Octeon 50xx board.
>
> I also made the same code working on RMI XLR/XLS boards for both
> mips32 and mips64 kernels.
>
> Best regards,
> Maxim Uvarov.
>

> Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
>
>
>

Hi, Maxim

In XLR series ,

1)How to protect  boardinfo and pass it to second kernel ?

2)If all cpus jumped to same entry point , did you change head.s  ,if so , how ?



Thank you!
