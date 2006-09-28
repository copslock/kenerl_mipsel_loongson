Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 08:41:19 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:60909 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038470AbWI1HlR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 08:41:17 +0100
Received: by nf-out-0910.google.com with SMTP id l23so677672nfc
        for <linux-mips@linux-mips.org>; Thu, 28 Sep 2006 00:41:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=lumznASxQwWaePtxDIPhKpjl/gXUclIFRBEI5FWq4OaBhH9gukHtnVTLgKj1lF60yD3El4vYZOxSfNZWPv9UBGpqoaqgyGzcsLZ1SDOcrNI/FoQ1YDY7ieupQ8rdjM/Iis7giytwtH1+N5XjmReYRvmHqVNMxX3cxALw41JUShY=
Received: by 10.48.48.18 with SMTP id v18mr3423071nfv;
        Thu, 28 Sep 2006 00:41:16 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id c1sm5055051nfe.2006.09.28.00.41.15;
        Thu, 28 Sep 2006 00:41:16 -0700 (PDT)
Message-ID: <451B7CCB.1060406@innova-card.com>
Date:	Thu, 28 Sep 2006 09:42:03 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Peter Popov <ppopov@embeddedalley.com>
CC:	Franck <vagabon.xyz@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: How to work with Linux-Mips ?
References: <4518D33F.9070208@innova-card.com> <4519859A.1090306@embeddedalley.com>
In-Reply-To: <4519859A.1090306@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Peter Popov wrote:
> <snip>
> 
> 
>> These patchs have been kindly reviewed and acked by Atsushi Nemoto,
>> but then no feedback from the MIPS team. I tried to get a status for
>> MIPS team a couple of time, to know if something was wrong with them
>> but MIPS people seem to not care about them. They even haven't
>> bothered to take 10 seconds for replying something like:
> 
> 
>>   - your patches are broken because...
>>
>>   - your patches do not respect our MIPS protocol, please resend...
>>
>>   - Sorry we are very busy, please hold on...
>>
>>   - OK your patches suck please try to work on ARM chips because MIPS
>>     is a very closed circle reserved to MIPS gurus.
> 
> There is no such thing as a 10 sec patch review. Especially when it
> comes to patches that touch generic portions of the kernel. Someone has
> to very carefully consider what they are doing, any potential risks, how

Who is claiming that ? I've never said that patch review needs 10 sec to
be done....

> 
> MIPS Tech and linux-mips are separate entities. Personally I think MIPS
> Tech has done a great service to themselves, their customers, and the
> entire Linux MIPS community, by hiring Ralf to do new MIPS development
> and properly support new chips coming out.

Again, none has said the contrary...

		Franck
