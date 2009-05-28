Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 15:32:19 +0100 (BST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:53456 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024466AbZE1OcL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 15:32:11 +0100
Received: by pxi17 with SMTP id 17so4892687pxi.22
        for <multiple recipients>; Thu, 28 May 2009 07:32:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=BcvcVAgGhu1tyBf8gAB4W08CuJ/+tZydaPKkiWOEvW8=;
        b=aTP6yXsKViE7YntqV5BczCuI0Re8XwE0ZdHupHvQJ2wwb+3da4WXY1vHTRI04jVQCv
         z6NMC1gRkA8Gz0xCdPv+c2aibir1GFVZT3yNUjvPWz6e/2QHpShYgPOuvroe8wqgyr73
         Gf54SxYS+Q1O8N19vAfN3aEzPi1g7Dl+j1yTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=qk3PNRj9P0Ii6e9wshV/p+sK2C35jqtkZdYD3335wchHWODRWbOE/cSdjB+m1RdMY7
         1mgzGKuBqYrJaRL8MErBza46n0PFxVs3DHFAxLIUjoRb4908OCFmy8BI1tCBPEnPhQhW
         HzfU2EYB0l7QQMs7icjlcGbNWDcni45bUAG4Q=
Received: by 10.114.113.16 with SMTP id l16mr1488173wac.21.1243521124267;
        Thu, 28 May 2009 07:32:04 -0700 (PDT)
Received: from ?192.168.2.239? ([202.201.14.140])
        by mx.google.com with ESMTPS id n33sm96853wag.34.2009.05.28.07.31.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 07:32:02 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Handle removal of 'h' constraint in GCC 4.4
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Richard Sandiford <rdsandiford@googlemail.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-mips@linux-mips.org
In-Reply-To: <200905281331.41440.florian@openwrt.org>
References: <1229567048-19219-1-git-send-email-ddaney@caviumnetworks.com>
	 <alpine.LFD.1.10.0812190041080.6463@ftp.linux-mips.org>
	 <87wsdl63xv.fsf@firetop.home>  <200905281331.41440.florian@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Thu, 28 May 2009 22:31:45 +0800
Message-Id: <1243521105.5183.5.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, 

On Thu, 2009-05-28 at 13:31 +0200, Florian Fainelli wrote:
> Le Saturday 27 December 2008 16:19:40 Richard Sandiford, vous avez écrit :
> > "Maciej W. Rozycki" <macro@linux-mips.org> writes:
> > > On Wed, 17 Dec 2008, David Daney wrote:
> > >> This is an incomplete proof of concept that I applied to be able to
> > >> build a 64 bit kernel with GCC-4.4.  It doesn't handle the 32 bit case
> > >> or the R4000_WAR case.
> > >
> > >  The R4000_WAR case can use the same C code -- GCC will adjust code
> > > generated as necessary according to the -mfix-r4000 flag.  For the 32-bit
> > > case I think the conclusion was the only way to get it working is to use
> > > MFHI explicitly in the asm.
> >
> > No, the same sort of cast, multiply and shift should work for 32-bit
> > code too.  I.e.:
> >
> > 		usecs = ((uint64_t)usecs * lpj) >> 32;
> >
> > It should work for both -mfix-r4000 and -mno-fix-r4000.
> 
> Any updates on this ?

I have updated it to this PATCH, could you help to review it?



[loongson-PATCH-v2 20/23] add gcc
4.4 support for MIPS and loongson

thx!
Wu Zhangjin
