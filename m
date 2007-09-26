Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 14:37:14 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.185]:32859 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20029629AbXIZNhG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 14:37:06 +0100
Received: by mu-out-0910.google.com with SMTP id w1so2692123mue
        for <linux-mips@linux-mips.org>; Wed, 26 Sep 2007 06:36:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=nAOAJvCVBPqqY6pJXinQKUDnYKI2AYlO23cVidWMNRQ=;
        b=kAL7VcCd1iF9sVqa+pBZ21NcCTqabyt6aj8nZqPnhUkSKfcRJrbjsTW9QmJSeXAQPHE2WNvmImrcaXfjSZn86fVXDFsVZSOq7Aq3CwSZZUM7jzDVvCD2Qt/yFxcnxqCWQcNdkvKlDkvw9DZfMBXTEbPzAK0refmAhIMwKJQe6gw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rPgPaOmfqO5ddmei6rxYdspoHQOg+pdpBKNhQPlabzMtLop2dsZULnFTLh1GIrXq+zLrx5hKGMST/D1XqR9iZJJ8JV4VD9APvxpgbGPdRgoVcE3QkixqTBrH5A+t8BOexs1X81EA2eDKd/u9gInIsRE72FwzGPcjff+BhJ7jRdU=
Received: by 10.82.106.14 with SMTP id e14mr1502092buc.1190813805215;
        Wed, 26 Sep 2007 06:36:45 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id f7sm3334887nfh.2007.09.26.06.36.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Sep 2007 06:36:44 -0700 (PDT)
Message-ID: <46FA5FFA.1060704@gmail.com>
Date:	Wed, 26 Sep 2007 15:34:50 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
References: <20070925181353.GA15412@deprecation.cyrius.com> <46FA1260.4000404@gmail.com> <20070926091443.GA10236@deprecation.cyrius.com> <46FA2C39.9020503@gmail.com> <20070926102412.GK3337@deprecation.cyrius.com> <Pine.LNX.4.64N.0709261226340.30122@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0709261226340.30122@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 26 Sep 2007, Martin Michlmayr wrote:
> 
>>> Weird, all these symbols seem to be 32 bits ones...
>>>
>>> Could you put somewhere your vmlinux you're actually running ?
>> http://merkel.debian.org/~tbm/tmp/vmlinux.32
>> Note that I'm using "make vmlinux.32"
> 
>  It should not matter here -- the build is done using the ELF32 or ELF64 
> file format according to CONFIG_BUILD_ELF64 and if you request a target 

Except that if CONFIG_BUILD_ELF64 is set then we assume that the kernel
is linked in XKPHYS which results in Martin's crash since his kernel is
linked in CKSEG0.

If you can recall that was done for a micro-optimization in __pa() but it
was a huge mistake because it relies on the configuration of BUILD_ELF64
to be setup correctly by the user... So in this case there's no point to
set CONFIG_BUILD_ELF64='y' since it makes the kernel bigger and slower.
But it used to work until my change, so my own fault.

Now it's going to be fixed in v2.6.23 by Ralf's commit.

Martin, can you live with CONFIG_BUILD_ELF64='n' for now ?

		Franck
