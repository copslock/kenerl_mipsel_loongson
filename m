Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2007 13:25:41 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:32471 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022736AbXHaMZc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 31 Aug 2007 13:25:32 +0100
Received: by nf-out-0910.google.com with SMTP id 30so693168nfu
        for <linux-mips@linux-mips.org>; Fri, 31 Aug 2007 05:25:15 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=OGJQLCB7wC/Nlrle7KbQ7teUGsES+MIof+KTpmhSSQzQszAWUGDAgt8194amM6KVFEGnjwqNVNHAWQh7OQO33vbjgF0TAfFgMoic29jlr7zmuNv2x9IIxEtdFTMIMstusLVcPkIfzS1mDGB9tDSMf20WIAPOq7eums32GtL9Pfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Yb1e5+j7DcG8TisWYeK+R4GQQHHD2NQY5l1zZsvSzyQQxSSs7swulUBFupnKPoZRuE2ofYIiFXVkmjJWomKvFC1QR4W+EoD7IYVOPlpm8S2TnL96n0KBMMUCv1Wdv30jXGR/Mmd17wCdlcZvOG9WCI5lzOY6X8Xj5sKI86DAFVU=
Received: by 10.82.174.20 with SMTP id w20mr3555111bue.1188563114220;
        Fri, 31 Aug 2007 05:25:14 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 28sm3136892fkx.2007.08.31.05.25.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Aug 2007 05:25:13 -0700 (PDT)
Message-ID: <46D8089F.3010109@gmail.com>
Date:	Fri, 31 Aug 2007 14:25:03 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: flush_kernel_dcache_page() not needed ?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I noticed that there's currently (v2.6.23-rc4) no implementation
of this function even for mips CPUs that have dcache aliasing.

Could anybody explain why ?

thanks,
		Franck
