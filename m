Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 15:44:24 +0100 (BST)
Received: from ik-out-1112.google.com ([66.249.90.177]:17223 "EHLO
	ik-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022694AbXFGOoW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 15:44:22 +0100
Received: by ik-out-1112.google.com with SMTP id b35so448905ika
        for <linux-mips@linux-mips.org>; Thu, 07 Jun 2007 07:44:12 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B3Y9WFujKMzKjyfnQ5jL0ZazMAZyaffUlmQt37EzPlJW5xqhYfuqTNh127n/S7PAJm/jqFonexLNbNgvjMBycpAVIjvofUA7C/QDMX9JRW2Rjrq/D0MmxPO+zbrl9LCuFRT6I8hdArCRfSFnIPe3jQuFH5s+dB69pxTFngvRbOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IHjAgE1br5Ce4U3NzGfCFGSv+ApiXYiH6h0spFlqHDmanV86Fe+wz9Xmdp4EXZ/MruKQ2EGRDAdD/C/RtNip1AdTye0rFeABLZ+oeqv10XE2svxCdbvvJamZHNQaT2kKaPF298mBbtmfFTsA1zR+fjgagbeP97qOxqSyV+P2WjU=
Received: by 10.65.222.11 with SMTP id z11mr12371871qbq.1181227452011;
        Thu, 07 Jun 2007 07:44:12 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 7 Jun 2007 07:44:11 -0700 (PDT)
Message-ID: <cda58cb80706070744v21e1bbf3sa28990b4477a8844@mail.gmail.com>
Date:	Thu, 7 Jun 2007 16:44:11 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: Tickless/dyntick kernel, highres timer and general time crapectomy
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <46680B75.5040809@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070606185450.GA10511@linux-mips.org>
	 <cda58cb80706070059k3765cbf6w7e8907a2f0d83e1d@mail.gmail.com>
	 <20070607113032.GA26047@linux-mips.org>
	 <cda58cb80706070611t3083f026p769e3e1beee1f11e@mail.gmail.com>
	 <46680B75.5040809@ru.mvista.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

[ weird, Gmail thought you were a spamer... ]

Sergei Shtylyov wrote:
>
>    No, it doesn't. Even on dyntick kernels, interrupts do happen several
> times a second. Dynticks have nothing to do with disabling timer
> interrupts...
>

That's true however if your system has 2 clock devices. One is the r4k-hpt
and the other one soemthing else with a higher rating. If you don't stop
r4k-hpt interrupts, how does it work ?

-- 
               Franck
