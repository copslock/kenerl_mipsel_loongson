Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2008 00:16:25 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:58580 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28575716AbYDSXQX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 20 Apr 2008 00:16:23 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 538AD3188A8;
	Sat, 19 Apr 2008 23:17:10 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Sat, 19 Apr 2008 23:17:10 +0000 (UTC)
Received: from [192.168.7.221] ([192.168.7.221]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 19 Apr 2008 16:16:11 -0700
Message-ID: <480A7D3A.2040004@avtrex.com>
Date:	Sat, 19 Apr 2008 16:16:10 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Building current kernel for Qemu
References: <480A70EA.50804@avtrex.com> <20080419230844.GA31431@networkno.de>
In-Reply-To: <20080419230844.GA31431@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2008 23:16:11.0219 (UTC) FILETIME=[5B071A30:01C8A273]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> David Daney wrote:
>   
>> I would like to build a current kernel for mipsel on qemu.  However it
>> seems that the qemu target was recently removed.
>>
>> I tried building a plain malta kernel vmlinux, but there is no output on
>> the console when trying to boot it.  The Debian 2.6.18 qemu kernel seems
>> to work well though.
>>
>> Do you have to do anything special to the kernel to run on qemu?
>>     
>
> Nothing special is needed for the kernel. You need to start with
> e.g. "qemu-system-mipsel -M malta" to select Qemu's malta machine
> emulation.
>   
Thanks Thiemo,  the '-M malta' is all I was missing.  I am now running
with the current git tip.

David Daney
