Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2018 10:36:08 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:38807
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992521AbeAaJgBjhzSg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Jan 2018 10:36:01 +0100
Received: by mail-lf0-x242.google.com with SMTP id g72so19642015lfg.5;
        Wed, 31 Jan 2018 01:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jDzlcpVFk7OXsYU+IfebtyRXCSR6oRak4MeeuJDJvUA=;
        b=gMdltwwfeLpr6aRIaT3EsW/GSmVMdjvQDwxc+1bb8H9wBU0zgXfy3XA9V1yNzrhSCe
         JGYunLq8S6eWk+MfB6eHXArK30TG0+QBmQfqtRCdZxxuMRb4KUncRDm6jI2d0venENOi
         TIn8/2u8HtASREXRoy3GBRB5+rH8eMwqSbsxxSqtHTqNEUVhIJsf/4BWXVvOuhVmBQlP
         0mjACoEplwXY2kfEOMhOBoF7L72IWRacZvexWMBDl47u65LYF3bLMeK4IN2ahx1ekhNV
         VUA1KQiag3GxM0rUZ+7fAF25gfCuvtB5m2pwgxzR+4wGcsQS9Ate3NCOMAvZnpVw/y1V
         sBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jDzlcpVFk7OXsYU+IfebtyRXCSR6oRak4MeeuJDJvUA=;
        b=lmEOmjFyCZRmERfQ6LFNRQXQL9gDP0JxhonIdMolrFfGLyBqoiJMEpvXKlQ7lH+iS1
         POmjWziZB5tsmLXMzBrTa5pWpMtcntfhNVpIXNIkp0y4o+NsZvL8V/OxYiL73ZBaSVIj
         CSxfsHQADI1roxpYE+0+rI4drS6DNAlOsmNncTwWG36514VWX7BjwLbUl1zeZWJVclGv
         Jy3+Qj2tTs0m3gSRjXbmGhv+yTNryA9nei41gsijDQQyCfSi2j5dInswa+RMttgPljZl
         wpXsKRrsvQevI2xXA/5jWGeAthKvEWumrLnLbSZFLkXFrGrwChDp0K7PPfa+wj4DpEFk
         A/fQ==
X-Gm-Message-State: AKwxytcbzgchPnh6cMI34fB12QO6fTpj3eyBCm92iKrKDUq5Q6FLiKnS
        toHXiMf5ZPYlo94tOralWBs=
X-Google-Smtp-Source: AH8x224KAsqXxv+m3CWYbwSGVhtVWGtr9RuZxGqK5YdQLBV6TyZgA5/HSEvsVUZXuPfOAfBxcXL+IQ==
X-Received: by 10.46.115.9 with SMTP id o9mr6985428ljc.89.1517391356043;
        Wed, 31 Jan 2018 01:35:56 -0800 (PST)
Received: from huvuddator.lan (ua-213-113-106-221.cust.bredbandsbolaget.se. [213.113.106.221])
        by smtp.gmail.com with ESMTPSA id i18sm3155604ljd.27.2018.01.31.01.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 01:35:55 -0800 (PST)
From:   Ulf Magnusson <ulfalizer@gmail.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, rdunlap@infradead.org, dan.carpenter@oracle.com,
        pebolle@tiscali.nl, Ulf Magnusson <ulfalizer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/11] MIPS: BCM63XX: kconfig: Remove blank help text
Date:   Wed, 31 Jan 2018 10:34:26 +0100
Message-Id: <20180131093434.20050-8-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180131093434.20050-1-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
Return-Path: <ulfalizer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulfalizer@gmail.com
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

Blank help texts are probably either a typo, a Kconfig misunderstanding,
or some kind of half-committing to adding a help text (in which case a
TODO comment would be clearer, if the help text really can't be added
right away).

Best to remove them, IMO.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/mips/bcm63xx/boards/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/bcm63xx/boards/Kconfig b/arch/mips/bcm63xx/boards/Kconfig
index 6ff0a7481081..f60d96610ace 100644
--- a/arch/mips/bcm63xx/boards/Kconfig
+++ b/arch/mips/bcm63xx/boards/Kconfig
@@ -7,6 +7,5 @@ choice
 config BOARD_BCM963XX
        bool "Generic Broadcom 963xx boards"
 	select SSB
-       help
 
 endchoice
-- 
2.14.1
