Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 15:43:21 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:30087 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038439AbWIZOnP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 15:43:15 +0100
Received: by nf-out-0910.google.com with SMTP id l23so217127nfc
        for <linux-mips@linux-mips.org>; Tue, 26 Sep 2006 07:43:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=rkw7JV07AB8cyWJ+paYzH7hHeKFuAvr0Spu86Gm/e5bnBDTwbNOB9tb5S00EAs0yQ91ZihYP7y4guAPq37P1RGzQuaoNKeYTYIzIS/F8hcrq+M57eldsM0eUT66dZjcikBjiwc1Pz8B5zhvobtQEHFKMTiVXmeix1ZJ9nACQ/tU=
Received: by 10.48.48.15 with SMTP id v15mr1124880nfv;
        Tue, 26 Sep 2006 07:43:08 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id l21sm1458916nfc.2006.09.26.07.43.07;
        Tue, 26 Sep 2006 07:43:07 -0700 (PDT)
Message-ID: <45193CAB.7040103@innova-card.com>
Date:	Tue, 26 Sep 2006 16:43:55 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org
Subject: Re: How to work with Linux-Mips ?
References: <4518D33F.9070208@innova-card.com> <20060926134848.GB27446@linux-mips.org>
In-Reply-To: <20060926134848.GB27446@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I'm glad you answered...

Ralf Baechle wrote:
> On Tue, Sep 26, 2006 at 09:14:07AM +0200, Franck Bui-Huu wrote:
> 
>> These patchs have been kindly reviewed and acked by Atsushi Nemoto,
>> but then no feedback from the MIPS team. I tried to get a status for
>> MIPS team a couple of time, to know if something was wrong with them
>> but MIPS people seem to not care about them. They even haven't
>> bothered to take 10 seconds for replying something like:
>>
>>   - your patches are broken because...
>>
>>   - your patches do not respect our MIPS protocol, please resend...
>>
>>   - Sorry we are very busy, please hold on...
> 
> You should interpret a non-answer as exactly this.
> 

Well, I usually do this interpretation at first but the patches were
posted more than one month ago and during this while you considered,
reviewed and applied several other patches.

Futhermore replying with a short email saying that you're _very_ busy
and you'll deal with them after 2.6.18 releasing would have been
welcome. And it would have taken less than 1 minute of your time.

>> Does the linux-mips team exist to ease life of its
>> customers to use the linux kernel on MIPS chips or is the purpose of
>> this team doing only some development for fun ?
> 
> You should draw a line between linux-mips.org and MIPS Technologies.
> linux-mips.org isn't a formal organization and not to be considered part
> of MTI.  If anything call it a loosely knit group of hackers with
> interest in running Linux and anything and all that has a MIPS processors.

Thanks for this clarification, which is a bit scaring, I wasn't aware
of this.

> There is more to be said I guess you rather want me to return to my
> pending patches ;-)
> 

yes please go ahead. Just note that this email is not an attack or
whatever, I'm just trying to understand what I'm doing wrong.

		Franck
