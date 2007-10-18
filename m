Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 19:46:47 +0100 (BST)
Received: from mail-out.m-online.net ([212.18.0.10]:6064 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S20043107AbXJRSqh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 19:46:37 +0100
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id D72A3224244
	for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 20:46:36 +0200 (CEST)
X-Auth-Info: dshK1/4aFMDnH1G5Mkc3L4jGRmfGCV2U2j6WAQLgxac=
Received: from mail.denx.de (p57AEF77C.dip.t-dialin.net [87.174.247.124])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id C3D9C9016E
	for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 20:46:36 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.0.0.2])
	by mail.denx.de (Postfix) with ESMTP id 4E3206D00A7
	for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 20:46:36 +0200 (CEST)
Received: from gemini.denx.de (localhost.localdomain [127.0.0.1])
	by gemini.denx.de (Postfix) with ESMTP id 48637242E9
	for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 20:46:36 +0200 (CEST)
To:	linux-mips@linux-mips.org
Subject: MIPS Makefile not picking up CROSS_COMPILE from environment setting
From:	Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
Date:	Thu, 18 Oct 2007 20:46:36 +0200
Message-Id: <20071018184636.48637242E9@gemini.denx.de>
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

Hello,

I noticed that, unlike for other architectures like ARM  or  PowerPC,
the  MIPS Makefile does not pick up the settings from a CROSS_COMPILE
environment variable, at least not with many (all?) default  configu-
rations.

This makes no sense to me - is there an intention behind it?

Or should I submit a patch  to  use  an  environment  setting  if  it
exists, i. e. somthing like this:

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 08355eb..caa04a0 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -43,7 +43,7 @@ UTS_MACHINE		:= mips64
 endif
 
 ifdef CONFIG_CROSSCOMPILE
-CROSS_COMPILE		:= $(tool-prefix)
+CROSS_COMPILE		?= $(tool-prefix)
 endif
 
 ifdef CONFIG_32BIT



Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The explanation requiring the fewest assumptions is the  most  likely
to be correct.                                    -- William of Occam
