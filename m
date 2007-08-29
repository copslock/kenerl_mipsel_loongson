Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 09:33:51 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.176]:28465 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022076AbXH2Idm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 09:33:42 +0100
Received: by py-out-1112.google.com with SMTP id p76so2019229pyb
        for <linux-mips@linux-mips.org>; Wed, 29 Aug 2007 01:33:23 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ob0sx5ij5SO+u+mSnHw9yDRtZHpR+ft06bSBmDslBupXuCBZHLSe89bVZTCnGIdFZkcRu0E2IbeICwuOhylc8S8ofqheW411aWnQBVOu7E8FbFdF1O8SLkusl2AAUkniKVh9Voeu1TM8979KJnLVpXTgjIj46dT7JYgXiCBgmPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X+CRgZb7TuOZQqY3z1ncOZmj5zDQ3wlQNfU5RHJ2UG9E3FWUhqtqiJJjk/Edb0lgljM8vCfXlLmJXKxyjCKP0L114JIycmVNOB81hfM4mmwQaQkWMwJyQOeBM14fCulLvneW6b5yKtjzDsowOAJT/tWkM7U6VjiSUCHUTzIsqxk=
Received: by 10.140.169.4 with SMTP id r4mr227398rve.1188376402219;
        Wed, 29 Aug 2007 01:33:22 -0700 (PDT)
Received: by 10.141.189.13 with HTTP; Wed, 29 Aug 2007 01:33:22 -0700 (PDT)
Message-ID: <816d36d30708290133w677756bbla8b8b2b25fe005f1@mail.gmail.com>
Date:	Wed, 29 Aug 2007 04:33:22 -0400
From:	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
To:	"Giuseppe Sacco" <giuseppe@eppesuigoccas.homedns.org>
Subject: Re: Exception while loading kernel
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070829084622.156798b4.giuseppe@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1188030215.13999.14.camel@scarafaggio>
	 <1188196563.2177.13.camel@scarafaggio> <46D2CB0F.7020505@27m.se>
	 <1188321514.6882.3.camel@scarafaggio>
	 <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>
	 <20070829084622.156798b4.giuseppe@eppesuigoccas.homedns.org>
Return-Path: <mendoza.ricardo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mendoza.ricardo@gmail.com
Precedence: bulk
X-list: linux-mips

Try to build the kernel with CONFIG_BUILD_ELF64=n

Also, there's no support for kgdb on ip32 at the moment.


     Ricardo
