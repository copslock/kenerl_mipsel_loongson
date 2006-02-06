Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 21:49:47 +0000 (GMT)
Received: from [64.215.88.90] ([64.215.88.90]:50503 "EHLO email.vitesse.com")
	by ftp.linux-mips.org with ESMTP id S3458325AbWBFVtY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Feb 2006 21:49:24 +0000
Received: from wilson.vitesse.com (wilson [10.9.72.71])
	by email.vitesse.com (8.11.0/8.11.0) with ESMTP id k16Ls2h24377
	for <linux-mips@linux-mips.org>; Mon, 6 Feb 2006 13:54:02 -0800 (PST)
Received: from MX-COS.vsc.vitesse.com (mx-cs1 [10.9.72.41])
	by wilson.vitesse.com (8.11.6/8.11.6) with ESMTP id k16Ls6b06925
	for <linux-mips@linux-mips.org>; Mon, 6 Feb 2006 14:54:07 -0700 (MST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
Subject: oprofile gets only kernel samples?
Date:	Mon, 6 Feb 2006 14:54:00 -0700
Message-ID: <389E6A416914954182ECDFCD844D8269434D89@MX-COS.vsc.vitesse.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: oprofile gets only kernel samples?
Thread-Index: AcYrZ9Y+7vt2h705RpmPJBZLmay+PA==
From:	"Kurt Schwemmer" <kurts@vitesse.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kurts@vitesse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kurts@vitesse.com
Precedence: bulk
X-list: linux-mips

I've got oprofile working sort of with 2.6.15 kernel on a 24Kc processor
using just timer interrupts. I only get samples within vmlinux.out
though. When I look at top output during the period of time there is
definitely some significant user mode time. Before digging too deep into
the problem I thought I'd ask to see if this is a known limitation and
if everyone is seeing this.

Thanks,
Kurt Schwemmer
