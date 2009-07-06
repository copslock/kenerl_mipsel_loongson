Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2009 16:58:57 +0200 (CEST)
Received: from mail-fx0-f212.google.com ([209.85.220.212]:51861 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491847AbZGFO6u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2009 16:58:50 +0200
Received: by fxm8 with SMTP id 8so3763346fxm.0
        for <multiple recipients>; Mon, 06 Jul 2009 07:51:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=wTxBWYAVB2Kt+SfcbT6+WJePMbrTgqKkeh6eXLPGB6Y=;
        b=NdQQXGHrLvjBoA9TOK7CNdIiFIRt/izrrFtEfaPj/fnX/Ma+yFtnaYaSB+PxUAo/4G
         qy0qB/TLp8hi6yoRPzskTkNQ+CgCnOO07gaLjjZdPDAJlPcuuBnICmjv7iju8Ooq6+EY
         vR1UTqHNHvGI3Lo0LcpzFZ5vBdOHgiZPBmFI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=VqMLzffD5/sESGi9ca3d27KDlLPwbqU2hUT1ojLpNXUXnj2iACkAG2IYM+NJG69Pq/
         YWlhOA5KLhhzJsW6gbpn0jXvyK670vclK6Kc6jUssZBQtlsnQg514F+U2oalrlS8NGj2
         6CX9z0hg9bA2ovKm6Sl6AZGupoJ5+WVecIb/Q=
Received: by 10.103.198.20 with SMTP id a20mr2675679muq.29.1246891910876;
        Mon, 06 Jul 2009 07:51:50 -0700 (PDT)
Received: from localhost.localdomain (chello089077034197.chello.pl [89.77.34.197])
        by mx.google.com with ESMTPS id 25sm24970mul.20.2009.07.06.07.51.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Jul 2009 07:51:49 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	wuzhangjin@gmail.com
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Date:	Mon, 6 Jul 2009 16:57:59 +0200
User-Agent: KMail/1.11.4 (Linux/2.6.31-rc2-next-20090706-03300-ga0c36f0; KDE/4.2.4; i686; ; )
Cc:	Jeff Chua <jeff.chua.linux@gmail.com>,
	Etienne Basset <etienne.basset@numericable.fr>,
	David Miller <davem@davemloft.net>, rjw@sisk.pl,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera> <200907031508.47891.bzolnier@gmail.com> <1246635096.16890.6.camel@falcon>
In-Reply-To: <1246635096.16890.6.camel@falcon>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200907061658.00936.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Friday 03 July 2009 17:31:36 Wu Zhangjin wrote:
> Hi,
> 
> > OK, I see another gotcha added by recent changes, we need to explicitly
> > initialize rq_in_flight variables now.  Revised patch below..
> > 
> 
> Sorry, STD also not work. if apply this patch, the same problem as not
> apply it, it stopped at:
> 
> ...
> PM: Crete hibernation image:
> PM: Need to copy ... pages
> PM: Hibernation image created ...
> 
> I think it's better to revert this commit:
>  a1317f714af7aed60ddc182d0122477cbe36ee9b ("ide: improve handling of
> Power Management requests")
 
I completely agree and I've already requested this a week ago
(this commit was not meant for going straight to -rc tree anyway).
