Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 09:02:44 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:47768 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491152Ab1AYICl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 09:02:41 +0100
Received: by gyg4 with SMTP id 4so1621585gyg.36
        for <multiple recipients>; Tue, 25 Jan 2011 00:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=sxUBwgszrrEu43ZdgL04UolW/l3zKsI/REB7F1WpqiU=;
        b=XmXcnXPaXY8viTVGgLQ3QOFspc+qgoCHzSZb2zgHEQo8ija4S+QyzzMh1KVprDzLyV
         qQEmsk6V7DG870Y2MmpcdufC431JexFCUUaw0+83wlbnjQF88QAK0W8ongH1BL23mOsf
         SCTGdUrZlKl1Tz7/l8FBrd24HDgX+IJ8iDxxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QSmDHaYLFtkz77o7pstURZEBD+8uwtIM24u8eKZtm28bTI2o4SOmXl7ZKnnDOkwExE
         lBL87nTYDyn6mtO7c+TQ8h8naXF8E5YGVWGGSn7rb/l/VgDzlPaZHcvB7MrsLe3ucFvp
         4szh0PhFbizrIPfw7BgdpJ8taGMyCAyvGk/Og=
Received: by 10.151.106.19 with SMTP id i19mr5493516ybm.324.1295942554231;
        Tue, 25 Jan 2011 00:02:34 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id v8sm9304940yba.14.2011.01.25.00.02.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 00:02:33 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH 0/6] Various Enhancements for PMC-Sierra MSP SoC support
Date:   Tue, 25 Jan 2011 13:48:32 +0530
Message-Id: <1295943512-19900-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>

Following Series of patches add various enahancements for PMC-Sierra
MSP71xx family of SoC's platform hooks, including MIPS MT mode support
and support for various onchip devices like USB and Ethernet.  

Anoop P A (6):
  set up MSP VPE1 timer.
  Vectored interrupt support.
  MIPS MT kernel modes ( VSMP/SMTC ) support for MSP platforms.
  Platform support MSP onchip USB controller.
  Platform support for On-chip MSP ethernet devices.
  Cpu features overrides for msp platforms.
