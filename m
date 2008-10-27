Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 11:53:45 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.157]:13818 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S22494774AbYJ0Lxj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Oct 2008 11:53:39 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1889106fga.32
        for <linux-mips@linux-mips.org>; Mon, 27 Oct 2008 04:53:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ATvgrl61707lfQ+MrXMgEs/dROPHBumgwX1G0Kacv80=;
        b=ipv2AmfsuOOfT/khnYn+KIaethS6c7+s4I1Qpg9c1xx7ih+A8uCA1kk7q8ZmaEWyJg
         AjaR7+aUGpl27+NBAP3iLnH8/N7LvmtTmjHXhkodKbzHAuWRY1FCoffRt4jDSDlGn7D3
         VqjMesAm59qktZXDXwrV0cq4Nnw9s62qpsN44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KYLdwoaYMkurJ9PN1aa61z4Cak9+gCvep7YYvQ6r6r7L8cO2ekrjEDKaVGqdT8FTq1
         CPxQ/zGxEDkJElNt5TMIM+zAxo7HBbq8McNYPCHYZ1PahwTdA0NqtHBi/8GX8Mhu5mAo
         9Ky4LGHo2Et4JaFkBeyXWtVXkMP+ryBTuiKyE=
Received: by 10.181.10.7 with SMTP id n7mr1772237bki.50.1225108414339;
        Mon, 27 Oct 2008 04:53:34 -0700 (PDT)
Received: by 10.180.239.14 with HTTP; Mon, 27 Oct 2008 04:53:34 -0700 (PDT)
Message-ID: <90edad820810270453s57954112m627859eac685f404@mail.gmail.com>
Date:	Mon, 27 Oct 2008 14:53:34 +0300
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] [MIPS] DS1286: kill BKL
Cc:	"Dmitri Vorobiev" <dmitri.vorobiev@movial.fi>,
	linux-mips@linux-mips.org
In-Reply-To: <20081027113948.GA13085@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1225106948-30550-1-git-send-email-dmitri.vorobiev@movial.fi>
	 <20081027113948.GA13085@linux-mips.org>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

2008/10/27 Ralf Baechle <ralf@linux-mips.org>:
> On Mon, Oct 27, 2008 at 01:29:08PM +0200, Dmitri Vorobiev wrote:
>
>> Using the Big Kernel Lock in the open() method of the DS1286
>> RTC driver is redundant, because the driver makes use of it's
>> own spinlock to guarantee serialized access. This patch kills
>> the redundant BKL calls.
>
> I'm about to kill the BKL in the driver even more thoroughly - by killing
> the entire driver.

Good idea ;)

Dmitri

>
>  Ralf
>
>
