Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 17:10:32 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.168]:16347 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20026926AbXHHQKY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Aug 2007 17:10:24 +0100
Received: by ug-out-1314.google.com with SMTP id u2so247864uge
        for <linux-mips@linux-mips.org>; Wed, 08 Aug 2007 09:10:06 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U1bg/8wSiQRnLu61E0Y701GALePZEloNima/+haSd93xkOalixrOR0PcqbS5NNxwSzwKCfs0+T2tlRVYKAbqIsBNtmLzCp2U5efxhpM0dG6bNOh8R9xJijs2CsqYzL8j6Yg0b/uUAHFEfU7zvmsKzGdlVYEQnfFlfLd3BoB+Nhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lfpuj5mjeUTtbXTYLMcM4V7EJXDSmuVXy3eZLI46Lyj+migakj/rR5EMAkTvfvT90s5dowvVs1fihQtmcZz5gjzEr2LbBiTiceWfxktgDegAUJKZx4Spc2dOIPmplU3bqXVDDOIfLhc7smQHJhyOMjvpDRd5yWFwq13Hj6u28Zg=
Received: by 10.82.106.14 with SMTP id e14mr974550buc.1186589406242;
        Wed, 08 Aug 2007 09:10:06 -0700 (PDT)
Received: by 10.82.148.14 with HTTP; Wed, 8 Aug 2007 09:10:06 -0700 (PDT)
Message-ID: <40378e40708080910s5e39eda1k48367e221930c23d@mail.gmail.com>
Date:	Wed, 8 Aug 2007 18:10:06 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Problems with NFS boot
Cc:	"Steven J. Hill" <sjhill@realitydiluted.com>,
	"Alex Gonzalez" <langabe@gmail.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <20070808150944.GB13803@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <40378e40708080318w7dc0f0b7s4c94c98acd72ec2c@mail.gmail.com>
	 <20070808132116.GB12598@real.realitydiluted.com>
	 <40378e40708080755j79967334i5ef1146b88334c88@mail.gmail.com>
	 <20070808150944.GB13803@linux-mips.org>
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf rules :-)
It is working.
Thanks all for the support.


Best regards,

On 8/8/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Aug 08, 2007 at 04:55:42PM +0200, Mohamed Bamakhrama wrote:
>
> > I tried all the different combinations of passing the kernel command
> > line arguments but in vain. Moreover, I started a sniffer on the
> > server to see if it is able to get the packets from the kernel but it
> > turned out that it doesn't recv. anything!
>
> The Malta needs CONFIG_PCNET32 for the network driver which I don't see
> in your config.
>
>   Ralf
>


-- 
Mohamed A. Bamakhrama
Am Schaeferanger 15, room 035
85764 Oberschleissheim, Germany
Email: bamakhra@cs.tum.edu
Web: http://home.cs.tum.edu/~bamakhra/
Mobile: +49-160-9349-2711
