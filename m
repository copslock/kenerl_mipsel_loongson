Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2004 18:33:20 +0100 (BST)
Received: from igw2.watson.ibm.com ([IPv6:::ffff:129.34.20.6]:32222 "EHLO
	igw2.watson.ibm.com") by linux-mips.org with ESMTP
	id <S8225009AbUGSRdQ>; Mon, 19 Jul 2004 18:33:16 +0100
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com [129.34.20.41])
	by igw2.watson.ibm.com (8.11.7-20030924/8.11.4) with ESMTP id i6JHVvW37280;
	Mon, 19 Jul 2004 13:31:58 -0400
Received: from makai.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/8.11.7-01-14-2004) with ESMTP id i6JHWxs50616;
	Mon, 19 Jul 2004 13:32:59 -0400
Received: from watson.ibm.com (localhost [127.0.0.1])
	by makai.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id i6JHWpD28554;
	Mon, 19 Jul 2004 13:32:52 -0400
Message-Id: <200407191732.i6JHWpD28554@makai.watson.ibm.com>
To: Richard Sandiford <rsandifo@redhat.com>
cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bittargets
References: <87hds49bmo.fsf@redhat.com>
Date: Mon, 19 Jul 2004 13:32:51 -0400
From: David Edelsohn <dje@watson.ibm.com>
Return-Path: <dje@watson.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dje@watson.ibm.com
Precedence: bulk
X-list: linux-mips

>>>>> Richard Sandiford writes:

> Sorry, but I don't think this is a reasonable expection for 64-bit
> shifts on 32-bit targets.  If linux insists on not using libgcc,
> it should provide:

	Other targets provide those DImode operations.

	Part of the mission of GCC is to support GNU and GNU/Linux.

David
