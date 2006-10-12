Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 12:57:42 +0100 (BST)
Received: from hu-out-0506.google.com ([72.14.214.236]:34174 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037883AbWJLL5k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Oct 2006 12:57:40 +0100
Received: by hu-out-0506.google.com with SMTP id 20so136399huc
        for <linux-mips@linux-mips.org>; Thu, 12 Oct 2006 04:57:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Msgd9SGQKZ4W07Ow5cgbNnkVB1SXvGsw1Ta1br/auimh128799ACMuyImia8yIAsy0ihxO4iqi46yKU66W6t7AWOc1QBATgXe+qNM71rssaHSw8cPTZ42bAJq/NQmgoaYGOfAyLHU5CMytPpSauLZ8y82Tb5fy+T5YUy4szPTBc=
Received: by 10.49.8.10 with SMTP id l10mr4974633nfi;
        Thu, 12 Oct 2006 04:57:37 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id a23sm739281nfc.2006.10.12.04.57.37;
        Thu, 12 Oct 2006 04:57:37 -0700 (PDT)
Message-ID: <452E2DAC.9080207@innova-card.com>
Date:	Thu, 12 Oct 2006 13:57:32 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] Introduce __pa_symbol()
References: <11605685254080-git-send-email-fbuihuu@gmail.com>	<20061012.003436.130240259.anemo@mba.ocn.ne.jp>	<452D180D.9020700@innova-card.com> <20061012.184855.108739419.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061012.184855.108739419.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 11 Oct 2006 18:13:01 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> RELOC_HIDE(x) is used because arithmetic on symbol addresses is
>> undefined in C language. It avoid gcc to know that:
>>
>> 	RELOC_HIDE(&_end) + OFFSET
>>
>> is an operation on a symbol address and thus avoid an undefined
>> operation.
> 
> Thanks, I see, but can not imagine the case the RELOC_HIDE() is
> _really_ needed.  Do you have any example?
> 

No I don't have any example but you can take a look to

http://lkml.org/lkml/2006/8/23/175

		Franck
