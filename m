Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 16:49:14 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:9076 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023740AbXINPtG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Sep 2007 16:49:06 +0100
Received: by nf-out-0910.google.com with SMTP id c10so701250nfd
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2007 08:48:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=OveSp0v/NuiTRA6PXBjC40v4A4gCdeVru6BNuptMyCc=;
        b=pguzfOv8lEB4lF8NGksyhppbNhbge7nz3rISMuJxwK22MYv2uvKR3rudfAnn/qr2usodkv8HUqe9SPphODC2YkAkWwz5n14OJqSwpNoEyfmj5343kSVQr8mt5IR4XILcPuCxvHQEC1Bk7t/IxmA5HwWiyOfjmabt4T7/R7Frr6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Gj72BNeZrTI1oA/KrCh2+3XGVe8rBcIbvzVhTrgMc1Q/OoBBiN+LjlivtRkr4ZetJBh+V6zVNsgp9No1JFjzyBac/sC7dyX9tjhaZ7fhwEkjAGvQCKN78FXwrj2/XBbUZm98EnBu30LyF+0Klm1NFLILTJpDq1KxNU4HFagWcOc=
Received: by 10.86.28.5 with SMTP id b5mr1495279fgb.1189784926862;
        Fri, 14 Sep 2007 08:48:46 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 22sm2109869fkr.2007.09.14.08.48.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Sep 2007 08:48:44 -0700 (PDT)
Message-ID: <46EAAD21.3090403@gmail.com>
Date:	Fri, 14 Sep 2007 17:47:45 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
References: <46DD53BE.2070004@gmail.com>	<20070906.003320.25909195.anemo@mba.ocn.ne.jp>	<46EA4730.2070806@gmail.com> <20070914.232915.41199290.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070914.232915.41199290.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 14 Sep 2007 10:32:48 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> BTW, flush_cache_mm() flushes (write back + invalidate ) the whole
>> data cache unconditionnaly, but I'm wondering if it's really necessary
>> for cpus which don't have any cache aliasing issues. After all they're
>> equivalent to physical caches, aren't they ?
> 
> r4k_flush_cache_mm() returns immediately if !cpu_has_dc_aliases.
> 

oops you're right, I was actually looking at local_r4k_flush_cache_mm().

thanks,
		Franck
