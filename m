Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:46:52 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:61000 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009371AbaIUAqt4As1i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:46:49 +0200
Received: by mail-pa0-f52.google.com with SMTP id hz1so2327270pad.11
        for <multiple recipients>; Sat, 20 Sep 2014 17:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=2xxw1d19ojdTL9Tkjds9zmHgdA1bDZU7aJZCVsxYpLU=;
        b=0LyIPhA4+2IG9x7YS/oIvJH1WMaf1a1skm0PByyj3oBg/xDvSjbEBqKt0cByP3PHoh
         o0ByGkS/pQRYYtsdLp4P3CPuzkKw3M0ib/7CKKnuO1QQ8Len2SUGfyn7sy+Ce9A1GvRp
         5f/6G7WSdtqbjipnjPGzklmQC4R2oyv0fl3PULi5pOMkIjoXnWa/Nj4EmZMGHKDizqZl
         qbBPB6gwI0/uARJEhOWDVeQHSQxbXlZPunAVh9/BGgiMA4EuCBG2xe0O+LxbbfW3yI9L
         JhhrQ6iL+3aW69gDOSDhtq3PAEskGvqWGQjCGVb7+hr4SDw7aFPrBN+49rElIhn3NVcd
         AZZg==
X-Received: by 10.67.4.163 with SMTP id cf3mr11705692pad.92.1411260403761;
        Sat, 20 Sep 2014 17:46:43 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id f12sm5497034pdl.94.2014.09.20.17.46.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:46:43 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 00/11] next: mips: Fix default configurations
Date:   Sat, 20 Sep 2014 17:46:15 -0700
Message-Id: <1411260386-6800-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Commit 5d6be6a5d486 ('scsi_netlink : Make SCSI_NETLINK dependent on NET instead
of selecting NET') in linux-next changes 'select NET' to 'depends NET'. As a
result, many configurations which do not explicitly select CONFIG_NET are no
longer valid and need to be updated.

An alternative to this patch series would be to revert the original commit which
caused the problem. However, a simple revert is no longer possible due to
secondary commits changing more dependencies; an attempt to build
nlm_xlp_defconfig after reverting the commit still failed with a build error.
It would therefore be necessary to track down and revert all related commits.

This patch series attempts to fix the problem for the affected mips
configurations. I did not look into other architectures or configurations.

The command sequence to create the new configuration files is as follows.

- Run "make ARCH=mips <configuration>" on upstream kernel
- Copy resulting .config to next-20140919
- Run "make ARCH=mips olddefconfig" in next-20140919
- Run "make ARCH=mips savedefconfig"
- Copy resulting defconfig file to arch/mips/configs/<configuration>
- Build the image with the resulting configuration

This sequence results in building images for all modified configurations,
but due to secondary dependency changes can not guarantee correctness
or completeness. Only time will show if there are more problems.
