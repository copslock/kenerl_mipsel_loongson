Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 14:50:18 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:49346 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133138AbWCAOuJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Mar 2006 14:50:09 +0000
Received: from localhost (p7129-ipad01funabasi.chiba.ocn.ne.jp [61.207.81.129])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C0C4DA522; Wed,  1 Mar 2006 23:57:55 +0900 (JST)
Date:	Wed, 01 Mar 2006 23:57:50 +0900 (JST)
Message-Id: <20060301.235750.25910018.anemo@mba.ocn.ne.jp>
To:	nickpiggin@yahoo.com.au
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: jiffies_64 vs. jiffies
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44059915.3010800@yahoo.com.au>
References: <20060301.144442.118975101.nemoto@toshiba-tops.co.jp>
	<20060301.210541.30439818.nemoto@toshiba-tops.co.jp>
	<44059915.3010800@yahoo.com.au>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 01 Mar 2006 23:52:37 +1100, Nick Piggin <nickpiggin@yahoo.com.au> said:

>> void do_timer(struct pt_regs *regs)
>> {
>> -	jiffies_64++;
>> -	update_times();
>> +	update_times(++jiffies_64);
>>  	softlockup_tick(regs);
>> }

nick> jiffies_64 is not volatile so you should not have to obfuscate
nick> the code like this.

Well, do you mean it should be like this ?

	jiffies_64++;
	update_times(jiffies_64);

Thanks for your comments.
---
Atsushi Nemoto
