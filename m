Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Sep 2008 23:11:10 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.191]:7385 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20145495AbYI0WLF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Sep 2008 23:11:05 +0100
Received: by ti-out-0910.google.com with SMTP id i7so578469tid.20
        for <linux-mips@linux-mips.org>; Sat, 27 Sep 2008 15:11:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=Q5WiaKWW4VMhWf0r0P56Jdo0RjLCBkcot8F5YgaudE4=;
        b=vA3OxeuMIENXHhGf8UgOHdGEcYkXVmOEmba4EuB9m1QDV0Jng4o5SoDqWwD4zdGDC8
         Ez/Jok24qZDfylM7eKCpyOf6eMkuN7cgCl7lcU5YC13zY3vSFMaWf6fBk3aLrMIaSqmY
         mCLlIQyIUWG55NZmZ5BIWXNksQCo0loDTNvSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=DDXp/M/yT0+2J63Xsl0qohVz4YurPuweWpoXVKXHV3XoQRf9l2MwSL7YAVkKx8sp6F
         /OnMN3RMQSiKpnmTqtCnZd9gG01umkAp1reaKrY+1kXlw/EwO1Pxl8KeQPTHdhoGJ4Qt
         PWv3guYEhQ5xjQe1FjENInXGdz7smX1f4fNKM=
Received: by 10.110.49.2 with SMTP id w2mr4045944tiw.43.1222553460201;
        Sat, 27 Sep 2008 15:11:00 -0700 (PDT)
Received: from htj.dyndns.org ([222.235.223.114])
        by mx.google.com with ESMTPS id w12sm1129876tib.10.2008.09.27.15.10.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 15:10:58 -0700 (PDT)
Received: from [192.168.0.47] (unknown [222.97.233.136])
	by htj.dyndns.org (Postfix) with ESMTPSA id 9A18D13A820D;
	Sun, 28 Sep 2008 07:09:19 +0900 (KST)
Message-ID: <48DEAF1F.8040200@gmail.com>
Date:	Sun, 28 Sep 2008 07:09:35 +0900
From:	Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080720)
MIME-Version: 1.0
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org, Jens Axboe <jens.axboe@oracle.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <48C851ED.4090607@ru.mvista.com> <48CA8BEE.1090305@ru.mvista.com> <20080913.005904.07457691.anemo@mba.ocn.ne.jp> <200809271819.19510.bzolnier@gmail.com>
In-Reply-To: <200809271819.19510.bzolnier@gmail.com>
X-Enigmail-Version: 0.95.7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: htejun@gmail.com
Precedence: bulk
X-list: linux-mips

Bartlomiej Zolnierkiewicz wrote:
> On Friday 12 September 2008, Atsushi Nemoto wrote:
>> On Fri, 12 Sep 2008 19:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> 
> [...]
> 
>>>>>> +	__ide_flush_dcache_range((unsigned long)addr, size);
>>>>>   Why is this needed BTW?
>>>> Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
>>>> inconsistency on PIO drive.  PIO transfer only writes to cache but
>>>> upper layers expects the data is in main memory.
>>>     Hum, then I wonder why it's MIPS specific...
>> SPARC also have it.  And there were some discussions for ARM IIRC.
> 
> I was under the impression that it has been addressed by Tejun at
> the higher-layer level (for both ide/libata) long time ago and that
> MIPS/SPARC code are just a left-overs which could be removed now?

cc'ing Jens and James.  IIRC, I posted several patches but they never
went in.  I don't remember what the objections were or whether any
alternative fix went in.

Thanks.

-- 
tejun
