Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 14:50:20 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56161 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903720Ab1KVNtm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2011 14:49:42 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAMDmx8f015229;
        Tue, 22 Nov 2011 13:48:59 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAMDmxBS015228;
        Tue, 22 Nov 2011 13:48:59 GMT
Date:   Tue, 22 Nov 2011 13:48:59 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Deng-Cheng Zhu <dczhu@mips.com>
Cc:     linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 3/5] MIPS/Perf-events: Remove pmu and event state
 checking in validate_event()
Message-ID: <20111122134859.GC12578@linux-mips.org>
References: <1321932528-21098-1-git-send-email-dczhu@mips.com>
 <1321932528-21098-4-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1321932528-21098-4-git-send-email-dczhu@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18578

Queued for 3.3.  Thanks,

  Ralf
