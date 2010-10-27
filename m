Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2010 13:00:21 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:49473 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490981Ab0J0K7l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Oct 2010 12:59:41 +0200
Received: by mail-iw0-f177.google.com with SMTP id 8so689267iwn.36
        for <multiple recipients>; Wed, 27 Oct 2010 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=89Ra+q8i3BiFYY6kO5x7RYMNX9UroKGk5vRPjCN0dD8=;
        b=RwsqqaVzjCEux91SWIfsG9sbMgimfYt0ycDeW6NsK0hPYo9AtHK/JA4iFEIMAXeX7P
         uApjbGe3l7FlXbINBjDXdEeW5joIGrIZJUSMlPLbdB9+gefjFaoo878rT+CVdtmWtkEP
         fSDmjnkIQYEgTddiZUI45oSXO+E+qgxVq5nwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GyC/U5cPmue49QujTduDsDVpaKNa+BknOqmC2PfAh9XbjQngqFzR2Vpxk2hvPltrnd
         2imUbwVXIh/kpzwONH+tZ9X6Mmh/0BdQffn7lBLFTMyzGgC/eV2v/JxSkBIYNvIs6a+v
         HV+mGR48pfli8GXFqmxKGgVsWOAIi1ToScAms=
Received: by 10.231.30.74 with SMTP id t10mr8299894ibc.171.1288177180633;
        Wed, 27 Oct 2010 03:59:40 -0700 (PDT)
Received: from localhost.localdomain ([61.48.71.2])
        by mx.google.com with ESMTPS id u6sm10943197ibd.12.2010.10.27.03.59.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 03:59:40 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     John Reiser <jreiser@bitwagon.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 3/3] ftrace/MIPS: Enable C Version of recordmcount
Date:   Wed, 27 Oct 2010 18:59:09 +0800
Message-Id: <bb99009a9ac79d3f55a8c8bf1c8bd2bc0e1f160e.1288176026.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1288176026.git.wuzhangjin@gmail.com>
References: <cover.1288176026.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1288176026.git.wuzhangjin@gmail.com>
References: <cover.1288176026.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Selects HAVE_C_RECORDMCOUNT to use the C version of the recordmcount
intead of the old Perl Version of recordmcount.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 46cae2b..144e4b3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -9,6 +9,7 @@ config MIPS
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_C_RECORDMCOUNT
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
-- 
1.7.1
