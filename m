Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2006 13:49:10 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.189]:27740 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037767AbWLHNtF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Dec 2006 13:49:05 +0000
Received: by nf-out-0910.google.com with SMTP id l24so1083020nfc
        for <linux-mips@linux-mips.org>; Fri, 08 Dec 2006 05:49:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EnF16Gvam6YiVWMN6rGcqgwUc0psRjKWoNit6H/5RE/0f+RRrLwsVxjXZW2NV0WKLEWzkABsipjcxJ9PN87tzsNH+dT3Ly6T3rNSbJKaSBl/4pBQi/HbYzaMxscEPIpLAfwn7O3MOMXCcFQztULeZZ444xnGV7suNVqU1quwkQA=
Received: by 10.82.123.16 with SMTP id v16mr309544buc.1165585744753;
        Fri, 08 Dec 2006 05:49:04 -0800 (PST)
Received: by 10.82.108.6 with HTTP; Fri, 8 Dec 2006 05:49:04 -0800 (PST)
Message-ID: <acd2a5930612080549m74abadfeg62ce3336adbf654e@mail.gmail.com>
Date:	Fri, 8 Dec 2006 16:49:04 +0300
From:	"Vitaly Wool" <vitalywool@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH][respin] add STB810 support (Philips PNX8550-based)
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20061208130806.GA7439@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061208114035.000049c4.vitalywool@gmail.com>
	 <20061208130543.GB5797@linux-mips.org>
	 <20061208130806.GA7439@linux-mips.org>
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/8/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Dec 08, 2006 at 01:05:43PM +0000, Ralf Baechle wrote:
>
> Hmmm...
>
>   CC      arch/mips/philips/pnx8550/common/setup.o
> arch/mips/philips/pnx8550/common/setup.c:27:34: error:
> linux/serial_pnx8xxx.h: No such file or directory
> arch/mips/philips/pnx8550/common/setup.c: In function 'plat_mem_setup':
> arch/mips/philips/pnx8550/common/setup.c:147: error: 'PNX8XXX_UART_LCR_8BIT'
> undeclared (first use in this function)
> arch/mips/philips/pnx8550/common/setup.c:147: error: (Each undeclared
> identifier is reported only once
> arch/mips/philips/pnx8550/common/setup.c:147: error: for each function it
> appears in.)
> make[1]: *** [arch/mips/philips/pnx8550/common/setup.o] Error 1
> make: *** [arch/mips/philips/pnx8550/common] Error 2

That's due to my serial rework for 8550 still being ignored, even
though it has been accepted basically by rmk just before he quitted
mainstaining serial stuff .

The latest repost was yesterday: http://lkml.org/lkml/2006/12/7/147.
I don't know what else to do to make it seen by anyone :(

Vitaly
