Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Nov 2004 15:23:30 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:7858
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8224901AbUKQPX0>; Wed, 17 Nov 2004 15:23:26 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id iAHFNHpf001574
	for <linux-mips@linux-mips.org>; Wed, 17 Nov 2004 07:23:17 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with SMTP id iAHFNHdh015831
	for <linux-mips@linux-mips.org>; Wed, 17 Nov 2004 07:23:17 -0800 (PST)
Message-ID: <006d01c4ccba$36a43110$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Linux-MIPS Mailing List" <linux-mips@linux-mips.org>
Subject: Dubious MIPS kernel SMP Structures
Date: Wed, 17 Nov 2004 16:29:21 +0100
Organization: MIPS Technologies Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

In arch/mips/kerenl/smp.c, there are two tables defined, __cpu_number_map[]
and __cpu_logical_map[], which would appear to provide forward and backward
mapping between a set of unique but arbitrary CPU numbers and a monotonically
increasing number 0..n of indices into per-CPU data.   As near as I can tell, the
only use of this is in the sb1250 code for setting up interrupt hardware.  Is there
a reason why it's defined at the mips/kernel level, and not down in the SiByte
platform subtree?  Is there a generic, architectural definition of how these mappings
should and should not be set up and used?

            Regards,

            Kevin K.
