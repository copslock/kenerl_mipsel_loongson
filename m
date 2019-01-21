Return-Path: <SRS0=dr9w=P5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADA3C2F3BE
	for <linux-mips@archiver.kernel.org>; Mon, 21 Jan 2019 14:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3166214D8
	for <linux-mips@archiver.kernel.org>; Mon, 21 Jan 2019 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079317;
	bh=Xj2hA8l76MUL2lu3JGc48D+uz2I4VUOLs2KZNcHR73U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2aenc3pvI6S37FNGEFwwP96UZbqzukY6QWLeKmPCVlZ/WlpsdUTjmrQuqoizPQRus
	 KyEs++EelAotAlQ3hzrBtfVPpJvyO5luxAAi99bTlk9FNoE92EgWVYzVJ4JEjk0uOc
	 sg37i+NTpWmgXjt2GTktOLWWlGbXRSpWo4yPLpqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbfAUOB5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732257AbfAUOB5 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 21 Jan 2019 09:01:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED50F2089F;
        Mon, 21 Jan 2019 14:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079316;
        bh=Xj2hA8l76MUL2lu3JGc48D+uz2I4VUOLs2KZNcHR73U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1XkWVzAU/rwG1cRMAuEWz6t4qCeHa6ED4Myf4zSMOnX731Cmzj09XBBPL0GLncZia
         vxQzk4k6bUMhGebgjEmgvXcxI+WsHhdYKMLgRWT+SgEJoMZ5Z4Sz0mc5FsbCHji/Or
         ONecLIqGKA241GiQTl2Ls6KsNZ/ZRe3q8C4zv5vA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.19 45/99] mips: fix n32 compat_ipc_parse_version
Date:   Mon, 21 Jan 2019 14:48:37 +0100
Message-Id: <20190121134915.683413255@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 5a9372f751b5350e0ce3d2ee91832f1feae2c2e5 upstream.

While reading through the sysvipc implementation, I noticed that the n32
semctl/shmctl/msgctl system calls behave differently based on whether
o32 support is enabled or not: Without o32, the IPC_64 flag passed by
user space is rejected but calls without that flag get IPC_64 behavior.

As far as I can tell, this was inadvertently changed by a cleanup patch
but never noticed by anyone, possibly nobody has tried using sysvipc
on n32 after linux-3.19.

Change it back to the old behavior now.

Fixes: 78aaf956ba3a ("MIPS: Compat: Fix build error if CONFIG_MIPS32_COMPAT but no compat ABI.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: stable@vger.kernel.org # 3.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3149,6 +3149,7 @@ config MIPS32_O32
 config MIPS32_N32
 	bool "Kernel support for n32 binaries"
 	depends on 64BIT
+	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select COMPAT
 	select MIPS32_COMPAT
 	select SYSVIPC_COMPAT if SYSVIPC


