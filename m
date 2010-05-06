Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 19:30:10 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:52541 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492205Ab0EFRaH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 19:30:07 +0200
Received: by pvg16 with SMTP id 16so87989pvg.36
        for <multiple recipients>; Thu, 06 May 2010 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=t4A853Hj/QFyifrtpkYYtcXRepJLVKQm1VVeX5qIQeY=;
        b=ZOKNpDqND5pT8+Oh/LH3espkh9ZUDPoZnF1gtNlrETDDEGEcANsQ0c3Nr7jfwqbJFW
         VTaT6zzN7L62G2G+DwFh0kVxVhpo/0yXZy2KJKaH3qCusk1MB1K3BOBZeMGslqLqGBC2
         cA7zSgaw5DopGm0CFca92Kw+alaTI8gomau3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Zu43QKF9d63+GIoUt+mbTkzrYUrRpLC4yIeRk7uJbWGfXrSXE7XXkx1Cas+IP7p6S/
         tQplAHoQTmIvfsOE6GBQ2zvZkaw3b/XaAq99PaEXWLMgB5n02lUGjqoVLYWlX1G03KX8
         ESC4wY20VF3mxY8ERiYzBZBb4E6SR71Rq2Zww=
Received: by 10.114.162.24 with SMTP id k24mr14412038wae.158.1273166999193;
        Thu, 06 May 2010 10:29:59 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm5257084wam.5.2010.05.06.10.29.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 10:29:58 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 0/5] Oprofile: Loongson: add misc cleanups
Date:   Fri,  7 May 2010 01:29:43 +0800
Message-Id: <cover.1273165681.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patchset add some cleanups for the Loongson specific oprofile support.

Wu Zhangjin (5):
  Oprofile: Loongson: add an unified macro for setting events
  Oprofile: Loongson: Remove unneeded Parentheses
  Oprofile: Loongson: Remove unneeded variable from
    loongson2_cpu_setup()
  Oprofile: Loongson: Cleanup of the macros
  Oprofile: Loongson: Cleanup the comments

 arch/mips/oprofile/op_model_loongson2.c |   57 ++++++++++---------------------
 1 files changed, 18 insertions(+), 39 deletions(-)
