Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2017 02:06:39 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:34444
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993201AbdCQBGciNdeD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2017 02:06:32 +0100
Received: by mail-qt0-x243.google.com with SMTP id x35so7877202qtc.1;
        Thu, 16 Mar 2017 18:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+ulTr1LcqEt8VKZrauEudLMRw4flvk07UEDHqoYa7Xw=;
        b=bkTezDtgRGFPgW0Yg6KW2krg8k2NNNQeNhBJlrMZSp6/4V31iwioZCRUL32nPVU4cL
         D8OO8DZPWcEp7hzrOqD/LF524gP66wA45IHc6AHrtzO4ekZTQ7IFS5XO5WUS+rskxGf6
         RC+g1vI9XPv/PWeLF4GhKjk4ZpiH5q37b15NVpyfFL5NOledjt6QSjYPC+Pmvr4sV3By
         4Bu1UgRWiTQFy8/BJRsmcK82wCKoYqXQCUOW6vkQBnMuvoX5lflyMbygiucIYdTrp89d
         Nr9kQS/Tsyvu9b7m8qhxhWNFsCZxTAZhxz/u43DCQs9gCWePonilHUiHOjb+sI1n/vm6
         LhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+ulTr1LcqEt8VKZrauEudLMRw4flvk07UEDHqoYa7Xw=;
        b=aJ7CAjdFTlppvLEeANIADB9QNxtVOCDC9aTp0cGxqig9j+1p/THK4QlwN7CvpCSnsp
         x/i8Yytv629CjaFXVJmqKEH9HBsQsKLMy8gI3ic1Nox0RhMtPPNd/jUZWi8LL4UP3vB5
         bzrCUmMR2Kr7AHeffPl+rtT6Knde8Mh7Td/52RDl1w5MxBn0rgV58m1XNc2Vn3iXOyOy
         nTkgpvQBRZsaD09fkHpUdzasaPjFKb5DBk8CkJvlNdyL9OngGde0jaEKuRbp/Ya4fwx+
         9Fu/s7FUYVQ3Cxc1JLETtFxaJZw7NTI8SsJg4A5UqhtvA4oOd2lEdtxZEEtsmN63HbKs
         INJg==
X-Gm-Message-State: AFeK/H1lT0DqRiwANNSalM9MKn4AS7meyb0O7KH9SNvDCtkPHpuXtiUus+aE62baqkZAwA==
X-Received: by 10.200.36.194 with SMTP id t2mr11686252qtt.61.1489712786810;
        Thu, 16 Mar 2017 18:06:26 -0700 (PDT)
Received: from fainelli-desktop.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id n130sm4860775qkn.4.2017.03.16.18.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2017 18:06:25 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, james.hogan@imgtec.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MIPS: Disable Werror when W= is set
Date:   Thu, 16 Mar 2017 18:06:12 -0700
Message-Id: <20170317010612.11990-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.9.3
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Using any value for W= will lead to a ton of warnings which are turned
into fatal errors because MIPS adds -Werror to arch/mips/*.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/Kbuild | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index 5c3f688a5232..5cef58651db0 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -1,7 +1,9 @@
 # Fail on warnings - also for files referenced in subdirs
 # -Werror can be disabled for specific files using:
 # CFLAGS_<file.o> := -Wno-error
+ifeq ($(W),)
 subdir-ccflags-y := -Werror
+endif
 
 # platform specific definitions
 include arch/mips/Kbuild.platforms
-- 
2.9.3
