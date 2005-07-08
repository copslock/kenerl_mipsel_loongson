Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 20:27:30 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.194]:25968 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226360AbVGHT1N> convert rfc822-to-8bit;
	Fri, 8 Jul 2005 20:27:13 +0100
Received: by wproxy.gmail.com with SMTP id i34so490209wra
        for <linux-mips@linux-mips.org>; Fri, 08 Jul 2005 12:27:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jr+T7JPcqCgiNll7FLSWKAZrDl4je8EawpnlCm345h+q6a1Pn8jyyzneFpStn0G2cKg6oRX3+18RHLqntZjXg1aiKW7BPR8QQP6Ca+HQ3rI7z5s3KmI49kcplfMMk7MJAZG+SWIDq1YxM5yLYz79b658mGe58aPwaqNsRopwKOc=
Received: by 10.54.16.77 with SMTP id 77mr444407wrp;
        Fri, 08 Jul 2005 12:27:06 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Fri, 8 Jul 2005 12:27:06 -0700 (PDT)
Message-ID: <2db32b7205070812272ce04cb7@mail.gmail.com>
Date:	Fri, 8 Jul 2005 12:27:06 -0700
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
X-archive-position: 8415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Alan,

I tried ide=nodma as boot option. It doesn't work either. It stops at
the same place.

Then I used pci_write_config_byte(dev, 0x5b, 0x21); It works and can
boot with the hard disk.  I also tried to force the 372n timing with
the linux-mips cvs head, It also works fine.

I know using PCI Clock as the only timing could have some speed
problems. And forcing 372n timing is like a dirty hack.  Your
suggestion is really appreciated.

thanks



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
