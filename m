Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 11:05:44 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.225]:282 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022110AbXH2KFf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 11:05:35 +0100
Received: by nz-out-0506.google.com with SMTP id n1so96774nzf
        for <linux-mips@linux-mips.org>; Wed, 29 Aug 2007 03:05:17 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aztC+ntvi6hiWIvgknHtiCmneoZc3DEhYQqbLpRZBG2Us3TWnn4XQnuOm0idL5/Vrzm2VyHREdrcOhovx/yh5n3ZHu+gmT1KCHrSkFH9ujdToFstT0JYX97ypT+rFCHCW2HvY1bGluU76Z753kGWh3DjoFxdNci9do+Z+beD0Os=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I6fjujAYyT8PAbOXqNFng2SXCUx/AFei9DO2RcSEGCe6QP6d4Odi2ya46JqD5HxYzVtthpXF61C9kEaaMSZXH7fhVYgx1z8MmGhkEQSi5fRwMVwI2hC6Tj5quYL77iMH9+fMkyV7ymUAExMW1qz+F/TyCA0vYUd+1sj2RBGEvW8=
Received: by 10.141.76.21 with SMTP id d21mr251582rvl.1188381916283;
        Wed, 29 Aug 2007 03:05:16 -0700 (PDT)
Received: by 10.141.189.13 with HTTP; Wed, 29 Aug 2007 03:05:16 -0700 (PDT)
Message-ID: <816d36d30708290305i4b34ae11s4b469cc48fb999aa@mail.gmail.com>
Date:	Wed, 29 Aug 2007 06:05:16 -0400
From:	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
To:	"Giuseppe Sacco" <giuseppe@eppesuigoccas.homedns.org>
Subject: Re: Exception while loading kernel
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1188377693.7270.1.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1188030215.13999.14.camel@scarafaggio>
	 <1188196563.2177.13.camel@scarafaggio> <46D2CB0F.7020505@27m.se>
	 <1188321514.6882.3.camel@scarafaggio>
	 <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>
	 <20070829084622.156798b4.giuseppe@eppesuigoccas.homedns.org>
	 <816d36d30708290133w677756bbla8b8b2b25fe005f1@mail.gmail.com>
	 <1188377693.7270.1.camel@scarafaggio>
Return-Path: <mendoza.ricardo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mendoza.ricardo@gmail.com
Precedence: bulk
X-list: linux-mips

On 8/29/07, Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org> wrote:

> I already tried the 32bit kernel and I found the same problem. Are you
> telling me that I should use 32bit for debugging instead of 64?

No, what I'm telling you to do is to try and build it with
CONFIG_BUILD_ELF64 disabled, more explicitly that is under Executable
file formats or something like that. About kgdb debugging, what I am
telling you is that ip32 has no hook ups coded for it yet, in other
words, no support.


     Ricardo
