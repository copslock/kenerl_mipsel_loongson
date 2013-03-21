Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 01:16:24 +0100 (CET)
Received: from plane.gmane.org ([80.91.229.3]:60445 "EHLO plane.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834919Ab3CUAQXKHq21 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Mar 2013 01:16:23 +0100
Received: from list by plane.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1UITBT-0008Pd-OL
        for linux-mips@linux-mips.org; Thu, 21 Mar 2013 01:16:43 +0100
Received: from p579bf2b1.dip.t-dialin.net ([87.155.242.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 21 Mar 2013 01:16:43 +0100
Received: from s.gottschall by p579bf2b1.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 21 Mar 2013 01:16:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Subject: Re: MIPS: Add dependencies for HAVE_ARCH_TRANSPARENT_HUGEPAGE
Date:   Thu, 21 Mar 2013 01:16:08 +0100
Message-ID: <kidjg0$u10$1@ger.gmane.org>
References: <1362257499.3768.141.camel@deadeye.wl.decadent.org.uk> <1362370641.3768.291.camel@deadeye.wl.decadent.org.uk> <kiddfo$82s$1@ger.gmane.org> <514A4265.2080709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p579bf2b1.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <514A4265.2080709@gmail.com>
X-archive-position: 35926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: s.gottschall@dd-wrt.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>


>> why? the mips32 74k platform (broadcom bcm4706 for instance) does
>> support huge pages.
>
> The hardware may support pages larger than 64K, but does the Linux
> kernel?  I think not.
>
>> and some of these devices are also using highmem for
>> accessing more than 128mb ram (which is totally broken in all current
>> kernels too and causing filesystem corruptions)
>> i was able to fix the highmem problem using a patch which was submitted
>> but never taken into the mainline, but i just was able to get thb
>> partially to work on mips32. but i think it would be possible to support
>> this on mips32 as well. so why leaving it out?
>
> As they say... Patches are welcome.  If you get Linux HUGE pages working
> for 32-bit kernels send a patch to enable the transparent variety as well.
>
> David Daney

the first patch would be fix for the HIGHMEM problem. all recent kernels 
do support HIGHMEM for mips32 based devices, but in fact its not 
working. all patches i made which is required to get it to work is 
available at svn://svn.dd-wrt.com/DD-WRT for all recent kernels.

for mips32 HIGHMEM support you need to apply the following patch

http://patchwork.linux-mips.org/patch/3634/

this patch has a small typo, which needs to be fixed but its very easy 
to merge to all current kernels. without it, highmem enabled devices 
will cause memory corruptions. especially on filesystems wrong data will 
be written and so on.

i will try to test my older thb patch with the new highmem fixes 
together next and i hope it works. in the meantime, please review the 
patchlink above

Sebastian
