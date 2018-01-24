Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 12:42:54 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:39078
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992821AbeAXLm3jFK82 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 12:42:29 +0100
Received: by mail-wm0-x242.google.com with SMTP id b21so7988242wme.4;
        Wed, 24 Jan 2018 03:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5vmJgdLnS9/WCcOddI5Ot7YS+u9wX9YPSqKajYlJTc=;
        b=ntsvGyb8VhpjIAYq/y77wkyhSRWJUNXutz1FEPwS1PCUVtA5C0maQfkA7dJPru/ii2
         vOUs5SC8rzItVLMr9PljFc9WNbQjfC0hoRAoDVCCKYYFY3srwlepgE2v8jcj//rnjk1s
         EX7dV9bhufyHwjK6diSXOGIy4uoGO6tzn4/mM/L2KqA3Cd44MM9s2MEDB2rEsoiszUIv
         JLmF9BL0fKTEZbNdPf2YRrH+Q6kNrGjtTXB4LEq7oMsW7F1rEwfevaoq9WvuD/UiyReg
         dyqcbRHXSJO31FdOvUSBdXe7wzowJtdp1mD50C+xNH46KBUqThZgTHQx/Y+AvsPgRbz/
         RiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=h5vmJgdLnS9/WCcOddI5Ot7YS+u9wX9YPSqKajYlJTc=;
        b=ZuN8HvPMTn9p/QaOxG7og5m9Sz7FdQFv2Px1PxIM85xwFsE/4/wD6mSuzEYnmbKoId
         V3UI40BZgVfiPIdhj7ZErixkmLedR/cRD6uvQr1uq22X4L94D5UVDIraoGNJYI5CbGkr
         7NHO7uhea/JFEPlgWl40bubDkiy8ogMWrsq+9q7ATIUv3iRK22GIl0Gtw1sf72R9mYZw
         XHCucKdlNUgZq68rpFcAFgPVDRIKCm0afK5K8yhd80+iW/Tx5Jpn34B3f8I3cVAkCxhS
         GymXq7CYxT0VPxv6eC+IqHUg3AfwXPKN4wVbMWccpiMubzmMO7WKYEHDXuowOApj2y92
         Yjiw==
X-Gm-Message-State: AKwxytdiuVu8NkhypkCnj2dNdc5/YYHZW1j205t7Vby4hLwsxJvT2+Rj
        vnq5bcqleJWt/ODknwlXxGQ=
X-Google-Smtp-Source: AH8x226Xe5gS8w9ERW1ijoEYLOX8qdbhREsYlv9lt0mkWSACJN9Rs+w/pTbRIiQ1bycVlmbkxt/BYQ==
X-Received: by 10.28.214.67 with SMTP id n64mr4099968wmg.25.1516794144243;
        Wed, 24 Jan 2018 03:42:24 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id m6sm12994wmd.37.2018.01.24.03.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:42:23 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 83B7E10C32FB; Wed, 24 Jan 2018 12:42:22 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mips: dts: Fix a typo in the node unit name
Date:   Wed, 24 Jan 2018 12:42:08 +0100
Message-Id: <20180124114210.26457-2-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180124114210.26457-1-malat@debian.org>
References: <20171214165358.28058-1-malat@debian.org>
 <20180124114210.26457-1-malat@debian.org>
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

The unit name was 8c00000 but since the reg property is declared as:

  reg = <0x0 0x4c00000 0x1 0xfb400000>;

the unit name should have been instead 4c00000.

Tested on MIPS Creator CI20 (v1):

$ cat /sys/firmware/devicetree/.../partitions/partition@4c00000/label;echo
system

Reported-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 7d5e49e40b0d..38078594cf97 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -125,7 +125,7 @@
 					reg = <0x0 0xc00000 0x0 0x4000000>;
 				};
 
-				partition@8c00000 {
+				partition@4c00000 {
 					label = "system";
 					reg = <0x0 0x4c00000 0x1 0xfb400000>;
 				};
-- 
2.11.0
