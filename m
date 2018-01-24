Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 02:40:37 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:39801
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992827AbeAXBkbW8ReZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 02:40:31 +0100
Received: by mail-qt0-x242.google.com with SMTP id f4so6550223qtj.6;
        Tue, 23 Jan 2018 17:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fow40j2y787sFw6ew76IAgUNpTcSGHU0TwIurh4JYqc=;
        b=eHT8Vi8fGWdYmhzH1dXCY0pWrK8uai/RmbSiBXLSBAmFhBgtNs+fvCAdIhHTJznFWE
         esif+9R97o9KmqNCtVuIBUqSjQZPceACgJ7lpa2GTr/USR9uBOaJYhdK+oJxIZ7cbxZB
         +S299y5SaXvXrPY3E8kmDTdD1Pf+fpQ16uluCWr6wSqVcIwelBKIVjFnhNWeIea+IqyZ
         l3MVFZu2mgYsdH/aKjG05b+8C8/LpVaZAErnSYB7VQHX4KqpjDW2/wYvKXD65GQU2GZV
         m8rcsyeWz+RfoTA6f/Qt+6BUzO/Eo6OH9WZvWYDMZJ7+2ilBUbsMoykSloIL6HP0u2tN
         ovmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fow40j2y787sFw6ew76IAgUNpTcSGHU0TwIurh4JYqc=;
        b=lQ4whgVPr5PXcg41I7Jr+Xx7keayHKItiqMtVJjc7TuqN8LnJqwDo5NOYzbdCITxQO
         A+meWDoRtjsK0rmP0qi66STjJcCBYnEMRqebtk1tqwxre8kgPW6QMtQPcW3MdymLkKtt
         FT8/ME0kAEWp48aXUGT3LDohpzEajA/mG1YTbiTeJZwM029sP7jXgLj7sG/YbMBYJoHe
         EJUDisiMNoeFBC5FnOoVMs6exGb45b1DYK1w0AfKOttIqEFT+NMsP5MYc+zzWSSvvr+v
         Lk8IhxEutsi0XXiRDNB0yg9AjNiROHoB4wbneHjGl8PHt3Liy5+T7bf/CfNfgYRCOVga
         OJTw==
X-Gm-Message-State: AKwxyteczIOV+SvZtBgudt/ENdGIE3rVMayz2+Y2A93XKjCoiqZmWkcW
        O0Emwf+gRBT7SYXbEnk+iS9wuKYl
X-Google-Smtp-Source: AH8x225c77rnwNo/R5pTeJtmUVA7j2cQK5jPjFOPBCbX0vtk7f9cwJex5OMe4RD1TR89yacn8k7BQg==
X-Received: by 10.55.124.3 with SMTP id x3mr6446006qkc.179.1516758024850;
        Tue, 23 Jan 2018 17:40:24 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id u123sm6071154qkd.21.2018.01.23.17.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jan 2018 17:40:23 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     jhogan@kernel.org, david.daney@cavium.com, paul.burton@mips.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] MIPS: generic dma-coherence.h inclusion
Date:   Tue, 23 Jan 2018 17:40:08 -0800
Message-Id: <1516758010-7641-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi all,

This patch series does update mach-generic/dma-coherence.h to test whether a
machine is already defining any of the functions. This is aimed at avoiding the
need for every single platform to redefine its own functions, as well as make
us future proof in case we need to add new infrastructure, which I am about to.

Thanks

Florian Fainelli (2):
  MIPS: Allow including mach-generic/dma-coherence.h
  MIPS: Update dma-coherence.h files

 arch/mips/include/asm/mach-ath25/dma-coherence.h   | 10 +++++---
 arch/mips/include/asm/mach-bmips/dma-coherence.h   | 24 +++++--------------
 .../include/asm/mach-cavium-octeon/dma-coherence.h | 14 +++++++----
 arch/mips/include/asm/mach-generic/dma-coherence.h | 16 +++++++++++++
 arch/mips/include/asm/mach-ip27/dma-coherence.h    | 28 +++++-----------------
 arch/mips/include/asm/mach-ip32/dma-coherence.h    | 16 ++++++-------
 arch/mips/include/asm/mach-jazz/dma-coherence.h    | 24 ++++++-------------
 .../include/asm/mach-loongson64/dma-coherence.h    | 16 ++++++-------
 8 files changed, 67 insertions(+), 81 deletions(-)

-- 
2.7.4
