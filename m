Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2003 19:13:21 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:7242 "EHLO avtrex.com")
	by linux-mips.org with ESMTP id <S8225423AbTJTSNR>;
	Mon, 20 Oct 2003 19:13:17 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 20 Oct 2003 11:13:14 -0700
Message-ID: <3F9425BA.3070409@avtrex.com>
Date: Mon, 20 Oct 2003 11:13:14 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Kesselring <dkesselr@mmc.atmel.com>
CC: linux-mips@linux-mips.org
Subject: Re: kernel modules
References: <Pine.GSO.4.44.0310201029090.12930-100000@ares.mmc.atmel.com>
In-Reply-To: <Pine.GSO.4.44.0310201029090.12930-100000@ares.mmc.atmel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2003 18:13:14.0636 (UTC) FILETIME=[D43D64C0:01C39735]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Kesselring wrote:

>Can someone please confirm that loading and unloading of kernel modules is
>functioning in the  2.4 release?
>
>When I try to load a wlan module that I compiled (with mipsel-*) I get
>relocation errors. I used the same options as I did to compile the kernel
>(for MIPS Malta board). If you have any ideas, please let me know.
>
>  
>
Modules also require compiling with -mlong-calls in addition to the 
"normal" kernel options.

David Daney.
