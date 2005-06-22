Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 00:01:56 +0100 (BST)
Received: from mms1.broadcom.com ([IPv6:::ffff:216.31.210.17]:51214 "EHLO
	MMS1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225407AbVFVXBj>; Thu, 23 Jun 2005 00:01:39 +0100
Received: from 10.10.64.121 by MMS1.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Wed, 22 Jun 2005 16:00:19 -0700
X-Server-Uuid: 146C3151-C1DE-4F71-9D02-C3BE503878DD
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 22 Jun 2005 16:00:05 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BFO30414; Wed, 22 Jun 2005 16:00:05 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id QAA01745 for <linux-mips@linux-mips.org>; Wed, 22 Jun 2005 16:00:04
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j5MN03ov008091 for <linux-mips@linux-mips.org>; Wed, 22 Jun 2005
 16:00:03 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j5MN03e17915 for linux-mips@linux-mips.org; Wed, 22 Jun 2005
 16:00:03 -0700
Date:	Wed, 22 Jun 2005 16:00:03 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [patch 0/5] SiByte fixes for 2.6.12
Message-ID: <20050622230003.GA17725@broadcom.com>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6EA732092AW2763911-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

The following series of patches address a few issues I ran into while
getting 2.6.12 running on Swarm.  Some of them are questionable, for
example [3/5] is only an issue because of the oldish toolchain I happen
to be using at the moment.

Also, Ralf, do you like these quilt-style patchbombs or do you prefer
another submission format?

-andy
