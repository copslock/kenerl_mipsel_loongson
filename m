Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2003 05:06:57 +0100 (BST)
Received: from zok.SGI.COM ([IPv6:::ffff:204.94.215.101]:3761 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225073AbTD3EGy>;
	Wed, 30 Apr 2003 05:06:54 +0100
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.9/8.12.2/linux-outbound_gateway-1.2) with SMTP id h3U46jVV001946;
	Tue, 29 Apr 2003 21:06:46 -0700
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA06308; Wed, 30 Apr 2003 14:06:44 +1000
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id 618023000B8; Wed, 30 Apr 2003 14:06:43 +1000 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP
	id 402C0178; Wed, 30 Apr 2003 14:06:43 +1000 (EST)
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: "Michael Anburaj" <michaelanburaj@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board 
In-reply-to: Your message of "Tue, 29 Apr 2003 21:00:52 MST."
             <BAY1-F107QuhhqeOhFm0001075c@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 Apr 2003 14:06:38 +1000
Message-ID: <10105.1051675598@kao2.melbourne.sgi.com>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Tue, 29 Apr 2003 21:00:52 -0700, 
"Michael Anburaj" <michaelanburaj@hotmail.com> wrote:
>./tkparse < ../arch/mips/config.in >> kconfig.tk
>arch/mips/config-shared.in: 482: unterminated quoted string

--- arch/mips/config-shared.in.orig	Fri Nov 29 11:39:05 2002
+++ arch/mips/config-shared.in	Wed Apr 30 14:05:51 2003
@@ -479,7 +479,7 @@
 if [ "$CONFIG_CPU_SB1" = "y" ]; then
    choice 'SB1 Pass' \
 	 "Pass1   CONFIG_CPU_SB1_PASS_1  \
-	  Pass2   CONFIG_CPU_SB1_PASS_2
+	  Pass2   CONFIG_CPU_SB1_PASS_2  \
 	  Pass2.2 CONFIG_CPU_SB1_PASS_2_2" Pass1
    if [ "$CONFIG_CPU_SB1_PASS_1" = "y" ]; then
       define_bool CONFIG_SB1_PASS_1_WORKAROUNDS y
