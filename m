Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2007 11:33:44 +0100 (BST)
Received: from cruel.tal.org ([195.16.220.85]:1676 "EHLO netra-ax.tal.org")
	by ftp.linux-mips.org with ESMTP id S20024008AbXI1Kdf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Sep 2007 11:33:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by netra-ax.tal.org (Postfix) with ESMTP id 3E5493466B
	for <linux-mips@linux-mips.org>; Fri, 28 Sep 2007 13:58:06 +0300 (EEST)
Received: from netra-ax.tal.org ([127.0.0.1])
 by localhost (netra-ax.tal.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23991-01 for <linux-mips@linux-mips.org>;
 Fri, 28 Sep 2007 13:58:05 +0300 (EEST)
Received: from concertina (unknown [195.16.220.84])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by netra-ax.tal.org (Postfix) with ESMTP id 28C3934658
	for <linux-mips@linux-mips.org>; Fri, 28 Sep 2007 13:58:05 +0300 (EEST)
Message-ID: <003b01c801bb$00222910$54dc10c3@tal.org>
From:	"Kaj-Michael Lang" <milang@tal.org>
To:	<linux-mips@linux-mips.org>
References: <1190973427.11251.17.camel@scarafaggio>
Subject: Re: Tests of 2.6.23-rc8 on SGI O2
Date:	Fri, 28 Sep 2007 13:33:22 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
X-Virus-Scanned: amavisd-new at tal.org
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

> B. recompiling with 8mb of frame buffer give an unusable display and
> fill my syslog of these messages:

This is nothing new, use 4mb.

-- 
Kaj-Michael Lang
