Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 09:00:21 +0000 (GMT)
Received: from web52809.mail.yahoo.com ([IPv6:::ffff:206.190.39.173]:47779
	"HELO web52809.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224938AbVAaJAG>; Mon, 31 Jan 2005 09:00:06 +0000
Received: (qmail 9971 invoked by uid 60001); 31 Jan 2005 08:59:56 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=sQRrUV1CF5ic8eAndRuwWBJXIQ+rBjty+WFPjiTrHRmPmioTyOGOmC2UbrILlzpiG+40HOkbQu2LjgUJI3LidivqebypX2pYfzzptoSGRkLESJUbja8ekH1yym8IKAbhyvWQKT+COeKTGt+5ja9gggY7YkV6RCnFtxkUwIFIvzE=  ;
Message-ID: <20050131085956.9969.qmail@web52809.mail.yahoo.com>
Received: from [24.6.193.250] by web52809.mail.yahoo.com via HTTP; Mon, 31 Jan 2005 00:59:56 PST
Date:	Mon, 31 Jan 2005 00:59:56 -0800 (PST)
From:	Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: Problem with HIGHMEM implementation for 32 bit mips-el port
To:	Rishabh@soc-soft.com, linux-mips@linux-mips.org
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902C472FE1@soc-mail.soc-soft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <m_lachwani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m_lachwani@yahoo.com
Precedence: bulk
X-list: linux-mips

please provide the detailed boot log. Also, Please use
the latest 2.4 kernel

Thanks
Manish



--- Rishabh@soc-soft.com wrote:

> 
> Hi all,
> 
> I am working on MIPS32 port of linux (kernel version
> 2.4.18) for R4000
> processor. While compilation was fine but the kernel
> boot up panics in
> "init".
> 
> I have 128MB RAM on the system where 64MB is located
> at 0x00000000
> physical address and the other 64MB is located at
> 0x20000000.
> 
> Also how is the address map for mips defined
> (highmem)?
> 
> Regards,
> 
> Rishabh
> 
> 
> The information contained in this e-mail message and
> in any annexure is
> confidential to the  recipient and may contain
> privileged information. If you are not
> the intended recipient, please notify the sender and
> delete the message along with
> any annexure. You should not disclose, copy or
> otherwise use the information contained
> in the message or any annexure. Any views expressed
> in this e-mail are those of the
> individual sender except where the sender
> specifically states them to be the views of
> SoCrates Software India Pvt Ltd., Bangalore.
