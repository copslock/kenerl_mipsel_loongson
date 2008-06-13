Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 17:53:29 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:58762 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20036044AbYFMQx0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jun 2008 17:53:26 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 2673031E921;
	Fri, 13 Jun 2008 16:53:24 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Fri, 13 Jun 2008 16:53:23 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 13 Jun 2008 09:53:04 -0700
Message-ID: <4852A5EF.5080703@avtrex.com>
Date:	Fri, 13 Jun 2008 09:53:03 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Thomas Horsten <thomas@horsten.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [BUG] R5000 failure in kmap_coherent on Lasat board, bug that
 has been there for a while?
References: <Pine.LNX.4.40.0806131600540.25629-100000@jehova.dsm.dk>
In-Reply-To: <Pine.LNX.4.40.0806131600540.25629-100000@jehova.dsm.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2008 16:53:04.0797 (UTC) FILETIME=[F2C5B4D0:01C8CD75]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Thomas Horsten wrote:
> Hi all,
> 
> (resending w/ more info because the first one didn't make it to the
> list - I'm subscribed now so hopefully it'll go through this time):
> 
> This crash happens (late) during boot with 2.6.25.6. I think this is a
> general R5k issue with the cache handling code. It only seems to
> happen when the swap is in use like someone else observed, but usually
> only after some big processes like mysql have been started.
> 
> As far as I can see it's the same issue that has been reported several
> other places, but with no resolution in any of them:
> 
> http://www.linux-mips.org/archives/linux-mips/2007-12/msg00128.html
> http://www.linux-mips.org/archives/linux-mips/2008-01/msg00132.html
> and also seen by someone else here:
> http://lists.debian.org/debian-mips/2007/11/msg00034.html
> 
> I'm thinking some subtle difference between R4k and R5k caches which
> isn't taken into account, or an aliasing bug that only triggers on
> R5k?

I have a mips 4KEc based system where I think it is happening too (sigma8634 based w/ 2.6.15 kernel).


> 
> I also found what seems to be a related patch from OpenWRT but I have
> no idea what it's supposed to solve as I could only find the raw
> patch:
> 
> https://dev.openwrt.org/browser/trunk/target/linux/brcm47xx/patches-2.6.25/160-kmap_coherent.patch?rev=11155
> 
> In any case I tried to apply it to my Lasat kernel, but using the
> _atomic functions instead of _coherent just causes a much earlier
> crash.
> 

I will try said patch on my O2/R5000 and the sigma8634.

Thanks,
David Daney
