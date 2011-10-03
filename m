Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2011 22:27:55 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7697 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491905Ab1JCU1s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Oct 2011 22:27:48 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e8a1b080000>; Mon, 03 Oct 2011 13:28:56 -0700
Received: from casmarthost.caveonetworks.com ([192.168.16.225]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 3 Oct 2011 13:27:39 -0700
Received: from localhost (webpowersw-sdk106.caveonetworks.com [10.18.162.106])
        by casmarthost.caveonetworks.com (8.13.8/8.13.8) with ESMTP id p93KRbQm016177;
        Mon, 3 Oct 2011 13:27:39 -0700
From:   Venkat Subbiah <venkat.subbiah@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-rt-users@vger.kernel.org, david.daney@cavium.com
Subject: 0001-MIPS-Octeon-Mark-SMP-IPI-interrupt-as-IRQF_NO_THREAD.patch
Date:   Mon,  3 Oct 2011 13:26:44 -0700
Message-Id: <1317673604-10554-1-git-send-email-venkat.subbiah@caviumnetworks.com>
X-Mailer: git-send-email 1.7.0.4
X-OriginalArrivalTime: 03 Oct 2011 20:27:40.0095 (UTC) FILETIME=[E5A484F0:01CC820A]
X-archive-position: 31203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: venkat.subbiah@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1513

