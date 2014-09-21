Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2014 02:44:58 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35822 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008708AbaIUAo4MKAwn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2014 02:44:56 +0200
Received: by mail-pa0-f43.google.com with SMTP id kx10so2349406pab.30
        for <multiple recipients>; Sat, 20 Sep 2014 17:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=2xxw1d19ojdTL9Tkjds9zmHgdA1bDZU7aJZCVsxYpLU=;
        b=Chu0RRqC2OWJobz/cB1aGEp8vrHMBum+xdM/6Tbzi1VoqYORmhxlQRCMaEAEfQCvh/
         dJIuPp2KnZfbuzTO+RwyqZfZaWfxihSzNJ14dj115Tt1xhp5b44sITVjjz0xL0c1sLTA
         sQV6Fzbe4xYdfrCKBJ5PjchqAQlN3pArqrbMhcWSU3lKnBUWL03s27MUCAZb8Q3fyi/X
         +DOzSZ8/jWDLjZXlV2pA+iDKLjoqsw0uHjFq7hEaDTWKceBWEQyMzULFFHXXoTY/3CL2
         kSfDzu6iKF3cvN8pIDaFR6dnXj8Cp2HBI5sNP6tw9pvdGXWrS0q7uqBfR5MX+NluwIxi
         PPYA==
X-Received: by 10.68.209.138 with SMTP id mm10mr12724147pbc.88.1411260289369;
        Sat, 20 Sep 2014 17:44:49 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id v16sm5526371pdi.39.2014.09.20.17.44.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 17:44:48 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anish Bhatt <anish@chelsio.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 00/11] next: mips: Fix default configurations
Date:   Sat, 20 Sep 2014 17:44:33 -0700
Message-Id: <1411260284-6574-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42707
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
