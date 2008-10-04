Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Oct 2008 03:58:15 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.189]:5393 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20505633AbYJDC6M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 4 Oct 2008 03:58:12 +0100
Received: by ti-out-0910.google.com with SMTP id i7so786500tid.20
        for <linux-mips@linux-mips.org>; Fri, 03 Oct 2008 19:58:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=/lK8CgPdjNqWTvrkrnW14Kan/62yhgEeuXAbeWQSrSc=;
        b=PZaGXXQS3zA/RpsZQJO5TvtUalBIDTL9q+kDbEb58MZ1vK/KSKIn2IVq3h8yXX8/rc
         ppBC+DLPD88Zp9J9zC2A7jrpIUwqSAd0YLdDYWethbg/hnFlYkEYoVSdHMEnzoFZxOgf
         NHSCLHpxFH/HZG2pW+NHWAkOF5YqBx+De5VxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=Igoo/pOlY+ZVQTc/dVLWgFSh4SRGSs0IrJOnZdEioCjdoisrtBn33/2Lu4ENCwiImC
         hJUI6Qj+vI3XVl/7n2grWnqC/UrU4Yj6k3yPOUQnuGejacXJpkWCSCyb2/ba2Cw7q+bv
         uRbwrTmofHKyBNw5L8KLowZAIIdKc8eQw+j1k=
Received: by 10.110.49.2 with SMTP id w2mr1861463tiw.54.1223089088973;
        Fri, 03 Oct 2008 19:58:08 -0700 (PDT)
Received: from htj.dyndns.org ([222.235.223.114])
        by mx.google.com with ESMTPS id d4sm3765937tib.1.2008.10.03.19.58.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 19:58:07 -0700 (PDT)
Received: from [127.0.0.2] (htj.dyndns.org [127.0.0.2])
	by htj.dyndns.org (Postfix) with ESMTPSA id 9A4FD13A81FA;
	Sat,  4 Oct 2008 11:56:21 +0900 (KST)
Message-ID: <48E6DB55.2050800@gmail.com>
Date:	Sat, 04 Oct 2008 11:56:21 +0900
From:	Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20071114)
MIME-Version: 1.0
To:	James Bottomley <James.Bottomley@HansenPartnership.com>
CC:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <48C851ED.4090607@ru.mvista.com>	 <48CA8BEE.1090305@ru.mvista.com>	 <20080913.005904.07457691.anemo@mba.ocn.ne.jp>	 <200809271819.19510.bzolnier@gmail.com>  <48DEAF1F.8040200@gmail.com> <1222787387.3232.26.camel@localhost.localdomain>
In-Reply-To: <1222787387.3232.26.camel@localhost.localdomain>
X-Enigmail-Version: 0.95.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: htejun@gmail.com
Precedence: bulk
X-list: linux-mips

James Bottomley wrote:
> On Sun, 2008-09-28 at 07:09 +0900, Tejun Heo wrote:
>> Bartlomiej Zolnierkiewicz wrote:
>>> On Friday 12 September 2008, Atsushi Nemoto wrote:
>>>> On Fri, 12 Sep 2008 19:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>>> [...]
>>>
>>>>>>>> +	__ide_flush_dcache_range((unsigned long)addr, size);
>>>>>>>   Why is this needed BTW?
>>>>>> Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
>>>>>> inconsistency on PIO drive.  PIO transfer only writes to cache but
>>>>>> upper layers expects the data is in main memory.
>>>>>     Hum, then I wonder why it's MIPS specific...
>>>> SPARC also have it.  And there were some discussions for ARM IIRC.
>>> I was under the impression that it has been addressed by Tejun at
>>> the higher-layer level (for both ide/libata) long time ago and that
>>> MIPS/SPARC code are just a left-overs which could be removed now?
>> cc'ing Jens and James.  IIRC, I posted several patches but they never
>> went in.  I don't remember what the objections were or whether any
>> alternative fix went in.
> 
> Which patches were these?  We have several methods of doing PIO
> fallback, the most common one being
> scatterlist.c:sg_copy_from/to_buffer() which does the cache coherency.

The thread Atsushi found seems to be the correct one.

  http://lkml.org/lkml/2006/1/13/156

Thanks.

-- 
tejun
