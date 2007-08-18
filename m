Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Aug 2007 18:12:57 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.191]:33441 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021288AbXHRRMz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Aug 2007 18:12:55 +0100
Received: by fk-out-0910.google.com with SMTP id f40so817436fka
        for <linux-mips@linux-mips.org>; Sat, 18 Aug 2007 10:12:54 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=jNUWxR9gAoHKB261F9/6ydBvKKdFUjYyZtj3BsS/Rr5txqI8rdC4QSRa6AvmD+tbrY+BLccLASdZ1fk8oBYlwmwQBHsvBzitpGJQmtNOkyckcfb+zq0HwC9Uyaz0X78CHYfE64AB1VzPAH0fhkxxxGX/EyleK4h0gCp1XQMOxz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=fDzjg/gRGY+Vc7gkJU5Si3VTGdG/ibOfbbEoSuheTsk0hWt7PMd1DPIJ09V1xKd6KeTLg0NP8bSTKmJvOMAUcNJXuN4x8QcT7OIgsqSgJiVvi+7YwSqOlG+BOlLz5UmH6pZh00iD8KGXUVM9xlv2GAsiuOc/jg9wq+Ft5znK+yE=
Received: by 10.86.3.2 with SMTP id 2mr3116848fgc.1187457174691;
        Sat, 18 Aug 2007 10:12:54 -0700 (PDT)
Received: from ?192.168.1.129? ( [212.80.64.118])
        by mx.google.com with ESMTPS id b17sm6234618fka.2007.08.18.10.12.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Aug 2007 10:12:53 -0700 (PDT)
Message-ID: <46C728CB.6060102@gmail.com>
Date:	Sat, 18 Aug 2007 19:13:47 +0200
From:	Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
MIME-Version: 1.0
To:	Randy Dunlap <randy.dunlap@oracle.com>
CC:	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, source@mvista.com,
	dougthompson@xmission.com, bluesmoke-devel@lists.sourceforge.net,
	dtor@mail.ru, linux-input@atrey.karlin.mff.cuni.cz,
	netdev@vger.kernel.org, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, gtolstolytkin@ru.mvista.com,
	vitalywool@gmail.com, dsaxena@plexity.net, ralf@linux-mips.org,
	linux-mips@linux-mips.org, mchehab@infradead.org,
	video4linux-list@redhat.com, jbenc@suse.cz,
	flamingice@sourmilk.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 8/9] define global BIT macro
References: <737828602404912540@wsc.cz>	<428714662539710215@wsc.cz> <20070818094602.0ea69c27.randy.dunlap@oracle.com>
In-Reply-To: <20070818094602.0ea69c27.randy.dunlap@oracle.com>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jirislaby@gmail.com
Precedence: bulk
X-list: linux-mips

Randy Dunlap napsal(a):
> On Sat, 18 Aug 2007 11:44:12 +0200 (CEST) Jiri Slaby wrote:
> 
>> define global BIT macro
>>
>> move all local BIT defines to the new globally define macro.
>>
>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
>>
>> ---
>>
>>  include/linux/bitops.h                      |    1 +
>>  include/video/sstfb.h                       |    1 -
>>  include/video/tdfx.h                        |    2 --
>>  net/mac80211/ieee80211_i.h                  |    2 --
>>  18 files changed, 1 insertions(+), 37 deletions(-)
>>
>> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
>> index 3255b06..a57b81f 100644
>> --- a/include/linux/bitops.h
>> +++ b/include/linux/bitops.h
>> @@ -3,6 +3,7 @@
>>  #include <asm/types.h>
>>  
>>  #ifdef	__KERNEL__
>> +#define BIT(nr)			(1UL << (nr))
>>  #define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
>>  #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
>>  #define BITS_TO_TYPE(nr, t)	(((nr)+(t)-1)/(t))
> 
> 
> So users of the BIT() macro in include/linux/input.h can be
> changed to use the global BIT_MASK() macro...
> and the former can be removed.

I'm afraid I don't understand you. Maybe, you are writing about changes done in
patch no. 7 [1], which didn't go through to the lkml?

[1]
http://www.fi.muni.cz/~xslaby/sklad/07-get-rid-of-input-bit-duplicate-defines.patch

thanks,
-- 
Jiri Slaby (jirislaby@gmail.com)
Faculty of Informatics, Masaryk University
