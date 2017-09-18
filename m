Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 16:04:16 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:35781
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992864AbdIROEFbm4YY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 16:04:05 +0200
Received: by mail-pg0-x244.google.com with SMTP id j16so296268pga.2;
        Mon, 18 Sep 2017 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ctvE4g6bv1pdFGLs/jLm4/NLCaJ4yH8DHt+MoBqDPkk=;
        b=iPoY5B+XqKmLtIV0SMYEKAkivnmM74L39eRTul5LJHswExB7xfuM5WWKlfcZYR85Dt
         b1d5ea3EcW/3PAh0WDHTkI9wDf0bApBNmTdIy9GH5rzsH8S5itqkQLEt1BqyJ86PTTns
         bpJDnfoROOWOCCoi7MebwPlhQElDT8xggfGfunVIhU1clwKDzt4g6z5rVHKb++J8cURd
         zeyI1TO2ccJ5yTvjhTg3RCtac/9SdveRbATsBoS9SMrtDTyQaaE/Qh0MVwNFDkb2B5NK
         g1NUQmrL+b7zO8fZqeaPrZ0anCqWMbVtsTTyzzTI/LoxvMRPlNY2YZgGQt3qBXCPf+uD
         UDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ctvE4g6bv1pdFGLs/jLm4/NLCaJ4yH8DHt+MoBqDPkk=;
        b=iIaSVVQvw5m9jVUiyOODZGhZEXi0QrcOhI3K2Gk4YM8d5zd2hqlPz2mSJI+GQ4NLLm
         2dziXDjPfUYHnJYJif3jUusWk894RXpO0iVf8PZbcIEI7sKocKxqrUOIm/OAPn7Z71gN
         otWEeKE1hKSO8d0Dw7sohH8+IMQ08JJV0zSy6EvD/Rpsl3UKzQ6ircyz0aRWNAMXz/nX
         ikx9lpN2PTOkmkijAhBELYOPBF7AJYhdTCTmG576g2rxJty+RM5wyfdysSHHWazI+vZF
         ffYE+NQGgarjoLkqgNzlCidDH+AUDkZZwFiEGI97enzLeg4RaJ2CaG5AgkQcgiS3iMqY
         If3g==
X-Gm-Message-State: AHPjjUjxWueOsfD9tGiJfOK9/9dYJOgrnMg6ZDoiWSXA9j6mQWIPzSeg
        ec5B7H31t0GWhQ==
X-Google-Smtp-Source: ADKCNb70nFj35C9ASHEbTHpQW17ilpH3eQ5jlaIiL9dp4AAMp5tghG5V5JZ5UDd3QJskXkNCWmC3uA==
X-Received: by 10.99.103.2 with SMTP id b2mr23890861pgc.177.1505743437106;
        Mon, 18 Sep 2017 07:03:57 -0700 (PDT)
Received: from linux.local ([43.224.131.38])
        by smtp.gmail.com with ESMTPSA id q77sm14683252pfa.173.2017.09.18.07.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 07:03:56 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        ralf@linux-mips.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v3 0/4] crypto: Add driver for JZ4780 PRNG
Date:   Mon, 18 Sep 2017 19:32:37 +0530
Message-Id: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

This patch series adds support of pseudo random number generator found
in Ingenic's JZ4780 and X1000 SoC.

Create cgublock node which has CGU and RNG node as its children. The
cgublock node uses "simple-bus" compatible which helps in exposing CGU
and RNG nodes without changing CGU driver. Add 'syscon' compatible in
CGU node in jz4780.dtsi. The jz4780-rng driver uses regmap exposed via
syscon interface to access the RNG registers. CGU driver is not
modified in this patch set as registers used by CGU driver and this
driver are different.

PrasannaKumar Muralidharan (4):
  crypto: jz4780-rng: Add JZ4780 PRNG devicetree binding documentation
  crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
  crypto: jz4780-rng: Add RNG node to jz4780.dtsi
  crypto: jz4780-rng: Enable PRNG support in CI20 defconfig

 .../devicetree/bindings/rng/ingenic,jz4780-rng.txt |  21 +++
 MAINTAINERS                                        |   7 +
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |  25 ++-
 arch/mips/configs/ci20_defconfig                   |   5 +
 drivers/crypto/Kconfig                             |  19 ++
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/jz4780-rng.c                        | 193 +++++++++++++++++++++
 7 files changed, 266 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
 create mode 100644 drivers/crypto/jz4780-rng.c

-- 
2.10.0
