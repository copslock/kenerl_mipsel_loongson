Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 16:33:59 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.174]:19268 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20038895AbWJCPd5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Oct 2006 16:33:57 +0100
Received: by ug-out-1314.google.com with SMTP id z27so580450ugc
        for <linux-mips@linux-mips.org>; Tue, 03 Oct 2006 08:33:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=rfhAfUelVzOqtwamRjFBYfYpQQS2ugSDX7U1rRmHp5wTBOGl8fy8wyapEBYPBd8rcTeazv/nqC31eUUR5mprfJImolcSRHvpFysxSrfSrV9vWPlBDW2IjhL0INcRdIQUnj8MdWobP2NxbJEDRMOQwy1HFvJ7zXjABGUhQrV0aqk=
Received: by 10.49.43.2 with SMTP id v2mr963135nfj;
        Tue, 03 Oct 2006 08:33:57 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id r34sm1298847nfc.2006.10.03.08.33.56;
        Tue, 03 Oct 2006 08:33:56 -0700 (PDT)
Message-ID: <45228320.2070809@innova-card.com>
Date:	Tue, 03 Oct 2006 17:34:56 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] setup.c: get ride of CPHYSADDR()
References: <45227762.8090207@innova-card.com> <Pine.LNX.4.64N.0610031614550.4642@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0610031614550.4642@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> Franck,
>>
>> The reason why I'm trying to kick out this macro is that we should
>> rely on __pa() for address convertions instead of having several
>> helpers that do the same thing but differently. Futermore if some
>> tricks are needed for these conversions, they should be done in
>> one place.
> 
>  Have you verified it works correctly for 64-bit kernels linked at a KSEG0 
> address?
> 

Of course not ;). More seriously, I'm working on a 32 bits kernel. I'm
not familiar with MIPS 64 bits world and all tricks needed to compile
them, and that's the reason why I make this thread an RFC one.

I was suspecting something related to 64 bits kernels. Do you mean
that this macro exists because of a linker issue ?

Futhermore I noticed that some part of the code in setup.c do no rely
on this macro for address convertions. See for example in
resource_init():

	code_resource.start = virt_to_phys(&_text);
	code_resource.end = virt_to_phys(&_etext) - 1;
	data_resource.start = virt_to_phys(&_etext);
	data_resource.end = virt_to_phys(&_edata) - 1;

Why in that case we compute address converstion differently ?

Thanks
		Franck
