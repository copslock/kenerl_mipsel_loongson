Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2011 12:56:33 +0200 (CEST)
Received: from dns1.mips.com ([12.201.5.69]:55724 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491062Ab1JXK40 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2011 12:56:26 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id p9OAuJSq011249;
        Mon, 24 Oct 2011 03:56:19 -0700
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Mon, 24 Oct 2011
 03:56:13 -0700
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Deng-Cheng Zhu <dczhu@mips.com>
Subject: [PATCH 0/4] MIPS/Perf-events: Functional fixes and cleanups
Date:   Mon, 24 Oct 2011 18:55:58 +0800
Message-ID: <1319453762-12962-1-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: ljM6YtvbE61SPTB3L19ZVA==
X-archive-position: 31286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17066

As patch names suggest, this series contains various fixes and does a
slight cleanup.

Deng-Cheng Zhu (4):
  MIPS/Perf-events: update the map of unsupported events for 74K
  MIPS/Perf-events: remove erroneous check on active_events
  MIPS/Perf-events: temporarily connect event to its pmu at event init
  MIPS/Perf-events: Cleanup event->destroy at event init

 arch/mips/kernel/perf_event.c        |   11 +---------
 arch/mips/kernel/perf_event_mipsxx.c |   35 ++++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 20 deletions(-)
