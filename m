Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 19:57:54 +0200 (CEST)
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36745 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008771AbcDDR5slbb1W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 19:57:48 +0200
Received: by mail-pf0-f169.google.com with SMTP id e128so127279063pfe.3;
        Mon, 04 Apr 2016 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mD85DH0IAgHEYkfoUEbRGEHN7XY2r2EaHinnx+oXwPA=;
        b=bs3SmDNphtBVXkRsFN1xGa7QP9YWP48Ov/60o5jG/ZGjkkHxhQPSLq37C7wgHU9Xtx
         Ohy2eTIu+YuHtrugm/rLSbYDePJfnY1Dz+jWxto30nK7bF3znaB9SlTUfMMZId+9qNB9
         K/3Ick+v4Z9+i3TszWTGYzpwKlnx5n2LqdEACvpf0KXgIYET2yTUGb4NLIZlYSMSqvkn
         /M/++/UaXQ0Kne91imBME8XjUVMQQYyzIcIQbEiVIq15UPb98DYTAM3lUVmDUS957Z70
         bZu/eF7StitLb/7j+HXj+FSZKiirfNDDqsCgqnzDNJBA60XmRh966EtKVCE5Gtpmocsz
         XFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mD85DH0IAgHEYkfoUEbRGEHN7XY2r2EaHinnx+oXwPA=;
        b=aG68plfu4tGlMCSOL4I1EaCaTZeLqrmNi/7FYuHXxT23kbxiG16zeTG1xhRqswwhUf
         Ephra2t96XYnt1zhfZrru3KdmFkwkppTUsYkhUazGHTfUbs9KVkgxQ/JLc4X1rITOhmR
         hnlma7iiflAZn1KxSMTmmBTe+jM7ZWOPL+tFIgmLS9SUejrbwesrKepW3rVjbmM7LBxr
         c6WC7opZnWQC8gSH83f7d0FVzROgcKSL6MnNOGSHUYs9Ah1jjrS3nE6rat6l6ST6D0h/
         Ar59AZMvnQiyPKKMmrbls3M6NQm0n3XtgxSq+L9m1gUETPl9gkhObnif4l6tJH+h8sKY
         x/6Q==
X-Gm-Message-State: AD7BkJKJZbB/Kos7VfhgA6owRhphwrJf87/yduN+3VAnMvtNG5bMPriLWIGhkVXcK4Pu7w==
X-Received: by 10.98.67.199 with SMTP id l68mr22411731pfi.18.1459792662444;
        Mon, 04 Apr 2016 10:57:42 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id 20sm40948752pfj.80.2016.04.04.10.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 10:57:41 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 0/5] MIPS: BMIPS: Misc fixes
Date:   Mon,  4 Apr 2016 10:55:33 -0700
Message-Id: <1459792538-19854-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52877
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

Hi Ralf,

This is a rebase of the patches previously submitted here:

https://www.linux-mips.org/archives/linux-mips/2016-01/msg00737.html

now against mips-for-linux-next as of v4.6-rc1-135-g24fead1eb323

Thanks!

Florian Fainelli (5):
  MIPS: BMIPS: BMIPS5000 has I cache filing from D cache
  MIPS: BMIPS: Clear MIPS_CACHE_ALIASES earlier
  MIPS: BMIPS: local_r4k___flush_cache_all needs to blast S-cache
  MIPS: BMIPS: Add cpu-feature-overrides.h
  MIPS: BMIPS: Pretty print BMIPS5200 processor name

 arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h | 14 ++++++++++++++
 arch/mips/kernel/cpu-probe.c                             |  5 ++++-
 arch/mips/mm/c-r4k.c                                     | 13 +++++++++++--
 3 files changed, 29 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bmips/cpu-feature-overrides.h

-- 
2.1.0
