Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:45:44 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:37488 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009371AbaIUApmZv700 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:45:42 +0200
Received: by mail-pa0-f45.google.com with SMTP id lj1so1495572pab.18
        for <multiple recipients>; Sat, 20 Sep 2014 17:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=2xxw1d19ojdTL9Tkjds9zmHgdA1bDZU7aJZCVsxYpLU=;
        b=DCd9Dwjz8xINy9FiGdb6AAH761DKuOrw2LwZ5xVtK3XY8CGbhy97q80Af865atNUNf
         sGxu1twmfk65JpXxTZmYE5ax/HOpM5utOuynThCNmvigyMDe5XpTVPJsL2Zbb2kXoP5C
         qacjxHOXiYGwk21jiogHAs/z/0gRGGdCsUV/4RAcZciDfGol+Yyilq9dI/TJC+wQZr57
         MpPAQO9zJerRgc5pOC9WWLfWdgoPjJiB7nL3ap1/KZY8ZubFlFotlsjwfL5zeTDBYFez
         7GnOft8IyKlYMAy0TAslb4L+6f/zmnVbEys3itP5kEYXZsMkOlYcBAsVOKbKy8LbtCBb
         1rXQ==
X-Received: by 10.68.195.74 with SMTP id ic10mr12649783pbc.93.1411260335251;
        Sat, 20 Sep 2014 17:45:35 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id na4sm5495256pdb.96.2014.09.20.17.45.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:45:34 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 00/11] next: mips: Fix default configurations
Date:   Sat, 20 Sep 2014 17:45:19 -0700
Message-Id: <1411260330-6716-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42708
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
