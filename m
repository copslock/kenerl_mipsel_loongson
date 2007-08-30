Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2007 14:49:02 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.185]:35087 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022431AbXH3Nsx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Aug 2007 14:48:53 +0100
Received: by fk-out-0910.google.com with SMTP id f40so378398fka
        for <linux-mips@linux-mips.org>; Thu, 30 Aug 2007 06:48:35 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DV87nQhNGoAfamAHCeiqQmtsgwKewKd4FmBCUHVRTkQjJmVPBmqxCqG88/JOBkXFpNN3flFu9YaZVuWJD7MLZYUZO/TonLQ5kyuJvHVrdqKHFinnyjo7cFpndYjc6IWjRHnSJEvX3/3T0kFbHK2h3Hdj6IqElngKLMkhVvuvMp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cyUdk3x819m5NTw88WR1j3Ox6g7bNSXwjt66rsu4IM2wj62XEsaZ5GNrJyxXTBIh/cyTXy6KpinwnZd5LYf5uWeiR0uCv5u315pj39iW7PqnUWCYXjtsHTV7f7L8GU3VfjQnBLxwFBI7rK2aBCRx79Ajp6XSYm8qSVelbQfrrho=
Received: by 10.82.153.5 with SMTP id a5mr1146337bue.1188481715349;
        Thu, 30 Aug 2007 06:48:35 -0700 (PDT)
Received: by 10.82.148.14 with HTTP; Thu, 30 Aug 2007 06:48:35 -0700 (PDT)
Message-ID: <40378e40708300648i4f016906v60f821bf182a5633@mail.gmail.com>
Date:	Thu, 30 Aug 2007 15:48:35 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	"Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: Average number of instructions per line of kernel code
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490708300631o285fd31ch462199ec9535c6c2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <40378e40708300600h5837d46ci5266b8ae62bbd46e@mail.gmail.com>
	 <9a8748490708300631o285fd31ch462199ec9535c6c2@mail.gmail.com>
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

On 8/30/07, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 30/08/2007, Mohamed Bamakhrama <bamakhrama@gmail.com> wrote:
> > Hi all,
> > I have a question regarding the average number of assembly
> > instructions per line of kernel code. I know that this is a difficult
> > question since it depends on many factors such as the instruction set
> > architecture, compiler used, optimizations used, type of code, coding
> > style, etc...
> > I would like to know a rough estimate for such a quantity for the
> > kernel 2.4/2.6 code running on MIPS32 architecture.
> > My estimate is between 5-10 instructions. I googled for such a thing
> > but couldn't find any useful papers/resources.
> >
>
> Why don't you simply count the number of non-blank non-comment lines
> in the source files that you are building, build the kernel and then
> count the number of instructions in the resulting binary ?

Hi,
I agree with you but is there any way to include ALL the drivers in
the kernel tree in building the image? Otherwise, I will be counting
un-used lines.

-- 
Mohamed
