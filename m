Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 21:14:24 +0100 (CET)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35527 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011815AbcA0UOXOkfeA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 21:14:23 +0100
Received: by mail-pa0-f68.google.com with SMTP id gi1so860516pac.2;
        Wed, 27 Jan 2016 12:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZjTqnzOB8DVJmHgqr6AYzG+lemEKxNareAPth6Z3Vr8=;
        b=0/2cZezIeQ497ZRDjy2IQz50bYgCz6VeeSteTqOXgCvcvkPWMN4wni0bgGV6RLnHgz
         37JLdXsckfcUoEsrp58vCSZJYnX/eQ1hKwY5MA1KAPL48UBG6+J9sVOIFZQl4aSbCk9O
         VqIh0tTkj+JOuu3tUB1j5Y1NqbaCeCZUmU5Q4yKPRWClo6LEdJjGGNv2NWTzZwf57Lok
         Imi4xLnb4dd//IHzKXg54zGuMIbnrgR+EjiapmRB+utOIn+qgwfRqj3uOqdJXyvxwDB2
         djnXjM3js3Xpwf4c0XrnZK8hnJFVjG5D8gLKimxSXJfpHxNxQubx71rvEF7Nw8V221Er
         BjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZjTqnzOB8DVJmHgqr6AYzG+lemEKxNareAPth6Z3Vr8=;
        b=OYiNkpryCfNVSWWwbXnuwjFefNCqIV2HNz5R7KrfJIHpS17N/FyD8UP6c8JgRjYCTQ
         By4eeF+Xgs62OGK4VuIm6xFP2/T39hl18pXBbQQJVzV+Eelkj7Ncj5ruzf5FF1LCcziw
         Oc+OSkpExeviAJwmrd97wU1vGH8RyycWCah6b/o9V2bgLgVsM0Tc0CTBHqsxwc1N60Xo
         vIRwM/FySA98B3Js4b63OAluE+V1+UvR3bhDCAJErO4nRWWGUlHpN0A/BCUDPwb4fvps
         Pxwnis12tLAH6UTGyci/hFriFu1wQPR9mtC129CoV1vKdysd4D0DVwgX0zAJzxIcdbvs
         Cklw==
X-Gm-Message-State: AG10YOQUT2iTTbDyIqNTgASo7b+YSpHFasAmWtk2IItL35EL8uqHSZXKz1yS9gsddWQb3g==
X-Received: by 10.66.102.40 with SMTP id fl8mr45299505pab.136.1453925657054;
        Wed, 27 Jan 2016 12:14:17 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id 75sm10987965pfj.20.2016.01.27.12.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 12:14:16 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, computersforpeace@gmail.com,
        cernekee@gmail.com, jogo@openwrt.org, simon@fire.lp0.eu,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] MIPS: Enable BCM63xx partition parser in defconfigs
Date:   Wed, 27 Jan 2016 12:13:14 -0800
Message-Id: <1453925596-24661-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51484
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

This patch series enables the BCM63xx partition parser where it is relevant:
BCM63xx SoCs DSL defconfig, and BMIPS big-endian defconfig (for DSL and CM
SoCS).

Having this will improve the build coverage for that driver moving forward,
and is also needed for booting from MTD devices.

Florian Fainelli (2):
  MIPS: BCM63xx: Enable partition parser in defconfig
  MIPS: BMIPS: Enable partition parser in defconfig

 arch/mips/configs/bcm63xx_defconfig  | 1 +
 arch/mips/configs/bmips_be_defconfig | 1 +
 2 files changed, 2 insertions(+)

-- 
2.1.0
