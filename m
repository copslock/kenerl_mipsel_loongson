Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 18:10:26 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:57466 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835024Ab3F0QKZQEXGW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 18:10:25 +0200
Message-ID: <51CC63E1.3080407@imgtec.com>
Date:   Thu, 27 Jun 2013 11:10:09 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Reduce code size for MIPS32R2 platforms.
References: <1354857289-28828-1-git-send-email-sjhill@mips.com> <20121207150946.GA27226@linux-mips.org> <20130627155816.GF10727@linux-mips.org>
In-Reply-To: <20130627155816.GF10727@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.62]
X-SEF-Processed: 7_3_0_01192__2013_06_27_17_10_19
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 06/27/2013 10:58 AM, Ralf Baechle wrote:
> On Fri, Dec 07, 2012 at 04:09:46PM +0100, Ralf Baechle wrote:
>
> It's a while already - but I haven't forgotten about this little optimization.
>
[...]
>
> Using a quick hack (not in below patch) I reduced CPU support to just a
> single type.  Then not only code for the other 2 variants is dropped by
> the compiler but also dead code elimination can discard ifs and switches
> leaving a highly customized, smaller and faster kernel.  The best of it
> is that it doesn't even rely on LTO, just a decent optimizer of a per-file
> compiler.  Patch for your enjoyment below.
>
> I've done my testing with plain old boring gcc 4.7 btw.
>
Much appreciated. I will test it out here and get back to you. Thanks.

Steve
