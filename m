Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2007 14:32:22 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.239]:39885 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022388AbXH3NcO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Aug 2007 14:32:14 +0100
Received: by wr-out-0506.google.com with SMTP id 69so333833wri
        for <linux-mips@linux-mips.org>; Thu, 30 Aug 2007 06:31:12 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Colc8tCysxLzoeT3Qv7HbPTJX2PNM7vOrw+Dq7M75ZSq75FLT+V2W05q9sdvlpV3tz9sI9Vq+ErfwFOJ3RpZTnGQDKzVLqbo99OetNBLzY5DkSezpHqorfED2dxKQzB+wO+vGmJOVA3hZTCBvGh/bbv/DgHMymmYMw/7jWsv3So=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tbf/1dqadHJfjHu2WgCOHDNLGiBeBUtJDhp2bNz7IV7H21AafjbaK8rSlgTLKFCbtGAnzwZxBGHQyNeGhLHIvWQt7d/rh3c9cexxbwa+c1RLyKeJf1SeDKUV7/+tvKOaFo7eh640/ZTZrOs5umhAhDK39wTGWYNEfW+DgmW1ZU0=
Received: by 10.90.104.14 with SMTP id b14mr446632agc.1188480672561;
        Thu, 30 Aug 2007 06:31:12 -0700 (PDT)
Received: by 10.90.63.9 with HTTP; Thu, 30 Aug 2007 06:31:12 -0700 (PDT)
Message-ID: <9a8748490708300631o285fd31ch462199ec9535c6c2@mail.gmail.com>
Date:	Thu, 30 Aug 2007 15:31:12 +0200
From:	"Jesper Juhl" <jesper.juhl@gmail.com>
To:	bamakhrama@gmail.com
Subject: Re: Average number of instructions per line of kernel code
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <40378e40708300600h5837d46ci5266b8ae62bbd46e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <40378e40708300600h5837d46ci5266b8ae62bbd46e@mail.gmail.com>
Return-Path: <jesper.juhl@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.juhl@gmail.com
Precedence: bulk
X-list: linux-mips

On 30/08/2007, Mohamed Bamakhrama <bamakhrama@gmail.com> wrote:
> Hi all,
> I have a question regarding the average number of assembly
> instructions per line of kernel code. I know that this is a difficult
> question since it depends on many factors such as the instruction set
> architecture, compiler used, optimizations used, type of code, coding
> style, etc...
> I would like to know a rough estimate for such a quantity for the
> kernel 2.4/2.6 code running on MIPS32 architecture.
> My estimate is between 5-10 instructions. I googled for such a thing
> but couldn't find any useful papers/resources.
>

Why don't you simply count the number of non-blank non-comment lines
in the source files that you are building, build the kernel and then
count the number of instructions in the resulting binary ?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
