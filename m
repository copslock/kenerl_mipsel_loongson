Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2007 11:28:44 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.179]:58803 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024610AbXFTK2m (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Jun 2007 11:28:42 +0100
Received: by py-out-1112.google.com with SMTP id f31so262011pyh
        for <linux-mips@linux-mips.org>; Wed, 20 Jun 2007 03:27:40 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JlUhluXYH/u7yydPSV71LqTh7MM9z60Dor+jnIQY8YxEJlUUd0ibcLshvS9MXqCod3JFOWO1dbLTms3Zi07wovfMAcX8Xuv1wwvJ1MZWduppJCos8XXAVzAqpSpNlLBO2Maz89flefDcdToePxwHSaVWiIdA15VsmIrxtYoGzTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bLR0k3oeO2l/aOlXb3zXMjsNkx9N7zAnGxc1ocB4eK2DcTIkkvja6Kb1FpPz2usMzgptbZScLz16T4GheZGPSZMpnNUZ8eyQMulQ/Pb2koCRCCqj5YwZoOvGiKswE+YQqixfbrNiTRbHqQ28+tBKsmu4PhfZWaKFVl2EyttdvUQ=
Received: by 10.65.250.11 with SMTP id c11mr1098681qbs.1182335260273;
        Wed, 20 Jun 2007 03:27:40 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Wed, 20 Jun 2007 03:27:40 -0700 (PDT)
Message-ID: <cda58cb80706200327i7e1cba84if830f9df08d9a6a8@mail.gmail.com>
Date:	Wed, 20 Jun 2007 12:27:40 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, macro@linux-mips.org,
	linux-mips@linux-mips.org
In-Reply-To: <20070619215859.GA11831@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80706180238r17da4434jcdee307b0385729b@mail.gmail.com>
	 <20070619.005121.118948229.anemo@mba.ocn.ne.jp>
	 <cda58cb80706190033y47ccec58u8fc8254ced24f96f@mail.gmail.com>
	 <20070620.010805.23009775.anemo@mba.ocn.ne.jp>
	 <467802E3.4040703@ru.mvista.com>
	 <20070619215859.GA11831@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/19/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> For practically every type of timer there are reasons why it is may be
> undesierable such as being configured in a way that makes it undesirable
> or unusable, unpredictable clock changes and more.  So in practice only
> the platform specific code can drive the initialization of all timer
> devices and interrupts which reduces the generic code to sort of a
> library and driver collection.
>

Yeah that's true. If you look at time_init() arch hook after patch 5/5
is applied, you can see that it's now:

void __init time_init(void)
{
        plat_time_init();
        plat_timer_setup();
}

-- 
               Franck
