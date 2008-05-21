Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2008 16:34:48 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.189]:28972 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20035920AbYEUPeq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 May 2008 16:34:46 +0100
Received: by ti-out-0910.google.com with SMTP id i7so1552097tid.20
        for <linux-mips@linux-mips.org>; Wed, 21 May 2008 08:34:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=R9wM46n/MrYBWZ/JK3uTLk4PzqK8ovfLPKVAdzonY2A=;
        b=FuydE57hiRtj3LSipr1vrdT0dehmmZXPFkixAuFAfqZvqfzldbpvIw12bEEngIKPeTVY3x26oppy+h0tr7/ODePKmSpfb5NSRHrGx8FzihxXuwziiuPYEh31pM/7atDbdSSUW6Eba+xg5i5Pltv6ZVcDJyC3sl7zPa0M1LtoaP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p/G6G7qPJJVWL8ahvzR2XF6YNoldRTodzZPdmRoxGNiySszO0mtHeL2N3NqKqT0zrwvMUJ9uUQqwmOW7hZnawgujlxaS/I3eawYVFFtpoXQaFhKYzMGvpue4Aj+za3F6JsuqP/2LlUZbv4tbD8CcDDS7CLv4+TerNeaEDMfLqnA=
Received: by 10.150.68.41 with SMTP id q41mr408550yba.101.1211384075742;
        Wed, 21 May 2008 08:34:35 -0700 (PDT)
Received: by 10.150.149.8 with HTTP; Wed, 21 May 2008 08:34:35 -0700 (PDT)
Message-ID: <310540780805210834v745502e9i308cbebfe0a0167e@mail.gmail.com>
Date:	Wed, 21 May 2008 09:34:35 -0600
From:	"Marc St-Jean" <bluezzer@gmail.com>
To:	"Adrian Bunk" <bunk@kernel.org>
Subject: Re: references from Makefiles to non-existent CONFIG variables
Cc:	linux-mips@linux-mips.org, Brian_Oostenbrink@pmc-sierra.com
In-Reply-To: <310540780805210817q177554acof9c5a60129a6a824@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <310540780805210817q177554acof9c5a60129a6a824@mail.gmail.com>
Return-Path: <bluezzer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bluezzer@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Adrian,

It did compile with all patches, but at the time I moved on from PMC,
several drivers patches needed more work and had not yet been accepted
in the upstream kernel tree.

The contact at PMC that took over the work was Brian Oostenbrink, I'm
forwarding this so he can answer you question.

Marc

> On Sat, May 17, 2008 at 04:45:58PM -0400, Robert P. J. Day wrote:
>
>  here's the current, unadulterated list of references from Makefiles
>
> to CONFIG variables that are not defined in any Kconfig file.  once
>
> again, enjoy.
>
> ...
>
> ===== MSPETH =====
>
> ./arch/mips/pmc-sierra/msp71xx/Makefile:obj-$(CONFIG_MSPETH) += msp_eth.o
>
> ...
>
> This PMC MSP71xx platform in the kernel was AFAIR never in a usable
> state (read: even compilation fails).
>
> Marc, will you (or anyone else) bring it into shape or should I send a
> patch removing it?
>
> rday
>
> cu
> Adrian
>
