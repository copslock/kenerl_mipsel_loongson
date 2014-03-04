Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2014 22:07:40 +0100 (CET)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44422 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822315AbaCDVHjAFKxL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Mar 2014 22:07:39 +0100
Received: by mail-ie0-f171.google.com with SMTP id ar20so112005iec.16
        for <linux-mips@linux-mips.org>; Tue, 04 Mar 2014 13:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=jDm/9v+Pwe5j6Yd43IIhyAJ3wfAnVhFxnhB3KFJtD8w=;
        b=NPtpzmLrXloYkiDkknXl71xM5L/vzTS5POhq+lhaEhyRv5C4p+oYgrvBqPJHPtkkLX
         AQ4y1my2V992n52DHON3/eb4HVAxbOMMm/aXezCQnOCtEP22Hqzrh+Jfsg5j4WwNi90o
         5eNjrBFKOz+DO9loE+Otbua9e6iAcOV4SCSv4hBbJB6SMwrkENmb5XYFKg+tK6kzLHOF
         LY9T5cIUGA97cQnzdgvGELiHzKgmgODgboG54VwOVdrXJvgk/NM0qT6ZKTtkCi7BD/26
         xmosei/t6g+dtdLS+oCfpNIayVt9d6dqrK86z50exVTc/TD1ZDM8N8dlCNX0dYERjB6J
         aZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=jDm/9v+Pwe5j6Yd43IIhyAJ3wfAnVhFxnhB3KFJtD8w=;
        b=NKmbP6sd2TDVoc8BSvHn0ERy0D9ob0XHDYXZM6H1BAb32ALUXQ/+b2cBHaaxXUxRTF
         RA+sDCV6UGKKCqd4MfPTOw1gdegJ5Yp213KOpyAJ7kI+jwt/sCP9Caprho3l0NpYVpKV
         qmF5TJe651KtYQvQA78cGbWhu3wQWA98sLdE/NZhNUenw5h9aGeO47Of3qHtkMWk44Vg
         N+7MfAboiWLNfEMbVgQJGvHGeTWFJwN94Ql3yWxxxRcUwNSImJ9WzlLBFQPqvd/iSkKs
         /h5R52jxWDWgMaqVQ/O8UStQH59NBdooTK/2GkHiA2mg4mzyGZb6pP7NbG8KZqzwAzfD
         DQPQ==
X-Gm-Message-State: ALoCoQlGUJbjjfV1aR9GSePz4v7aE2G2/oVDQlCSLtkeFX4llQnaYEjXB/SOtPW/z3XtAIRVFAORPVZu1RAYB0BlND53t3Z6LivztkXnR3zEOdQ1rmHWaIfyQsCKgMpbUSReug6jh4O7OLpSlgWMatnPhsW0nFG0nye2N0Q5jl4U4UlXOJrClYDP/MaSkmPJ0MDycqDGE2cIDsyVl4A8QIiy0XI+FF7lwQ==
X-Received: by 10.43.129.70 with SMTP id hh6mr1547114icc.68.1393967252639;
        Tue, 04 Mar 2014 13:07:32 -0800 (PST)
Received: from localhost ([172.16.49.180])
        by mx.google.com with ESMTPSA id ai4sm53562251igd.3.2014.03.04.13.07.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Mar 2014 13:07:32 -0800 (PST)
Subject: [PATCH 0/2] sched: Removed unused mc_capable() and smt_capable()
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 04 Mar 2014 14:07:31 -0700
Message-ID: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

This is just cleanup of a couple unused interfaces and (for sparc64) a
supporting variable.

---

Bjorn Helgaas (2):
      sched: Remove unused mc_capable() and smt_capable()
      sparc64: Remove unused sparc64_multi_core


 arch/arm/include/asm/topology.h      |    3 ---
 arch/ia64/include/asm/topology.h     |    1 -
 arch/mips/include/asm/topology.h     |    4 ----
 arch/powerpc/include/asm/topology.h  |    1 -
 arch/sparc/include/asm/smp_64.h      |    1 -
 arch/sparc/include/asm/topology_64.h |    2 --
 arch/sparc/kernel/mdesc.c            |    4 ----
 arch/sparc/kernel/prom_64.c          |    3 ---
 arch/sparc/kernel/smp_64.c           |    2 --
 arch/x86/include/asm/topology.h      |    6 ------
 10 files changed, 27 deletions(-)
