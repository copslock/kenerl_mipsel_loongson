Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Mar 2011 04:02:59 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:56342 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491923Ab1C0CCz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Mar 2011 04:02:55 +0200
Received: by iyb39 with SMTP id 39so2097116iyb.36
        for <linux-mips@linux-mips.org>; Sat, 26 Mar 2011 19:02:40 -0700 (PDT)
Received: by 10.42.135.193 with SMTP id q1mr4374006ict.41.1301191359258; Sat,
 26 Mar 2011 19:02:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.15.76 with HTTP; Sat, 26 Mar 2011 19:02:19 -0700 (PDT)
X-Originating-IP: [217.65.98.56]
From:   Gergely Kis <gergely@homejinni.com>
Date:   Sun, 27 Mar 2011 04:02:19 +0200
Message-ID: <AANLkTinDFQFLiHZoKw2kPpVov80xc08FFxLjYsORKyKd@mail.gmail.com>
Subject: Oprofile callgraph support on the MIPS architecture
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <gergely@homejinni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gergely@homejinni.com
Precedence: bulk
X-list: linux-mips

Dear List Members,

We would like to announce the initial version of oprofile callgraph
support on the MIPS architecture.

Our implementation requires no user space changes to oprofile, only a
few kernel patches need to be applied. In this first version we
provide kernel patches for the 2.6.32 version, but we intend to update
the patches to the latest kernel version to submit the patches into
the mainline kernel. We also intend to provide a version for the
Honeycomb (3.0) Android kernels.

The current version was mostly tested with MIPS Android, running the
Froyo release (2.2). We tested the implementation on Sigma Designs
8654 and ViXS XCode 4210 platforms, running in little endian mode.

One interesting property of our callgraph implementation is that it
does not require the presence of frame pointers. This way there is no
need to recompile production binaries or kernels with frame pointers
enabled. One may simply compile oprofile as a module, and enable it on
demand, even on production builds.

We also added a way to restrict the callgraph generation to kernel
space / user space, if desired. This way the overhead of callgraph
generation may be reduced.

The home page also provides a few sample callgraphs created using
kcachegrind from the oprofile data.

You may download the code and access the documentation on the following URL:
http://oss.homejinni.com/redmine/projects/mips-oprofile

Best Regards,
Gergely
