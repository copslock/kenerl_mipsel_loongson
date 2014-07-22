Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 19:26:55 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:54635
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6838513AbaGVP0xtJ6bo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 17:26:53 +0200
Message-ID: <53CE82B6.1070902@phrozen.org>
Date:   Tue, 22 Jul 2014 17:26:46 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: EdgeRouter Pro supported?  Strange FP problems
References: <20140722130616.GJ30723@humdrum>
In-Reply-To: <20140722130616.GJ30723@humdrum>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 22/07/2014 15:06, Rob Kendrick wrote:
> Hi,
> 
> I'm trying to build a kernel for an Ubiquiti EdgeRouter Pro (not a 
> Lite).  I'm using the current master from linux-mti, and this
> produces a kernel that boots and has network support (but bizarrely
> not activity LEDs) and USB support, which is good.  However, what I
> am seeing is bizarre floating point behavior.
> 
> Is there a known issue with master on these Octeon2-based boards? 
> Should I be pointing my finger of blame at the compiler I've built 
> (using crosstool-ng) or my configuration of the kernel?
> 
> Is there a better choice of compiler and kernel to be using for
> these boards?
> 
> Thanks for any input,
> 


Hi Rob,

we had a quite some trouble adding support to openwrt. in the end we
needed a few uclibc patches and gxx4.8 seems utterly foo'ed on this.
gcc 4.6 and 4.9 seem to be running fine though.

what compiler, libc, ... version are you using ?

	John
