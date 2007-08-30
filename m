Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2007 14:55:11 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.236]:21910 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022431AbXH3NzD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Aug 2007 14:55:03 +0100
Received: by wx-out-0506.google.com with SMTP id h30so483476wxd
        for <linux-mips@linux-mips.org>; Thu, 30 Aug 2007 06:54:45 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t00tLg4hanCCJpHrxNbTqYW3zXt14MbTqRQVns9XfzA/dIc1C+WrseF8yFGEm9m5zxFz9pYtkEEks/FzPnMMEpJlBvrk5zqsyjTnDGMiZ+AR5DZOU9DDY23Wb7bB3QA8MKGf8HBPN/px8TUKaOygXGaQ+w6a85BwvSu6bDUZ4HU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SpNELESd/puH31vf5cVeG9niayGHzSGLVrWI3I/x8L7H8dWsWA1SbZwu8seNSTaOUKN5yxRZmNflH0nu0B2Z4zvdxrRa5IeBXf6Z2hX6HXHwQuy/Sz26K2YinAVuvO3wKUO/4AaAy+lKm/pIURoNWz/DpSlYPMtF7PEQJqC9UdM=
Received: by 10.90.118.8 with SMTP id q8mr488099agc.1188482085085;
        Thu, 30 Aug 2007 06:54:45 -0700 (PDT)
Received: by 10.90.63.9 with HTTP; Thu, 30 Aug 2007 06:54:45 -0700 (PDT)
Message-ID: <9a8748490708300654l3e2acbbdkc2cbf01838a2fffa@mail.gmail.com>
Date:	Thu, 30 Aug 2007 15:54:45 +0200
From:	"Jesper Juhl" <jesper.juhl@gmail.com>
To:	bamakhrama@gmail.com
Subject: Re: Average number of instructions per line of kernel code
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <40378e40708300648i4f016906v60f821bf182a5633@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <40378e40708300600h5837d46ci5266b8ae62bbd46e@mail.gmail.com>
	 <9a8748490708300631o285fd31ch462199ec9535c6c2@mail.gmail.com>
	 <40378e40708300648i4f016906v60f821bf182a5633@mail.gmail.com>
Return-Path: <jesper.juhl@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.juhl@gmail.com
Precedence: bulk
X-list: linux-mips

On 30/08/2007, Mohamed Bamakhrama <bamakhrama@gmail.com> wrote:
> On 8/30/07, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 30/08/2007, Mohamed Bamakhrama <bamakhrama@gmail.com> wrote:
> > > Hi all,
> > > I have a question regarding the average number of assembly
> > > instructions per line of kernel code. I know that this is a difficult
> > > question since it depends on many factors such as the instruction set
> > > architecture, compiler used, optimizations used, type of code, coding
> > > style, etc...
> > > I would like to know a rough estimate for such a quantity for the
> > > kernel 2.4/2.6 code running on MIPS32 architecture.
> > > My estimate is between 5-10 instructions. I googled for such a thing
> > > but couldn't find any useful papers/resources.
> > >
> >
> > Why don't you simply count the number of non-blank non-comment lines
> > in the source files that you are building, build the kernel and then
> > count the number of instructions in the resulting binary ?
>
> Hi,
> I agree with you but is there any way to include ALL the drivers in
> the kernel tree in building the image? Otherwise, I will be counting
> un-used lines.
>
make allyesconfig
make


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
