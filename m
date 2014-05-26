Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 May 2014 22:57:19 +0200 (CEST)
Received: from bes.se.axis.com ([195.60.68.10]:39893 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818481AbaEZU5RySGiI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 May 2014 22:57:17 +0200
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id 998342E354
        for <linux-mips@linux-mips.org>; Mon, 26 May 2014 22:57:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id tKJdVnoPJQ-p for <linux-mips@linux-mips.org>;
        Mon, 26 May 2014 22:57:01 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bes.se.axis.com (Postfix) with ESMTP id E98472E353
        for <linux-mips@linux-mips.org>; Mon, 26 May 2014 22:57:01 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id BE026E69
        for <linux-mips@linux-mips.org>; Mon, 26 May 2014 22:57:01 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id B306DC04
        for <linux-mips@linux-mips.org>; Mon, 26 May 2014 22:57:01 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by thoth.se.axis.com (Postfix) with ESMTP id B109E34005
        for <linux-mips@linux-mips.org>; Mon, 26 May 2014 22:57:01 +0200 (CEST)
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail2.se.axis.com
 ([10.0.5.74]) with mapi; Mon, 26 May 2014 22:57:01 +0200
From:   Mikael Starvik <mikael.starvik@axis.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Lars Persson <larper@axis.com>,
        Martin Santesson <martinsn@axis.com>
Date:   Mon, 26 May 2014 22:56:58 +0200
Subject: 1004K MT paging issue
Thread-Topic: 1004K MT paging issue
Thread-Index: Ac95JQomL4oMCFQ8Rku9uVPj/xftKA==
Message-ID: <498838AF-48B0-4244-95C0-F590040E5E08@axis.com>
Accept-Language: sv-SE
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: sv-SE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <mikael.starvik@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikael.starvik@axis.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi!

We have a 1004K core with two VPEs with two TCs per VPE. We have a problem that is hard to debug and would like to know if anyone has seen or solved such an issue.

A multithreaded application is running. 
Twoapplication threads are running in one TC each on the same VPE.
A piece of code has been paged out.
Application thread 1 tries to execute the code and thus gets a page fault.
While the page fault is being handled the second application thread enters the same code.
For some reason it looks like application thread 2 is allowed to execute even if the page fault handling has not been finished yet.
Thread 2 executes the wrong code and typically gets a reserved instruction exception.

Any thougts?

BR
/Mikael
From kevink@paralogos.com Tue May 27 00:58:05 2014
Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2014 00:58:07 +0200 (CEST)
Received: from gateway09.websitewelcome.com ([67.18.14.9]:50725 "EHLO
        gateway09.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821443AbaEZW6Fxt29- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 May 2014 00:58:05 +0200
Received: by gateway09.websitewelcome.com (Postfix, from userid 507)
        id AC86B75A91E30; Mon, 26 May 2014 17:58:03 -0500 (CDT)
Received: from gator3163.hostgator.com (gator3163.hostgator.com [50.87.144.199])
        by gateway09.websitewelcome.com (Postfix) with ESMTP id 04A6575A916F6
        for <linux-mips@linux-mips.org>; Mon, 26 May 2014 17:58:02 -0500 (CDT)
Received: from [98.234.48.184] (port=52665 helo=[10.0.0.13])
        by gator3163.hostgator.com with esmtpa (Exim 4.82)
        (envelope-from <kevink@paralogos.com>)
        id 1Wp3qD-0005gN-Hr
        for linux-mips@linux-mips.org; Mon, 26 May 2014 17:58:01 -0500
Message-ID: <5383C6DD.4090107@paralogos.com>
Date:   Mon, 26 May 2014 15:57:33 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: 1004K MT paging issue
References: <498838AF-48B0-4244-95C0-F590040E5E08@axis.com>
In-Reply-To: <498838AF-48B0-4244-95C0-F590040E5E08@axis.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3163.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-BWhitelist: no
X-Source-IP: 98.234.48.184
X-Exim-ID: 1Wp3qD-0005gN-Hr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.0.0.13]) [98.234.48.184]:52665
X-Source-Auth: kevink@kevink.net
X-Email-Count: 2
X-Source-Cap: a2tpc3NlbGw7a2tpc3NlbGw7Z2F0b3IzMTYzLmhvc3RnYXRvci5jb20=
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Content-Length: 1239
Lines: 29

When a VPE hits an exception and sets EXL, thread scheduling stops and
the VPE is single-threaded coming into the exception.  With dual VPEs,
one of them hitting a fault won't prevent another from doing so, but all
the usual rules of locking and ordering that are needed for any SMP
kernel should apply and "just work".  Is there any SMP support in the VM
subsystem that's conditionally modfied or excluded for your 1004K kernel
build?

/K.


On 5/26/2014 1:56 PM, Mikael Starvik wrote:
> Hi!
>
> We have a 1004K core with two VPEs with two TCs per VPE. We have a problem that is hard to debug and would like to know if anyone has seen or solved such an issue.
>
> A multithreaded application is running. 
> Twoapplication threads are running in one TC each on the same VPE.
> A piece of code has been paged out.
> Application thread 1 tries to execute the code and thus gets a page fault.
> While the page fault is being handled the second application thread enters the same code.
> For some reason it looks like application thread 2 is allowed to execute even if the page fault handling has not been finished yet.
> Thread 2 executes the wrong code and typically gets a reserved instruction exception.
>
> Any thougts?
>
> BR
> /Mikael
