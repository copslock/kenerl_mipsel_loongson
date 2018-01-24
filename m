Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 12:42:33 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:38145
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbeAXLm1HAzS2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 12:42:27 +0100
Received: by mail-wm0-x241.google.com with SMTP id 141so7939047wme.3;
        Wed, 24 Jan 2018 03:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DTB+FHvDVLWyEqN8a0PXAhjJPbaxuvYJgZoWnSTZAaI=;
        b=pmBCMABXN04H22W3ugByXKc/A2KtcvmozNYM5gub8NApIi/PQVcT28NSanSlSs2lXo
         Mh7wSlqakYhHK2NLbWncmWFv0sTI7DPHe2SX18GhiyOcmPvG5lrbniOraJ/qge68tLRu
         ccVHlSm8pyLTZpA17rLT2lPSjscLrT9jAVxVsjp1Bnq9FJTlQ0zkWGioaQByxopIKyjg
         ipo5/DRSYyFJ3iUzDpPVQawtydBTXPrniuaWFkNly4bJok29XNisFvxvRAgvrBoubJJk
         ilVXPnVtby80bk2DxoGDZzbZl0hI9nKlxOC3OCSl4GfLiTGHaldK2r21gdUVYtPqfFLd
         pPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=DTB+FHvDVLWyEqN8a0PXAhjJPbaxuvYJgZoWnSTZAaI=;
        b=XyQzuRqC6gPpRf4j+uhJMFQiTB6LR4iVvoA3HdzxhlTTmj7hwBa0x/uc9W/ROK505x
         TYatT3895hJYWLa/wjMHIon5W5BeTEp3WGBrlnllEWEwwt2HLGwHGla7UQpe/4qoBhiY
         tvF59blA95Dg1WXvDzLCkTQcohABYDgKno2LqZniX4FhsIkakc3Bn/UcTpjlaN8V07Th
         wZbn5i4EMxPOi1PSCTOoV85p5t07+5ovr2HLaOB72azQVGabqjFZXLEJ8rcvriDsvzRY
         6y5Jc+34iU8526sMl8MqsY+QC2USzuaAKW23PNC/CDwnsqVV0cblyzzQSTVdGlOcni+A
         13EA==
X-Gm-Message-State: AKwxytdmGsZQVKz/suwP1lGuA1wtcGPZ3p6fAvgmjXiu8K4jMuhrgTsc
        P/h81AsEA92XpK2slnpmes0=
X-Google-Smtp-Source: AH8x225MTEKHOqyEmpgUkXFkc9yxLD4T2OOfnbaFF7h3LoWDKTvR8wFjK+sisBMLqjieHjWDM/1fDA==
X-Received: by 10.28.184.82 with SMTP id i79mr4586824wmf.6.1516794140866;
        Wed, 24 Jan 2018 03:42:20 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id 78sm52532wmm.22.2018.01.24.03.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:42:20 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id CEE3F10C32FB; Wed, 24 Jan 2018 12:42:18 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mips: dts: Remove leading 0x and 0s from bindings notation
Date:   Wed, 24 Jan 2018 12:42:07 +0100
Message-Id: <20180124114210.26457-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171214165358.28058-1-malat@debian.org>
References: <20171214165358.28058-1-malat@debian.org>
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62308
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

Improve the DTS files by removing all the leading "0x" and zeros to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -E -i -e "s/@0x([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" -e "s/@0+([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" {} +

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/boot/dts/img/boston.dts   | 2 +-
 arch/mips/boot/dts/ingenic/ci20.dts | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/boston.dts
index 2cd49b60e030..1bd105428f61 100644
--- a/arch/mips/boot/dts/img/boston.dts
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -157,7 +157,7 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					rtc@0x68 {
+					rtc@68 {
 						compatible = "st,m41t81s";
 						reg = <0x68>;
 					};
diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index a4cc52214dbd..7d5e49e40b0d 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -110,22 +110,22 @@
 					reg = <0x0 0x0 0x0 0x800000>;
 				};
 
-				partition@0x800000 {
+				partition@800000 {
 					label = "u-boot";
 					reg = <0x0 0x800000 0x0 0x200000>;
 				};
 
-				partition@0xa00000 {
+				partition@a00000 {
 					label = "u-boot-env";
 					reg = <0x0 0xa00000 0x0 0x200000>;
 				};
 
-				partition@0xc00000 {
+				partition@c00000 {
 					label = "boot";
 					reg = <0x0 0xc00000 0x0 0x4000000>;
 				};
 
-				partition@0x8c00000 {
+				partition@8c00000 {
 					label = "system";
 					reg = <0x0 0x4c00000 0x1 0xfb400000>;
 				};
-- 
2.11.0
