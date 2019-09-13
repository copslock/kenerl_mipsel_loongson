Return-Path: <SRS0=SIfr=XI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AE7C4CEC5
	for <linux-mips@archiver.kernel.org>; Fri, 13 Sep 2019 12:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA6D2089F
	for <linux-mips@archiver.kernel.org>; Fri, 13 Sep 2019 12:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="jJ+eu/Af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfIMMCZ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:02:25 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:23364 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfIMMCZ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 13 Sep 2019 08:02:25 -0400
Date:   Fri, 13 Sep 2019 12:02:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in;
        s=protonmail; t=1568376141;
        bh=W3A0sUxI2ZwZRVFK2SWzwum8eVXrjroeUR/zfFc53pk=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=jJ+eu/Afitsuhg4plFh48zDEIUX36zxds2JKta2gru2EIATY8hCyoj4gM4IEfWVvP
         /91bm2RKcpB037gZOfWD47tqmDzIkz0YaTKyxbptgfXeSLqIORwuwOXZV36JojnKcT
         GQYSBlhTpr9w7GGsiDQNssnmzlLEhNJtFLDlMJPM=
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        alexios.zavras@intel.com, gregkh@linuxfoundation.org,
        armijn@tjaldur.nl, allison@lohutok.net, tglx@linutronix.de
From:   Aurabindo Jayamohanan <mail@aurabindo.in>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: [PATCH] mips: check for dsp presence only once before save/restore
Message-ID: <20190913120206.9234-1-mail@aurabindo.in>
Feedback-ID: D1Wwva8zb0UdpJtanaReRLGO3iCsewpGmDn8ZDKmpao-Gnxd2qXPmwwrSQ99r5Q15lmK-D8x6vKzqhUKCgzweA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

{save,restore}_dsp() internally checks if the cpu has dsp support.
Therefore, explicit check is not required before calling them in
{save,restore}_processor_state()

Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
---
 arch/mips/power/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/power/cpu.c b/arch/mips/power/cpu.c
index 3340a5530de3..a15e29dfc7b3 100644
--- a/arch/mips/power/cpu.c
+++ b/arch/mips/power/cpu.c
@@ -19,8 +19,8 @@ void save_processor_state(void)
=20
 =09if (is_fpu_owner())
 =09=09save_fp(current);
-=09if (cpu_has_dsp)
-=09=09save_dsp(current);
+
+=09save_dsp(current);
 }
=20
 void restore_processor_state(void)
@@ -29,8 +29,8 @@ void restore_processor_state(void)
=20
 =09if (is_fpu_owner())
 =09=09restore_fp(current);
-=09if (cpu_has_dsp)
-=09=09restore_dsp(current);
+
+=09restore_dsp(current);
 }
=20
 int pfn_is_nosave(unsigned long pfn)
--=20
2.23.0


