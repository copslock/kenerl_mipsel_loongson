Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 18:43:39 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.207]:17564 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8133932AbWEBRn1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 18:43:27 +0100
Received: by nz-out-0102.google.com with SMTP id j2so2631959nzf
        for <linux-mips@linux-mips.org>; Tue, 02 May 2006 10:43:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DRAiCSaxS8LV+XANCIV8Isq+cvmG5wQG/ZpMsZKZnOEJ8SW00tUpSkSzdRZOgHTJjJSQDu1Kq+uxPyLQ5JpTZOI/78ewmGCfSnwXKm12h947Bpx5ndwCVCMDEB3+3EqptSPr+wTu7oNVgAAg0blhGqCB3hAiVAXysyiTzgVhpFA=
Received: by 10.36.129.3 with SMTP id b3mr1538616nzd;
        Tue, 02 May 2006 10:43:26 -0700 (PDT)
Received: by 10.36.49.2 with HTTP; Tue, 2 May 2006 10:43:26 -0700 (PDT)
Message-ID: <cda58cb80605021043i1f7ca308mf895b62f16186bd1@mail.gmail.com>
Date:	Tue, 2 May 2006 19:43:26 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] Make interrupt handler works for all cases
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20060502094123.GB4301@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80605020055r2597bf3ds9fb380aab8cbf7b3@mail.gmail.com>
	 <20060502094123.GB4301@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/5/2, Ralf Baechle <ralf@linux-mips.org>:
> On Tue, May 02, 2006 at 09:55:51AM +0200, Franck Bui-Huu wrote:
>
> > specially when the kernel is mapped.
>
> At which time you're on very fragile ice because TLB instructions should
> better be executed from an unmapped address ...
>

So does it mean that MIPS arch can't provide reliable support for
running mapped kernel ?

--
               Franck
