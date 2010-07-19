Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2010 06:00:39 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:50841 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491897Ab0GSEAd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jul 2010 06:00:33 +0200
Received: from localhost.localdomain (87-194-206-159.bethere.co.uk [87.194.206.159])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 86B471B4008;
        Mon, 19 Jul 2010 04:00:24 +0000 (UTC)
From:   Ricardo Mendoza <ricmm@gentoo.org>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 0/2] MIPS: RM7000: Tertiary cache support 
Date:   Mon, 19 Jul 2010 04:59:58 +0100
Message-Id: <1279512000-9154-1-git-send-email-ricmm@gentoo.org>
X-Mailer: git-send-email 1.6.4.4
Return-Path: <ricmm@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@gentoo.org
Precedence: bulk
X-list: linux-mips

Ricardo Mendoza (2):
 MIPS: RM7000: Make use of cache_op() instead of inline asm
 MIPS: RM7000: Add support for tertiary cache
 
arch/mips/include/asm/cacheops.h |    2 +
arch/mips/mm/sc-rm7k.c           |  161 ++++++++++++++++++++++++++++++--------
 2 files changed, 131 insertions(+), 32 deletions(-)
