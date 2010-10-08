Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 23:48:14 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6291 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491757Ab0JHVsH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 23:48:07 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4caf91b70000>; Fri, 08 Oct 2010 14:48:39 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 8 Oct 2010 14:48:14 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 8 Oct 2010 14:48:14 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o98Llwhn023134;
        Fri, 8 Oct 2010 14:47:58 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o98LlsTI023133;
        Fri, 8 Oct 2010 14:47:54 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org, gregkh@suse.de,
        dbrownell@users.sourceforge.net
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/3] usb: Add OCTEON II USB support.
Date:   Fri,  8 Oct 2010 14:47:50 -0700
Message-Id: <1286574473-23098-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 08 Oct 2010 21:48:14.0401 (UTC) FILETIME=[82671310:01CB6732]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The OCTEON II (CN63XX) is a new member of Cavium Networks' family of
mips64 based SOCs.  These parts have an integrated EHCI/OHCI USB host
controller.  As implied in the subject, this patch set adds the
necessary glue code to connect this hardware to the standard EHCI and
OHCI drivers.

There are two sets of prerequisite patches that are pending that
should be merged via Ralf's linux-mips.org tree.  If these are OK, it
might make sense to either merge via Ralf's tree, or coordinate with
him as to maintain the dependencies between the various patches.

See:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1285964854-28659-1-git-send-email-ddaney%40caviumnetworks.com
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1286492633-26885-1-git-send-email-ddaney%40caviumnetworks.com

David Daney (3):
  MIPS: Octeon: Add register definitions for ehci/ohci USB glue logic.
  usb: Add EHCI and OHCH glue for OCTEON II SOCs.
  MIPS: Add platform device and Kconfig for Octeon USB EHCI/OHCI

 arch/mips/Kconfig                              |    2 +
 arch/mips/cavium-octeon/octeon-platform.c      |  105 ++++++++++-
 arch/mips/include/asm/octeon/cvmx-uctlx-defs.h |  261 ++++++++++++++++++++++++
 drivers/usb/host/Kconfig                       |   27 +++-
 drivers/usb/host/Makefile                      |    1 +
 drivers/usb/host/ehci-hcd.c                    |    5 +
 drivers/usb/host/ehci-octeon.c                 |  207 +++++++++++++++++++
 drivers/usb/host/octeon2-common.c              |  185 +++++++++++++++++
 drivers/usb/host/ohci-hcd.c                    |    5 +
 drivers/usb/host/ohci-octeon.c                 |  214 +++++++++++++++++++
 10 files changed, 1010 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-uctlx-defs.h
 create mode 100644 drivers/usb/host/ehci-octeon.c
 create mode 100644 drivers/usb/host/octeon2-common.c
 create mode 100644 drivers/usb/host/ohci-octeon.c

-- 
1.7.2.3
