Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2014 12:13:29 +0200 (CEST)
Received: from mail-we0-f175.google.com ([74.125.82.175]:35201 "EHLO
        mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816676AbaDBKN0qtOaB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2014 12:13:26 +0200
Received: by mail-we0-f175.google.com with SMTP id q58so7451827wes.6
        for <multiple recipients>; Wed, 02 Apr 2014 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=v8zv2drUdFdGWLUStoRnU3CvFy0wXIXrXJNGdi0mszg=;
        b=nfY80Ebd6+Wo6fWY3Nc48apznWsL6JCg7RLYz2N9JhEeprA79UPKDeAoBVSAettFsF
         fu6SD3E1BhqrwvCfG0jhGA7As68zBIHGWmtMTD8pChw9O0Aq/CUOAB8J5i4F7BwGBgKh
         8bmfog6G85YnxoPK8GnsQ+SNp8VQsq3K4sVKVmSp2BQ5CIQEBG+ziRuzSFdFtPf8PJ7M
         o3qFkw0cL/iv33B6YvYF68bzuJuv/ylb/dbH1mo7eIIugOLwcrsfL2Y6VgXLLOsH761j
         LOEeh7fvJuviBKR1lDNitRhZxA6NaGC19wKEYVyn7r+e26vgZ0Tpl9ZX8VgH6nGbNB01
         3C/g==
X-Received: by 10.194.92.228 with SMTP id cp4mr11999714wjb.81.1396433601311;
        Wed, 02 Apr 2014 03:13:21 -0700 (PDT)
Received: from localhost.localdomain (p57A34F13.dip0.t-ipconnect.de. [87.163.79.19])
        by mx.google.com with ESMTPSA id w1sm3463877eel.16.2014.04.02.03.13.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Apr 2014 03:13:20 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     linux-audit@redhat.com, Steve Grubb <sgrubb@redhat.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Eric Paris <eparis@redhat.com>
Subject: [RESEND PATCH 0/2] MIPS syscall auditing patches
Date:   Wed,  2 Apr 2014 12:13:14 +0200
Message-Id: <1396433596-612624-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Ralf Baechle <ralf@linux-mips.org>

Hello,

This is a resend of the syscall auditing patches for MIPS, as sent by
Ralf Baechle almost 3 years ago [1].  I've rediffed them against latest
linux kernels and audit userland trunk. 

Here's what Ralf said then:

>>>
This is the first cut of the MIPS auditing patches.  MIPS doesn't quite
fit into the existing pattern of other architectures and I'd appreciate
your comments and maybe even an Acked-by for the kernel part so I can
feed that upstream.

  Ralf
<<<

Comments welcome!
Thanks,
        Manuel Lauss

[1] https://www.redhat.com/archives/linux-audit/2011-June/msg00027.html
