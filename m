Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2005 14:53:42 +0100 (BST)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.193]:45261 "EHLO
	rproxy.gmail.com") by linux-mips.org with ESMTP id <S8225294AbVG0NxY> convert rfc822-to-8bit;
	Wed, 27 Jul 2005 14:53:24 +0100
Received: by rproxy.gmail.com with SMTP id c16so289243rne
        for <linux-mips@linux-mips.org>; Wed, 27 Jul 2005 06:55:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tjbMPGp6ruVfKJWgNBrNeO+V9qL/B1nfMuf6yTqc8w3En2Oqrt7yjriUuInAtsccKl/PLIA3I+8IiTCeS0NB+fgVORiJFxwkk7zY58eLaM1JPB0Aps+lZ2bmPSsufDLiNvDTMbYrUPNQcHjhXaohCOkOCUM83A7x8UJtqyH0gwQ=
Received: by 10.38.207.47 with SMTP id e47mr528429rng;
        Wed, 27 Jul 2005 06:55:58 -0700 (PDT)
Received: by 10.39.1.62 with HTTP; Wed, 27 Jul 2005 06:55:58 -0700 (PDT)
Message-ID: <dbce93020507270655d4a1c6@mail.gmail.com>
Date:	Wed, 27 Jul 2005 09:55:58 -0400
From:	David Cummings <real.psyence@gmail.com>
Reply-To: David Cummings <real.psyence@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: o32 glibc-2.3.5
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0507271059110.13819@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <dbce930205072612285bd70e1b@mail.gmail.com>
	 <Pine.LNX.4.61L.0507271059110.13819@blysk.ds.pg.gda.pl>
Return-Path: <real.psyence@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: real.psyence@gmail.com
Precedence: bulk
X-list: linux-mips

On 7/27/05, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Tue, 26 Jul 2005, David Cummings wrote:
> 
> > greatly appreciate it. I've been looking in glibc's bugzilla but can't
> > find the right bug. Thanks!
> 
>  #758
> 
>   Maciej
> 
Alright, thanks. I had found that, but it didn't seem to apply to the
problem with socket, as that had already been applied when the socket
happened. I'm also now having a problem with n32 which is similar if
not the same as the one Rolf had not too long ago. Something about a
__fork_block not being found. Anyplace else I should look? Thanks,
-Dave

-- 
The way that can be named is not the Way.
