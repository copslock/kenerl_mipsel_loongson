Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2016 09:38:50 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32934 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27040881AbcFMHitPzbkC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2016 09:38:49 +0200
Received: by mail-wm0-f67.google.com with SMTP id r5so12597950wmr.0;
        Mon, 13 Jun 2016 00:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9C0KJwh7w6/OCAWZEL4VAokcNysWYR/iTEt3tZRQzIA=;
        b=Jlj8AShHxvK9r+oRrIrIcfrDF7GIk0CzT6tuB9/eHJtwaZtGiDsw/zblhwNLs6mzkg
         ijy4nQ8bBl8o9FFzMo35XbUGgQiVO/s9OsZ1cIKqlzy+XgJKGxGY6AXCjFRatY9tjEmW
         IwXvB2d+aZVzYm34Ompd4Y9ISzz+jaBakk/ErnoRoxHTJDnExXA6hwK++wlx6Uord79D
         6lnA9xBqRD8hGtzptfVShlb8eMdiBXyei0wP0qwXqt9Jmh6ELXIFSQPej1KJVBAvr5Ce
         PBA1L3LhXVNRoT00T1S/CMsErZobYfQCwUQ9SNdsSGUyVKPe0572c/Pa20pDRKxYX6Es
         KvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9C0KJwh7w6/OCAWZEL4VAokcNysWYR/iTEt3tZRQzIA=;
        b=NUN9/RJmv9vkMsvUFSwys7wBFdL3+78btFFZsdrbft+czR6jwqyAUBa4RxNUJiizGH
         sgIRWsq++x2tbKIodkwrPwQfnC2NCttcdiSmHSuW0IwgkJIgIoAFKoY9YVaFRrNhvSOw
         Zbhaxz5N0via/oPIakg2/geUK52X/rZNYmzVGWKqoX4UdjTqL/fvCEYzBkVyv04XMv1Q
         tV6q8d8Fjg2tQim6e2hJgxMcOZQssUfp9wMTHL4kJvtYGOTTmJmczbPlMlw3gC/jNE5w
         y3bzFwGRA7iyXpGkuKmVq+sbwDkQfg6QWTXpbhBhcPVEMm7+sW+mTFwqXkJVuIhH44kW
         GVUw==
X-Gm-Message-State: ALyK8tLWHfn7O5WO5ontC9Ui9M24Cr4PJDi6Ut8EUYq90t1VhR/hRQ7hos/83wVsr0bC1g==
X-Received: by 10.194.75.169 with SMTP id d9mr13038163wjw.167.1465803523988;
        Mon, 13 Jun 2016 00:38:43 -0700 (PDT)
Received: from localhost.localdomain (145.red-88-15-142.dynamicip.rima-tde.net. [88.15.142.145])
        by smtp.gmail.com with ESMTPSA id g4sm5833759wju.30.2016.06.13.00.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 00:38:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        robh@kernel.org, simon@fire.lp0.eu
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/6] MIPS: BMIPS: add missing console to bcm96358nb4ser
Date:   Mon, 13 Jun 2016 09:38:49 +0200
Message-Id: <1465803534-25840-1-git-send-email-noltari@gmail.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

Console definition is needed in order to avoid a warning in earlycon to
console transition.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm96358nb4ser.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
index f412117..702eae2 100644
--- a/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
+++ b/arch/mips/boot/dts/brcm/bcm96358nb4ser.dts
@@ -12,6 +12,7 @@
 	};
 
 	chosen {
+		bootargs = "console=ttyS0,115200";
 		stdout-path = &uart0;
 	};
 };
-- 
2.1.4
