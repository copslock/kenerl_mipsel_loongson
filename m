Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Nov 2004 18:26:53 +0000 (GMT)
Received: from web81001.mail.yahoo.com ([IPv6:::ffff:206.190.37.146]:57248
	"HELO web81001.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224859AbUKJS0r>; Wed, 10 Nov 2004 18:26:47 +0000
Message-ID: <20041110182638.80909.qmail@web81001.mail.yahoo.com>
Received: from [63.194.214.47] by web81001.mail.yahoo.com via HTTP; Wed, 10 Nov 2004 10:26:37 PST
X-RocketYMMF: pvpopov@pacbell.net
Date: Wed, 10 Nov 2004 10:26:37 -0800 (PST)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: HPT 371N kernel 2.4.26
To: "r.zilli" <r.zilli@ingredium.it>, linux-mips@linux-mips.org
In-Reply-To: <20041110092242.66375.qmail@ingredium.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


I have a small patch in my directory:
ftp.linux-mips.org:/pub/linux/mips/people/ppopov/2.4

Pete

--- "r.zilli" <r.zilli@ingredium.it> wrote:

> 
> Hi guys, 
> 
> there is a problem on HPT371N HD controller, it's
> working only if i compile 
> the kernel 2.4.26 with CONFIG_IDEPCI_SHARE_IRQ flag.
> It is not completely working, in the sense that
> during the phase of writing 
> the machine is frozen.
> Meanwhile on the evaluation board Au1500 with
> HPT370A it's working very 
> well. 
> 
> Anyone have patch this? 
> 
> Roberto 
> 
> 
> 
