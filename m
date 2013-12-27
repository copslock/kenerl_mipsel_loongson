Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Dec 2013 20:48:00 +0100 (CET)
Received: from blu0-omc4-s5.blu0.hotmail.com ([65.55.111.144]:2497 "EHLO
        blu0-omc4-s5.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818014Ab3L0Tr4pGVOq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Dec 2013 20:47:56 +0100
Received: from BLU0-SMTP15 ([65.55.111.136]) by blu0-omc4-s5.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 27 Dec 2013 11:47:50 -0800
X-TMN:  [Kz7l7icolV3NLZEbbOYwKaq4J5W1ZNe/]
X-Originating-Email: [dave.anglin@bell.net]
Message-ID: <BLU0-SMTP15241D603FEB77037F6D1E97CD0@phx.gbl>
Received: from [192.168.2.10] ([69.158.171.205]) by BLU0-SMTP15.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 27 Dec 2013 11:47:49 -0800
From:   John David Anglin <dave.anglin@bell.net>
To:     Matthew Wilcox <willy@linux.intel.com>
In-Reply-To: <20131227193330.GE4945@linux.intel.com>
Subject: Re: [PATCH] remap_file_pages needs to check for cache coherency
References: <20131227180018.GC4945@linux.intel.com> <BLU0-SMTP17D26551261DF285A7E6F497CD0@phx.gbl> <20131227193330.GE4945@linux.intel.com>
Content-Type: text/plain; charset="US-ASCII"; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0 (Apple Message framework v936)
Date:   Fri, 27 Dec 2013 14:47:32 -0500
CC:     linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@linux-mips.org
X-Mailer: Apple Mail (2.936)
X-OriginalArrivalTime: 27 Dec 2013 19:47:49.0334 (UTC) FILETIME=[85B75760:01CF033C]
Return-Path: <dave.anglin@bell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave.anglin@bell.net
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

On 27-Dec-13, at 2:33 PM, Matthew Wilcox wrote:

> Have you considered measuring SHMLBA on different CPU models and
> reducing it at boot time?  I know that 4MB is the architectural  
> guarantee
> (actually, I seem to remember that 16MB was the architectural  
> guarantee,
> but jsm found some CPU architects who said it would enver exceed 4MB).
> I bet some CPUs have considerably lower cache coherency limits.


It's worth looking at.  The value is supposed to be returned by the  
PDC_CACHE PDC
call but I know my rp3440 returns a value of 0 indicating that the  
aliasing boundary
is unknown and may be greater than 16MB.

Dave
--
John David Anglin	dave.anglin@bell.net
