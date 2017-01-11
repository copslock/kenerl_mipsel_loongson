Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 15:32:05 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.75]:64526 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993891AbdAKOblAwJgP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2017 15:31:41 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lilwb-1d22ew3bTB-00cvya; Wed, 11 Jan 2017 15:31:27 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mips: update ip27_defconfig for SCSI_DH change
Date:   Wed, 11 Jan 2017 15:29:50 +0100
Message-Id: <20170111143054.410084-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170111143054.410084-1-arnd@arndb.de>
References: <20170111143054.410084-1-arnd@arndb.de>
X-Provags-ID: V03:K0:E/bbxrBv+85dTidMheNyiOXSgfwnbb6nOpinzBWKEM/6qiMcSr0
 ORHvDlWMlnJnWEGJhFVv7MyMEz7i2CvRp/gz5qtKuGADUnHiKdvJXnTNBWPM8kdS5+JpF2W
 r/71/ysZybYPuH2txahXORgVxXsE210OraxPibG6CD1oRDYhjLuxnGLRUFho/+W4e8DYadO
 14uSGxYhB6fUDuqVzXt0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:33Xvq9rW+wE=:GYmU7ThLjoU/DgYPObjMS7
 +RyVhsbhsBNZpQIFHvGfXvLD2xOe9I3sJ7auPcmHuPFwngfk9R+kHt8ne+0KBSIwJjWfDosjj
 bWrshly1wQySCmkTEk+LePabFfKIS7qXZYhYGCYfuoYmoRbwrWX2DlkrkF8/JvHJfSGn48oho
 qIO0MUXkanh1s2G29Q2XY/6WcNDkmPCEkWseNY1b+dnlgFTgwDz8UzamKxtWP9fJGCm2aEOjJ
 3RMfTcWYYei5CzQ6bj4ajdHw+Vq4mZgcRM1VDI69T8covWcB5XIBQoNIapwsVZ7sH31UNozU7
 //7EJnV7nTgJkxx6tyCZdsPrUs4FUqP776DfzyP7RnJ39w0F+rS6S/5968Mm39CGQt2DUxmhK
 FRjUfHFjAGgToStCG7L/3VLj1zL0Ga6liecrE6KPQ16kxOkad/H/f7g1L2Hcj3e4OgE8EpBqA
 81LHamX5kvdoz7iQEbubh3saczzjreBkejkYICOSsvyBKdr+hBbc5Kb4Rv8yefE6LrKGeBr9P
 Ah6AI7oU4mwIBRQgGi447xRQSBasoXzhp4oFFtKRn0Vm3R9ft4va/9XOVTAC1WagH3UXCSnHX
 UE++HXj2tz25f2K/nmfbmvv/aO7vftl6VG23zhjmSg7KglBf9Lp0t+o0MS/S+tP3XbW7Y788A
 gqrRxFe5BjfYap0MytKn8w79mV8UnkxcSaROrobB2i6adLM4mcvPOS0WWFLPxW0dM9FQ=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

Since linux-4.3, SCSI_DH is a bool symbol, causing a warning in
kernelci.org:

arch/mips/configs/ip27_defconfig:136:warning: symbol value 'm' invalid for SCSI_DH

This updates the defconfig to have the feature built-in.

Fixes: 086b91d052eb ("scsi_dh: integrate into the core SCSI code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/configs/ip27_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 2b74aee320a1..18f024967dcd 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -133,7 +133,7 @@ CONFIG_LIBFC=m
 CONFIG_SCSI_QLOGIC_1280=y
 CONFIG_SCSI_PMCRAID=m
 CONFIG_SCSI_BFA_FC=m
-CONFIG_SCSI_DH=m
+CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_HP_SW=m
 CONFIG_SCSI_DH_EMC=m
-- 
2.9.0
