Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2018 23:42:19 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:37700
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeA3WmM4NGp2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jan 2018 23:42:12 +0100
Received: by mail-lf0-x241.google.com with SMTP id 63so17787830lfv.4;
        Tue, 30 Jan 2018 14:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fblrBoDlj/msbn/PpIWioJNYgP6wXAtPyG30w4wn6ks=;
        b=KSHt0Bnhih8POSK8fAlOtA0fRF6m5u+vSyBJ5YapPJRmgThX8MQU8NbeHxd+MF74Pl
         h3Y+eUwMv+JlMnRc7W9zCaOOvUg6ecTVd0Xtqiffn+BAum/T7uz20FuXySMlDgq1fJ9T
         MBnnQtcqzsA8jicP+V3SqPOv+aGOOl6ssJ+MYlMQaxQww8g7w2ipWdM3RRU+fdsLmE0e
         I5v8jeKDN6n0hhEvIGU5pXwFMBhs3dF33AI0IlGCACEWgxTNSvtuw+Y8Xh8RbS8OkHVL
         +RYOIKV4RkdbpfqboZPsLpSnsHkifD6+fqLahq8V5nWzPF6NBkqQcjr2Untu3vYDzB8/
         7OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fblrBoDlj/msbn/PpIWioJNYgP6wXAtPyG30w4wn6ks=;
        b=XJwxYAu7D2htTPDLDXaCUCZwqx8R2cn1p1jrwTaGMNCum4ev0REfvxUdmBMAn50jQ8
         cPsl9i+xmLCl/o6Xp6xro3Ow6a4v9YsWme2qaLz7Kr6lJ+JhXSPLxdisPy4BI1ZrfAgH
         OvRnlr/0icicBSKnipJuMkIjrnycQ1L3AHAvnwRAHV+WsDBgk+wsbHAMdURO3ZgZ5V8A
         kXSCvyKY+MrBp+ROTVCq4Oqqi6wN2Hi/9+DmnykUgeESFDITZquc3H7k6pcJ83LSrgOs
         j0FH9FCQvwcN5zZVxq78V7hgdjcms2qu2IsJPdeHOXjeRv0oKtfjS1OIuKjwEwFYYsvR
         lEGA==
X-Gm-Message-State: AKwxytcjIEyMPM/4W4vk3keJXBUgH8Ia5Xfvlh1gXgA1FfY/c9znrL89
        hDlDbo0MYPJT99M9W8NEkajIig==
X-Google-Smtp-Source: AH8x226Aj7XQF6ij1hjLZhcgMNIfUoSH3eb5ejt0HUn9Oa9kHvBUG58tqdG7xgnZPIePv/51A4uuqg==
X-Received: by 10.46.18.84 with SMTP id t81mr12304601lje.76.1517352126949;
        Tue, 30 Jan 2018 14:42:06 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-108-121.pppoe.spdop.ru. [109.252.108.121])
        by smtp.gmail.com with ESMTPSA id 4sm2938194lja.20.2018.01.30.14.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 14:42:06 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] MIPS: use generic GCC library routines from lib/
Date:   Wed, 31 Jan 2018 01:42:00 +0300
Message-Id: <20180130224202.7682-1-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.15.1
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Changes since v1 patch series (https://www.linux-mips.org/archives/linux-mips/2018-01/msg00394.html):

  * sort the CONFIG_* options in arch/mips/Kconfig alphabetically;
  * add notrace to lib/ucmpdi2.c.

Antony Pavlov (1):
  MIPS: use generic GCC library routines from lib/

Palmer Dabbelt (1):
  Add notrace to lib/ucmpdi2.c

 arch/mips/Kconfig       |  5 +++++
 arch/mips/lib/Makefile  |  2 +-
 arch/mips/lib/ashldi3.c | 30 ------------------------------
 arch/mips/lib/ashrdi3.c | 32 --------------------------------
 arch/mips/lib/cmpdi2.c  | 28 ----------------------------
 arch/mips/lib/lshrdi3.c | 30 ------------------------------
 arch/mips/lib/ucmpdi2.c | 22 ----------------------
 lib/ucmpdi2.c           |  2 +-
 8 files changed, 7 insertions(+), 144 deletions(-)
 delete mode 100644 arch/mips/lib/ashldi3.c
 delete mode 100644 arch/mips/lib/ashrdi3.c
 delete mode 100644 arch/mips/lib/cmpdi2.c
 delete mode 100644 arch/mips/lib/lshrdi3.c
 delete mode 100644 arch/mips/lib/ucmpdi2.c

-- 
2.11.0
