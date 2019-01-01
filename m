Return-Path: <SRS0=KPy8=PJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FBEC43444
	for <linux-mips@archiver.kernel.org>; Tue,  1 Jan 2019 08:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBED205C9
	for <linux-mips@archiver.kernel.org>; Tue,  1 Jan 2019 08:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfAAImO (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 1 Jan 2019 03:42:14 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:38318 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfAAImO (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 1 Jan 2019 03:42:14 -0500
Received: by mail-pl1-f169.google.com with SMTP id e5so13355008plb.5
        for <linux-mips@vger.kernel.org>; Tue, 01 Jan 2019 00:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=asvUQC84oHaFI4Bp9smDR4uYEYFGRN7p42xmuJ8fOo8=;
        b=YwBQjjy9TFLmHjG5Krwl6h3CEC/DsW22WqgFbTt4+jTOZVKP/2YfbPHkhr54GpU+CB
         53hrKnx5foL4a4mMcAQTIc9o/J/le43giWjbaZ4cXFuujsv2WlV67ucP6gQMVNyrVrEZ
         N6dK4UtO5EJ5aZ3JQKOpspxdY5Vdss/d/Xd+RUTeGBTBaJXKU+XqHXOUhzbc3s8vwWuU
         j6cz7GsBIic0yHsbrum0WTJGtakW3wE53rxXzhtr1mELAKk+4CKSGzp990VlfXTT2g1x
         L5NKCcXMNCJWNn9pcyMU15aXM0xDDDaRiLGQ4ULI0EFfPEyl8bTeJBXvTm4paBSLlfhq
         e9fw==
X-Gm-Message-State: AJcUukd5rHwQxxwvNVj27AicjYq3+WyTQebnA716BhPt47oynXDcOkUN
        YYWBSMvBnX1+7c4c8KsVWSPBEkL8xO94JfinUNE8T+ax6D8=
X-Google-Smtp-Source: ALg8bN57iEgH+Ni5u3MuZyqSKwGEAfhOGrxHgmlFblUwkd0E9mOWLdsKMjzwTbqm/EQZfOydH5yKtYGjD71KDzRgx/E=
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr38991990plt.98.1546332133786;
 Tue, 01 Jan 2019 00:42:13 -0800 (PST)
MIME-Version: 1.0
From:   YunQiang Su <syq@debian.org>
Date:   Tue, 1 Jan 2019 16:42:03 +0800
Message-ID: <CAKcpw6X_Q0iighiBXYvikNT8UDXME1F2wkEjzWHHDGK2_RNuGw@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBUG=5D_Data_Bus_Erorr_on_Ubiquiti_Networks_=2D_EdgeRout?=
        =?UTF-8?Q?er=E2=84=A2_Infinity?=
To:     steven.hill@cavium.com, david.daney@cavium.com
Cc:     linux-mips <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

I met a kernel problem for both 4.9 and 4.19 kernel

This error happens in pci/pcie-octeon.c, in function
   __cvmx_pcie_rc_initialize_gen2

ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST);

When disabble CONFIG_PCI, it won't meet this problem.
