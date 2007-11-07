Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 01:15:07 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:908 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20026357AbXKGBO6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Nov 2007 01:14:58 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 7C6C63100A6;
	Wed,  7 Nov 2007 01:14:39 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed,  7 Nov 2007 01:14:39 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Nov 2007 17:13:27 -0800
Message-ID: <47311137.5090706@avtrex.com>
Date:	Tue, 06 Nov 2007 17:13:27 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	Reeve Yang <reeve.yang@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: cross-tool for mips target
References: <3b279e3f0711061708r12913a29o62e4bf99a2ee3664@mail.gmail.com>
In-Reply-To: <3b279e3f0711061708r12913a29o62e4bf99a2ee3664@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2007 01:13:27.0779 (UTC) FILETIME=[66FC3330:01C820DB]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Reeve Yang wrote:
> Hi there,
> 
> I'm trying to build cross tool chain for mips32 target from my pc
> (i686) based on crosstoll-0.43. By running "sh demo-mips.sh" (I chose
> eval `cat mips.dat gcc-3.4.5-glibc-2.3.5.dat` sh all.sh --notest), I
> got following error from log file. Has anyone ever had similiar
> experience and how did you fix it? Thanks!
> 

I would ask over on: crossgcc@sourceware.org

That is where crosstool is often discussed.

David Daney
