Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 20:04:04 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45335 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010194AbaI3SBgpyCWp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 20:01:36 +0200
Received: by mail-pa0-f42.google.com with SMTP id et14so2234355pad.15
        for <linux-mips@linux-mips.org>; Tue, 30 Sep 2014 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ChZnLayeWlzfu0earURMuL+E2RpUnLMpjWI/Gv4Oi/c=;
        b=vLOqm+bo/43K2m6Sc90847V+Q0Mu/dGfyC2bccvslqatGbMF1pWdHuIqko6vVbGq8o
         uETNyjPX9e5MpjpKeENBWJOFhR6cFfZAo5aViNaaDBi1lh3yyKLHDF7mkqk3A6gU2Y0p
         gw+1zLmjA1x1NigkzwBPHGPqkyxHPG6qHNuAWBx+ZWSFMS20/EAw9bkW4MEbw0J8stLq
         ALeFzIvOY+MFrL/Qlbtv4NyOOJg2zZ+jjsJU/gPtbv8hNW5SLa+QSOL5AczI6V4SuMZ3
         FOE6GsThSJUZi9/OufYP83YRpO6gyOCnlRcepTvxnbzs6DDECqIbqZ6IuTLWTuEFwNzc
         zdjg==
X-Received: by 10.66.220.230 with SMTP id pz6mr70413698pac.145.1412100090693;
        Tue, 30 Sep 2014 11:01:30 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id js7sm15716457pbc.62.2014.09.30.11.01.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 11:01:30 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>,
        James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH 09/16] metag: support poweroff through poweroff handler call chain
Date:   Tue, 30 Sep 2014 11:00:49 -0700
Message-Id: <1412100056-15517-10-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

The kernel core now supports a poweroff handler call chain
to remove power from the system. Call it if pm_power_off
is set to NULL.

Cc: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/metag/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/metag/kernel/process.c b/arch/metag/kernel/process.c
index 483dff9..ff7f3eb 100644
--- a/arch/metag/kernel/process.c
+++ b/arch/metag/kernel/process.c
@@ -92,6 +92,8 @@ void machine_power_off(void)
 {
 	if (pm_power_off)
 		pm_power_off();
+	else
+		do_kernel_poweroff();
 	smp_send_stop();
 	hard_processor_halt(HALT_OK);
 }
-- 
1.9.1
