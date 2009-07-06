Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2009 21:08:43 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:32103 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491855AbZGFTIh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2009 21:08:37 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a524a0e0000>; Mon, 06 Jul 2009 15:01:34 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Jul 2009 12:01:08 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Jul 2009 12:01:08 -0700
Message-ID: <4A5249F2.7010202@caviumnetworks.com>
Date:	Mon, 06 Jul 2009 12:01:06 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix support for Cavium Octeon debugger stub.
References: <1246905276-8543-1-git-send-email-ddaney@caviumnetworks.com> <1246906796-19893-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1246906796-19893-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jul 2009 19:01:08.0889 (UTC) FILETIME=[1F201890:01C9FE6C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> The Cavium Octeon bootloader has a debugger stub that requires a
> little help from the target application to break in.
> 
> If configured, when we get an interrupt on the debug uart we wake up
> the debugger.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Drat, Ignore this duplicate.

David Daney
