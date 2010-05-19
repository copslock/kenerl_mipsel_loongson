Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 May 2010 23:18:07 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:18933 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491985Ab0ESVRM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 May 2010 23:17:12 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bf455660005>; Wed, 19 May 2010 14:17:26 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 19 May 2010 14:16:38 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 19 May 2010 14:16:37 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o4JLGZWd010227;
        Wed, 19 May 2010 14:16:35 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o4JLGYuO010226;
        Wed, 19 May 2010 14:16:34 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] A couple of Octeon serial port improvements.
Date:   Wed, 19 May 2010 14:16:30 -0700
Message-Id: <1274303792-10190-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 19 May 2010 21:16:37.0998 (UTC) FILETIME=[916670E0:01CAF798]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Please consider for 2.6.35.

David Daney (2):
  MIPS: Octeon: Get rid of early serial.
  MIPS: Octeon: Serial port fixes for OCTEON simulator.

 arch/mips/cavium-octeon/serial.c |    6 +++++-
 arch/mips/cavium-octeon/setup.c  |   27 +--------------------------
 2 files changed, 6 insertions(+), 27 deletions(-)
