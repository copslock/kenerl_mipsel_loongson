Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 23:52:28 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:36760
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993869AbdFWVwWV1Gx- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2017 23:52:22 +0200
Received: by mail-wr0-x241.google.com with SMTP id 77so15515388wrb.3;
        Fri, 23 Jun 2017 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+RXVjPIsqgmCOaHCcVSwih/yB0O8hlrdJPzXbUNO+oA=;
        b=vRvguOqxL068Uuy7+CjxwRB4LwKrMM4VbVuMJvzLHfUX2Hc1kNTkPj0DUSLV+MlrJV
         QL6pUhOxy+4+/p17XYyaNvpQJt3fF/9Bd3iQYUZ070cuSoIUY+Cf/uzg07Bc5Bs9LFpy
         mEkKD2CcdL4+Oz6nvvuD9isqTi9EHQtBstwXYzbLvoeX31AFieBf+j1IeHN5efOn2W20
         rGcDYVsEjdT5sYmbwUt+Yh3a0KcF7xJUpav5n6GLQFqYU7OqwDjnQvbPhSgbKGExQ7WO
         koSMV2L7va6c6ZoTGX7BNjPK9JHUnZwznZjteauARek8KTHjGu+9tLLPAW+l08UOXlE4
         gbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+RXVjPIsqgmCOaHCcVSwih/yB0O8hlrdJPzXbUNO+oA=;
        b=hAeqsjXdrn88SgkPT3RDr+qiRbXqKDROqHugFGZtQWHZ/f2vPqPZ+t2FwBQFnZVtOB
         Szm60SHIfKGl8XwUU7yzp6Snn96nZxmahszrVpn8ziol2/legJN6Hg3NsKXBMDGWUx2n
         5SIM2uYcARb9NFqCLz/aF3h87QyoIM6fB+i4rYmciVeIi+ZNamKEXFc491Jl9kHLYm0U
         dd+S1Qv2DbO8LqZfd4ogYBKeuse4hVeE+5yjXCvuf2JztuvMXnt/NoOkVCUHatFg1V0Q
         gIZmtGyzcZfH4RkBYlfH9y6PImVJgFnfiCcyhoZASdoOt3670f53VKum4WPFAmo5Ykhk
         Esvg==
X-Gm-Message-State: AKS2vOzuD9d4i+ZAQHL/TH7HrhobHLsntwzdA9cVXIYYJs/h8pphfXED
        6VhpBu/lPBntag==
X-Received: by 10.223.135.154 with SMTP id b26mr6791354wrb.48.1498254736772;
        Fri, 23 Jun 2017 14:52:16 -0700 (PDT)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id p8sm4536892wrd.57.2017.06.23.14.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 14:52:16 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] MIPS: perf: fix build failure
Date:   Fri, 23 Jun 2017 22:52:11 +0100
Message-Id: <1498254731-5248-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

The build of gpr_defconfig is failing with the error:
arch/mips/kernel/perf_event_mipsxx.c:
	In function 'mipsxx_pmu_map_raw_event':
arch/mips/kernel/perf_event_mipsxx.c:1614:2:
	error: duplicate case value

Patch - f7a31b5e7874 ("MIPS: perf: Remove incorrect odd/even counter
handling for I6400") removed the previous case and added it as a
separate case. But patch dd71e57bacb5 ("MIPS: perf: add I6500 handling")
added it back to its old location and thus giving us two duplicate case.

Fixes: dd71e57bacb5 ("MIPS: perf: add I6500 handling")
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

The build log is available at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/246092909

 arch/mips/kernel/perf_event_mipsxx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 4b93cc0..733b612 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1597,7 +1597,6 @@ static const struct mips_perf_event *mipsxx_pmu_map_raw_event(u64 config)
 		break;
 	case CPU_P5600:
 	case CPU_P6600:
-	case CPU_I6400:
 	case CPU_I6500:
 		/* 8-bit event numbers */
 		raw_id = config & 0x1ff;
-- 
1.9.1
