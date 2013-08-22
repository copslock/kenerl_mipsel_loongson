Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Aug 2013 23:33:17 +0200 (CEST)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:45016 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6853519Ab3HVVdLjxZ8Z convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Aug 2013 23:33:11 +0200
Received: by mail-ob0-f173.google.com with SMTP id ta17so4715596obb.18
        for <linux-mips@linux-mips.org>; Thu, 22 Aug 2013 14:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:subject:to:cc:in-reply-to:message-id
         :mime-version:content-type:content-disposition
         :content-transfer-encoding;
        bh=X0fNH57WL8VZtQpU4GPiuKoyeXukCKh1QXA+MJ/liAo=;
        b=Qt+HCgd+17DLlRjfc7A4UiXEuCS8nI/iH3Zlxy5soM/OGFuBBKCqhZd7Wzoy/EXN8I
         4DA10GIEI2jtOSyTt7TOz0HP7rg8aJhEp0m7CLEVI6cJ9vnz/O3lylj+1R2EB/hXh7Pd
         SKsNjOkWbje6LcU83y4T2RtwmiU3m1oODgjgqwp3Bfa04FEWb0SJURXdgy9RunSbAZ9c
         gW2pyzaObIv8e1Ce/mgPkeSf8wYxBlMB0foDi6vsPbueMPSV++ySafSBwvIXYAxHKAqe
         uwqf++6B3ZsgH7ETya4xxAu8z8w5xlEmeQTFs8wSOzLA2N8O2LcX57ajiTROz02msR+P
         rR+w==
X-Gm-Message-State: ALoCoQkle/mkfs/Mzczi7iLY0g6i0zuEWovTmZPCc5XfHdMXxt/ito+KqOTls9hAigtogawKBRP/
X-Received: by 10.60.79.101 with SMTP id i5mr3717048oex.100.1377207185405;
        Thu, 22 Aug 2013 14:33:05 -0700 (PDT)
Received: from driftwood (cpe-72-179-2-121.austin.res.rr.com. [72.179.2.121])
        by mx.google.com with ESMTPSA id jz7sm21467830obb.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 22 Aug 2013 14:33:04 -0700 (PDT)
Date:   Thu, 22 Aug 2013 16:32:55 -0500
From:   Rob Landley <rob@landley.net>
Subject: Re: [RFC] Get rid of SUBARCH
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Michal Marek <mmarek@suse.cz>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jeff Dike <jdike@addtoit.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>
In-Reply-To: <52167AB8.4060206@gmail.com> (from ddaney.cavm@gmail.com on Thu
        Aug 22 15:55:20 2013)
X-Mailer: Balsa 2.4.11
Message-Id: <1377207175.2737.113@driftwood>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On 08/22/2013 03:55:20 PM, David Daney wrote:
> On 08/22/2013 01:41 PM, Rob Landley wrote:
>> On 08/22/2013 07:58:26 AM, Geert Uytterhoeven wrote:
>>> On Wed, Aug 21, 2013 at 9:51 PM, Sam Ravnborg <sam@ravnborg.org>  
>>> wrote:
>>> >> > The series touches also m68k, sh, mips and unicore32.
>>> >> > These architectures magically select a cross compiler if ARCH  
>>> !=
>>> SUBARCH.
>>> >> > Do really need that behavior?
>>> >>
>>> >> This does remove functionality.
>>> >> It allows to build a kernel using e.g. "make ARCH=m68k".
>>> >>
>>> >> Perhaps this can be moved to generic code? Most (not all!)
>>> cross-toolchains
>>> >> are called $ARCH-{unknown-,}linux{,-gnu}.
>>> >> Exceptions are e.g. am33_2.0-linux and bfin-uclinux.
>>> >
>>> > Today you can specify CROSS_COMPILE in Kconfig.
>>> > With this we should be able to remove these hacks.
>>> 
>>> The correct CROSS_COMPILE value depends on the host environment, not
>>> on the target configuration.
>> 
>> Actually it depends on _both_.
>> 
> 
> I think the important issue is not the exact dependencies of the  
> value of CROSS_COMPILE, but rather that it varies enough that  
> automatically choosing a value based on SUBARCH often gives the wrong  
> result.
> 
> Removing SUBARCH and setting CROSS_COMPILE either from the make  
> command line (or environment) or the config file, is a good idea  
> because it simplifies the build system, makes things clearer, and  
> yields more predictable results.
> 
> David Daney

Agreed. Expecting the build to guess the right $CROSS_COMPILE is like  
expecting it to guess the right $PATH. It should be specified, not  
heuristically probed.

Rob
From juhosg@openwrt.org Fri Aug 23 08:31:49 2013
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 08:31:51 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41453 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817128Ab3HWGbtUv18e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Aug 2013 08:31:49 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 3050E280826;
        Fri, 23 Aug 2013 08:31:20 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Fri, 23 Aug 2013 08:31:20 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 3/3] MIPS: ralink: mt7620: add spi clock definition
Date:   Fri, 23 Aug 2013 08:31:32 +0200
Message-Id: <1377239492-10802-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1377239492-10802-1-git-send-email-juhosg@openwrt.org>
References: <1377239492-10802-1-git-send-email-juhosg@openwrt.org>
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Content-Length: 1054
Lines: 34

From: John Crispin <blogic@openwrt.org>

Register a clock device for the SPI block of the
MT7620 SoC. The clock device will be used by the
SPI host controller driver to determine the base
clock of the controller.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Changes since v1:
  - rebase against the mips-for-linux-next branch of the
    upstream-sfr.git tree

This makes the following patch obsolete:
  https://patchwork.linux-mips.org/patch/5672/
---
 arch/mips/ralink/mt7620.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 6c37c9d..988324b 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -318,6 +318,7 @@ void __init ralink_clk_init(void)
 	ralink_clk_add("10000100.timer", periph_rate);
 	ralink_clk_add("10000120.watchdog", periph_rate);
 	ralink_clk_add("10000500.uart", periph_rate);
+	ralink_clk_add("10000b00.spi", sys_rate);
 	ralink_clk_add("10000c00.uartlite", periph_rate);
 }
 
-- 
1.7.10
