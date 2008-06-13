Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 17:56:55 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:29416 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20036068AbYFMQ4w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jun 2008 17:56:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5DGuAfL027891;
	Fri, 13 Jun 2008 17:56:10 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5DGu7RG027870;
	Fri, 13 Jun 2008 17:56:07 +0100
Date:	Fri, 13 Jun 2008 17:56:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Thomas Horsten <thomas@horsten.com>, linux-mips@linux-mips.org
Subject: Re: [BUG] R5000 failure in kmap_coherent on Lasat board, bug that
	has been there for a while?
Message-ID: <20080613165607.GB29015@linux-mips.org>
References: <Pine.LNX.4.40.0806131600540.25629-100000@jehova.dsm.dk> <4852A5EF.5080703@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4852A5EF.5080703@avtrex.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 13, 2008 at 09:53:03AM -0700, David Daney wrote:
> From: David Daney <ddaney@avtrex.com>
> Date: Fri, 13 Jun 2008 09:53:03 -0700
> To: Thomas Horsten <thomas@horsten.com>
> Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
> Subject: Re: [BUG] R5000 failure in kmap_coherent on Lasat board, bug that
> 	has been there for a while?
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
> Thomas Horsten wrote:
>> Hi all,
>>
>> (resending w/ more info because the first one didn't make it to the
>> list - I'm subscribed now so hopefully it'll go through this time):
>>
>> This crash happens (late) during boot with 2.6.25.6. I think this is a
>> general R5k issue with the cache handling code. It only seems to
>> happen when the swap is in use like someone else observed, but usually
>> only after some big processes like mysql have been started.
>>
>> As far as I can see it's the same issue that has been reported several
>> other places, but with no resolution in any of them:
>>
>> http://www.linux-mips.org/archives/linux-mips/2007-12/msg00128.html
>> http://www.linux-mips.org/archives/linux-mips/2008-01/msg00132.html
>> and also seen by someone else here:
>> http://lists.debian.org/debian-mips/2007/11/msg00034.html
>>
>> I'm thinking some subtle difference between R4k and R5k caches which
>> isn't taken into account, or an aliasing bug that only triggers on
>> R5k?
>
> I have a mips 4KEc based system where I think it is happening too (sigma8634 based w/ 2.6.15 kernel).
>
>
>>
>> I also found what seems to be a related patch from OpenWRT but I have
>> no idea what it's supposed to solve as I could only find the raw
>> patch:
>>
>> https://dev.openwrt.org/browser/trunk/target/linux/brcm47xx/patches-2.6.25/160-kmap_coherent.patch?rev=11155
>>
>> In any case I tried to apply it to my Lasat kernel, but using the
>> _atomic functions instead of _coherent just causes a much earlier
>> crash.
>>
>
> I will try said patch on my O2/R5000 and the sigma8634.

The patch is total bullshit.  It doesn't even try to fix the issues but
rather disables the alias-avoidance mechanism.

  Ralf
