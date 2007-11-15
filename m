Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 08:46:50 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.190]:31084 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023678AbXKOIqm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Nov 2007 08:46:42 +0000
Received: by nf-out-0910.google.com with SMTP id c10so390314nfd
        for <linux-mips@linux-mips.org>; Thu, 15 Nov 2007 00:46:32 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=3V45Wj6xgswpitHtIwmcrgKRmENTDowigN2H9FkfzTM=;
        b=WsEZlysWLGn2lOJDbIW4vsbwz0hdUNvLlWkSE3q+JfZyp5Jd12ot0hAYxWv4HS1U+CcXYNbVH4lqjsRgJj9axOCklIbablg8SbNk0nhMAbOMTeJRKVz+sSV6t9lsXE181/VL4D+n37kCw8i/PorTVzDjD6YMRXFQuYJ0wjfjLOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=k2rFG1wQWYZ30bbZGaSY3Opf9VJ+n7Dt12pQV6H6gPLnFMvjs6u8T7TCN9kIc486pz7g2p0qhWd8sah4hrOhsLCIAbzn8HbgKvka0SFzSxPKmdon+QdxsoOZM4Z7W2LVMoAkrmfKXLXZbWJs4uyOImiyGfJK0U1wHrA3HGClOuk=
Received: by 10.86.9.8 with SMTP id 8mr414907fgi.1195116392123;
        Thu, 15 Nov 2007 00:46:32 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 22sm2295435fkr.2007.11.15.00.46.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Nov 2007 00:46:31 -0800 (PST)
Message-ID: <473C0761.1040205@gmail.com>
Date:	Thu, 15 Nov 2007 09:46:25 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: Cannot unwind through MIPS signal frames with	ICACHE_REFILLS_WORKAROUND_WAR
References: <473957B6.3030202@avtrex.com> <18233.36645.232058.964652@zebedee.pink> <20071113121036.GA6582@linux-mips.org>
In-Reply-To: <20071113121036.GA6582@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Another reason is to get rid of the classic trampoline the kernel installs
> on the stack.  On some multiprocessor systems it requires a cacheflush

BTW, could we get rid of the trampoline so easily ? I mean won't we have
to keep it for backward compatibility reasons ?

		Franck
