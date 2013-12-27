Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Dec 2013 21:14:58 +0100 (CET)
Received: from blu0-omc4-s36.blu0.hotmail.com ([65.55.111.175]:10803 "EHLO
        blu0-omc4-s36.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817033Ab3L0UOzd-uMR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Dec 2013 21:14:55 +0100
Received: from BLU0-SMTP67 ([65.55.111.137]) by blu0-omc4-s36.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 27 Dec 2013 12:14:49 -0800
X-TMN:  [R0i1oIIuyxDHmPiSC02w4muDhh+R5Bxa]
X-Originating-Email: [dave.anglin@bell.net]
Message-ID: <BLU0-SMTP67B57AF06A5AC44236538A97CD0@phx.gbl>
Received: from [192.168.2.10] ([69.158.171.205]) by BLU0-SMTP67.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 27 Dec 2013 12:14:48 -0800
CC:     Matthew Wilcox <willy@linux.intel.com>, linux-mm@kvack.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@linux-mips.org
From:   John David Anglin <dave.anglin@bell.net>
To:     John David Anglin <dave.anglin@bell.net>
In-Reply-To: <BLU0-SMTP15241D603FEB77037F6D1E97CD0@phx.gbl>
Content-Type: text/plain; charset="US-ASCII"; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] remap_file_pages needs to check for cache coherency
Date:   Fri, 27 Dec 2013 15:14:39 -0500
References: <20131227180018.GC4945@linux.intel.com> <BLU0-SMTP17D26551261DF285A7E6F497CD0@phx.gbl> <20131227193330.GE4945@linux.intel.com> <BLU0-SMTP15241D603FEB77037F6D1E97CD0@phx.gbl>
X-Mailer: Apple Mail (2.936)
X-OriginalArrivalTime: 27 Dec 2013 20:14:48.0195 (UTC) FILETIME=[4AA1ED30:01CF0340]
Return-Path: <dave.anglin@bell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38812
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

On 27-Dec-13, at 2:47 PM, John David Anglin wrote:

> It's worth looking at.  The value is supposed to be returned by the  
> PDC_CACHE PDC
> call but I know my rp3440 returns a value of 0 indicating that the  
> aliasing boundary
> is unknown and may be greater than 16MB.

c3750 data cache has an aliasing boundary of 4 MB, so I think we are  
stuck with large
SHMLBA.

Dave
--
John David Anglin	dave.anglin@bell.net
