Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2009 11:08:33 +0200 (CEST)
Received: from main.gmane.org ([80.91.229.2]:35591 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492893AbZHLJI0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Aug 2009 11:08:26 +0200
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Mb9ok-0001Xg-2F
	for linux-mips@linux-mips.org; Wed, 12 Aug 2009 09:08:22 +0000
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2009 09:08:22 +0000
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2009 09:08:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	Alexander Clouter <alex@digriz.org.uk>
Subject:  Re: AR7 runtime identification [was:- Re: [PATCH -v1] MIPS: add support for gzip/bzip2/lzma compressed kernel images]
Date:	Wed, 12 Aug 2009 09:37:04 +0100
Message-ID:  <gibal6-mt3.ln1@chipmunk.wormnet.eu>
References:  <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com> <20090810101205.GW19816@chipmunk> <200908102342.30031.florian@openwrt.org> <200908112319.58367.florian@openwrt.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=ISO-8859-15
Content-Transfer-Encoding:  8bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Florian Fainelli <florian@openwrt.org> wrote:
>
>> Le Monday 10 August 2009 12:12:05 Alexander Clouter, vous avez écrit :
>>
>> For your information, the TNETD7300GDU is detected like this:
>> TI AR7 (TNETD7300), ID: 0x0005, Revision: 0x02
>>
>> and the TNETD7300EZDW (ADSL 2+) is detected like this:
>> TI AR7 (TNETD7200), ID: 0x002b, Revision: 0x10 which also has the UART bug
>> and is wrongly detected as a TNETD7200.
>>
>> I have left the WAG54G at work and will get my hands back on it tomorow.
> 
> The bad news is that my WAG54G v2 which is also a TNEDT7300GDU has this HW bug 
> too rendering the runtime detection of the bug more difficult.
>
Well, two options I guess.  Another Kconfig or pass something 
on the command line to the kernel.  I would opt for the latter as the 
bug does not make the machine completely unusable and if you make sure 
the workaround is disabled by default hopefully that will have the 
effect of getting people to contact you to add an extra data point.

Annoyingly I'm guess we are more interested in people who do *not* have 
the bug and we would not hear from them as a result.  Maybe if we 
proactively crippled their serial port.... :)

Cheers

-- 
Alexander Clouter
.sigmonster says: Be braver -- you can't cross a chasm in two small jumps.
