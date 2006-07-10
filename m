Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2006 08:47:22 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:46428 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133398AbWGJHrK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Jul 2006 08:47:10 +0100
Received: by nf-out-0910.google.com with SMTP id x4so605431nfb
        for <linux-mips@linux-mips.org>; Mon, 10 Jul 2006 00:47:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=aaahY14kVIG/EC77uQ/Zv8QC8kqZK+t5CtaPi+nPtgrFg1c9TR0jpN8ldY+190P8wggtATymo+H9GksY7Y3RrdXsAf7zBmgfsAVP6GWSZ1koKrNQ6z3KMZq9aTtPn0rI7lG/uWOVvzF89MXqq3pJf/Aijk9rjUOLsdePGufKYRs=
Received: by 10.48.1.4 with SMTP id 4mr3500015nfa;
        Mon, 10 Jul 2006 00:47:08 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id x27sm3397448nfb.2006.07.10.00.47.07;
        Mon, 10 Jul 2006 00:47:08 -0700 (PDT)
Message-ID: <44B20723.3070409@innova-card.com>
Date:	Mon, 10 Jul 2006 09:52:03 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] sparsemem fix
References: <20060705.012244.96686002.anemo@mba.ocn.ne.jp> <44AB79D0.90002@innova-card.com> <20060705.192054.128618288.nemoto@toshiba-tops.co.jp> <20060706173235.GA4739@linux-mips.org> <cda58cb80607080747g66ac4357ya1f2cef89b4d868@mail.gmail.com> <20060709224653.GA20598@linux-mips.org>
In-Reply-To: <20060709224653.GA20598@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sat, Jul 08, 2006 at 04:47:39PM +0200, Franck Bui-Huu wrote:
> 
>> but the code seems to be in arch/mips/sgi-ip27, no ?
>>
>> BTW, Ralf, are there any needs for MIPS to support platforms whose
>> memory start is not 0 ? I have made a patch for that, and wondering if
>> it's worth to post it on the list...
> 
> Yes, while it's relativly rare such platforms do exist and they currently
> pay the price of wasting some memory for the allocation of unused entries
> in mem_map[].
> 

Ok I'll send that this week. I remember to have to replace CPHYSADDR()
macro with __pa() in boot init code still I don't if it's correct.

Can you tell me why we can't always use __pa() ?

Thanks

		Franck
