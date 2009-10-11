Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Oct 2009 22:06:11 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:53683 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492814AbZJKUGD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Oct 2009 22:06:03 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n9BK5t7W000996;
	Sun, 11 Oct 2009 13:05:56 -0700
Received: from [192.168.3.60] ([192.168.3.60]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Oct 2009 13:05:54 -0700
Message-ID: <4AD23AA0.9010702@mips.com>
Date:	Sun, 11 Oct 2009 13:05:52 -0700
From:	Chris Dearman <chris@mips.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Avoid potential hazard on Context register
References: <4AD17619.1000201@mips.com> <20091011133912.GA15684@linux-mips.org>
In-Reply-To: <20091011133912.GA15684@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Oct 2009 20:05:54.0922 (UTC) FILETIME=[3D736CA0:01CA4AAE]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> I'm curious, did you actually manage to trigger this one?  The time between
> the instructions should be fairly long but then again the 34K has been
> good for a few surprises!

Yes... It actually showed up in 74k silicon at particular clock 
frequencies. The dual issue pipeline does make it susceptible to these 
"theoretical" problems ;)

Chris

-- 
Chris Dearman               Desk: +1 408 530 5092  Cell: +1 650 224 8603
MIPS Technologies Inc            955 East Arques Ave, Sunnyvale CA 94085
