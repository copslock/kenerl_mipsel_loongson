Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 01:27:10 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.204]:11310 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226323AbVGHA0u> convert rfc822-to-8bit;
	Fri, 8 Jul 2005 01:26:50 +0100
Received: by wproxy.gmail.com with SMTP id i31so321626wra
        for <linux-mips@linux-mips.org>; Thu, 07 Jul 2005 17:27:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rZmt+YUOTF7Y1USzcojm++pU0WehXF0tKI3Qj2RhlkUom5LmFAqGFsg2H8tYL2eDZIsVGIO7fchblveaaGZQ2vxgjb8Igog26JLGHPQ6urje1lUvZaG90TGn+g39Nuk33I0rB9HF+lpZRBlQoRb79WkPO0OlQw8RLgGxGn2YSiQ=
Received: by 10.54.26.9 with SMTP id 9mr1200321wrz;
        Thu, 07 Jul 2005 17:27:15 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 7 Jul 2005 17:27:13 -0700 (PDT)
Message-ID: <2db32b7205070717271365dd35@mail.gmail.com>
Date:	Thu, 7 Jul 2005 17:27:13 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: booting error on db1550 using linux 2.6.12 from linux-mips.org
Cc:	ppopov@embeddedalley.com,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <1120776436.317.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b7205070114172483d2dd@mail.gmail.com>
	 <1120253048.5987.16.camel@localhost.localdomain>
	 <2db32b72050701153566c83bb6@mail.gmail.com>
	 <1120257851.5987.37.camel@localhost.localdomain>
	 <2db32b7205070508504b675dd6@mail.gmail.com>
	 <1120756200.317.14.camel@localhost.localdomain>
	 <2db32b7205070711424c119780@mail.gmail.com>
	 <1120776436.317.57.camel@localhost.localdomain>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I don't have hardware now and will try that option tomorrow. But I
remembered I got the same output before I applied your patch. I wonder
if using the PCI clock as the sole input can help. I read about the
source code provide by HighPoint Technologies. They use
"pci_write_config_byte(dev, 0x5b, 0x21);" instead of
"pci_write_config_byte(dev, 0x5b, 0x23);".

will let you know the result tomorrow.

Thanks



On 7/7/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2005-07-07 at 19:42, rolf liu wrote:
> > Alan,
> > Tried your patch on db1550 and linux 2.6.12. It still doesn't work.
> > During the boot-up, the kernel will hang up right after it prints out:
> >
> > >>hdg: max request size: 128 KiB
> 
> > Any suggestion?
> 
> Its got started if it gets that far because the LBA48 status has been
> checked. What occurs if you boot with ide=nodma ?
> 
>
