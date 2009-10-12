Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 23:57:35 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:50553 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493530AbZJLV52 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Oct 2009 23:57:28 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n9CLvDng029171
	for <linux-mips@linux-mips.org>; Mon, 12 Oct 2009 14:57:15 -0700
Received: from linux-chris2 ([192.168.65.41]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 Oct 2009 14:57:13 -0700
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by linux-chris2 with esmtp (Exim 4.69)
	(envelope-from <chris@mips.com>)
	id 1MxStF-0007uX-AC; Mon, 12 Oct 2009 14:57:13 -0700
From:	Chris Dearman <chris@mips.com>
Subject: Re: [PATCH] Fix absd emulation
To:	linux-mips@linux-mips.org
Date:	Mon, 12 Oct 2009 14:57:13 -0700
Message-ID: <20091012215522.30362.49399.stgit@localhost.localdomain>
In-Reply-To: <20091012161556.GA21183@linux-mips.org>
References: <20091012161556.GA21183@linux-mips.org>
User-Agent: StGIT/0.14.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2009 21:57:13.0194 (UTC) FILETIME=[F46C9CA0:01CA4B86]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

It seems like the original patch got mangled somewhere along the line. It
should correct the behaviour of abs.[sd] and neg.[sd]. I'll repost the
correct patch.

Chris

-- 
Chris Dearman               Desk: +1 408 530 5092  Cell: +1 650 224 8603
MIPS Technologies Inc            955 East Arques Ave, Sunnyvale CA 94085
