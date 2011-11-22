Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 04:29:15 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:48608 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903657Ab1KVD3H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2011 04:29:07 +0100
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id pAM3Sxu7016653;
        Mon, 21 Nov 2011 19:29:00 -0800
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Mon, 21 Nov 2011
 19:28:57 -0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <eyal@mips.com>, <zenon@mips.com>, Deng-Cheng Zhu <dczhu@mips.com>
Subject: [PATCH v2 0/5] MIPS/Perf-events & perf: Event init related fixes
Date:   Tue, 22 Nov 2011 11:28:44 +0800
Message-ID: <1321932528-21098-1-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: T2dmpI1ns1bDhGKXu4Z2uA==
X-archive-position: 31912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18204

As patch names suggest, this series contains various fixes for event init,
in especial, event state related fixes.

Changes:
v2 - v1:
o Patch series name changed from "MIPS/Perf-events: Functional fixes and
  cleanups".
o Instead of updating the map of unsupported events for 74K, don't do
  validation on raw events for all cores.
o Remove pmu and event state checking in validate_event(), and in fact,
  replace this funciton with counter allocation.
o Enable siblings (those marked enable-on-exec) when group leader is
  enabled on exec.

Deng-Cheng Zhu (5):
  MIPS/Perf-events: Don't do validation on raw events
  MIPS/Perf-events: Remove erroneous check on active_events
  MIPS/Perf-events: Remove pmu and event state checking in
    validate_event()
  MIPS/Perf-events: Cleanup event->destroy at event init
  perf: Enable applicable siblings when group leader is enable-on-exec

 arch/mips/kernel/perf_event_mipsxx.c |   72 +++++----------------------------
 kernel/events/core.c                 |    3 +
 2 files changed, 14 insertions(+), 61 deletions(-)
