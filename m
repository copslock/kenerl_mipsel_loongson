Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2008 11:31:47 +0100 (CET)
Received: from el-out-1112.google.com ([209.85.162.180]:60954 "EHLO
	el-out-1112.google.com") by lappi.linux-mips.net with ESMTP
	id S263459AbYC0Kbg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Mar 2008 11:31:36 +0100
Received: by el-out-1112.google.com with SMTP id z25so2318160ele.15
        for <linux-mips@linux-mips.org>; Thu, 27 Mar 2008 03:30:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TMbCzJIpX/UprdvRjiQ6+2IRdObVqb25W0AiXbHQzzU=;
        b=A5Ml2pY7Dnvp4sWCS+OAnFcVG5/uiXhjAa5nD296D2G9pEyulHx9MGypqnE8X7ScsDhGn+6ad2gsJGIQK/QrYq8LLWkdtuoZ+SVlf5VaLAnBi7jLzViZ8Oy8Z4lhQRU0IUiYI4Mgbye9UHIr+7JHpH5V5kdPLuXeEpWX4bhJLcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Byi3zasHC5QqjKJjMXuZEamenM8JPOzdh33FVTBxbS8n/vLoKKELjDGZoLoiNb3i4gOT7ueRgDCbD/b6lCO+l6tsu5cP+NQ4XaN2o2Fz594dC+cfEMEvGUliUZbuRod8H+77pAPGT2bwUe/vWXSM8DMhQgklUhgZOQBAPnloUPg=
Received: by 10.150.145.20 with SMTP id s20mr701970ybd.5.1206613859638;
        Thu, 27 Mar 2008 03:30:59 -0700 (PDT)
Received: by 10.150.138.4 with HTTP; Thu, 27 Mar 2008 03:30:59 -0700 (PDT)
Message-ID: <5a8aa6680803270330o1606b7e7u7d89c653828e61bd@mail.gmail.com>
Date:	Thu, 27 Mar 2008 12:30:59 +0200
From:	"Michael Wood" <esiotrot@gmail.com>
To:	"Ramgopal Kota" <rkota@broadcom.com>
Subject: Re: MTD Partitions Permissions at Run Time.
Cc:	linux-mips@linux-mips.org
In-Reply-To: <E06E3B7BBC07864CADE892DAF1EB0FBD0641257D@NT-SJCA-0752.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47E559B6.9010001@ru.mvista.com> <47E7EBFF.6020406@ru.mvista.com>
	 <E06E3B7BBC07864CADE892DAF1EB0FBD0641257D@NT-SJCA-0752.brcm.ad.broadcom.com>
Return-Path: <esiotrot@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: esiotrot@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 26, 2008 at 7:20 AM, Ramgopal Kota <rkota@broadcom.com> wrote:
> Hi ,
>
>  Ours is a embedded product with pre-defined flash partitions say "Boot"
>  , "Kernel" , "Rootfs" & "ProductData".
>  The kernel which is in the box (linux 2.6.14)has Boot partition as "RO"
>  (Read Only). We have a requirement in the field that the boot code
>  should be upgraded also.
>  Is there any possibility of changing the partition permissions at
>  run-time? If so how ?

Does "mtd unlock" not work?

-- 
Michael Wood <esiotrot@gmail.com>
