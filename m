Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 21:05:19 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:49560 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494078AbZKSUFN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Nov 2009 21:05:13 +0100
Received: by bwz21 with SMTP id 21so2813822bwz.24
        for <linux-mips@linux-mips.org>; Thu, 19 Nov 2009 12:05:07 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZXQBx5Qb8s3aNIGvw2jYDmjA+zMTvYS0/C8Dg6nu5dQ=;
        b=iwX3d0UPCzj25uhUtSyanNkXOlLrR5wG0ul0hlMBwcwURwV6uswIGnm3/23gjqm0it
         3q4yGZ/Pw9YnMxxEry7dAeBtpf5Zmhjr35AKQs0S99+Wzy/oA9ny8ETUvQGP4d2NPyiC
         9rd2pY600hWXzTRhyRmfEv+FM2n9JpCWSrJmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BrTBah4oRJvLBD9zQQAPhCPx8sf82vbdW9xWPOpJgoSUrR+6UuZ3cEbXSF1bTfsgj/
         2oeUdWcHsyTFbvAZCrkcMmTT78p7zKU0+PBJ8HHC0/JMOh7bqs2E3UUUfEGSE2h8ZsQg
         JwciRo/HPPKg2LlGr385AUO/mPVzDAprmwAEA=
MIME-Version: 1.0
Received: by 10.223.132.210 with SMTP id c18mr66568fat.31.1258661106962; Thu, 
	19 Nov 2009 12:05:06 -0800 (PST)
In-Reply-To: <20091119170051.GX31954@deprecation.cyrius.com>
References: <20091119164009.GA15038@deprecation.cyrius.com>
	 <90edad820911190856m62275563yf610c4a7dcdd1f67@mail.gmail.com>
	 <20091119170051.GX31954@deprecation.cyrius.com>
Date:	Thu, 19 Nov 2009 22:05:06 +0200
Message-ID: <90edad820911191205h77f298b4u788039abff2db1d0@mail.gmail.com>
Subject: Re: Disable EARLY_PRINTK on IP22 to make the system boot
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Nov 19, 2009 at 7:00 PM, Martin Michlmayr <tbm@cyrius.com> wrote:
> * Dmitri Vorobiev <dmitri.vorobiev@gmail.com> [2009-11-19 18:56]:
>> > Some Debian users have reported that the kernel hangs early
>> > during boot on some IP22 systems.  Thomas Bogendoerfer found
>> > that this is due to a "bad interaction between CONFIG_EARLY_PRINTK
>> > and overwritten prom memory during early boot".  Since there's
>> > no fix yet, disable CONFIG_EARLY_PRINTK for now.
>>
>> Never experienced anything like that, although I'm quite extensively
>> using IP22 with recent kernels. Any details on the hangs?
>
> It doesn't happen on all machines.  It has been reported e.g. with an
> Indigo2.  See http://bugs.debian.org/507557

Interesting, thanks. Good to know that, since one of my machines is Indigo2.

>
> Since Thomas Bogendoerfer disagnosed the problem, he should be able to
> say more.

OK.

Dmitri

>
> --
> Martin Michlmayr
> http://www.cyrius.com/
>
