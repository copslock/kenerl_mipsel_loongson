Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 15:13:26 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.184]:7655 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021828AbXHAONY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 15:13:24 +0100
Received: by fk-out-0910.google.com with SMTP id f40so188567fka
        for <linux-mips@linux-mips.org>; Wed, 01 Aug 2007 07:13:05 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pqng43wNFsEnd7MqbjrTdRIw8ueJGdyKf0sJZqTIb1NbNPK6o4Cghp/rQRu376r7tX/LUNDV6N8lpVv+f/r1oMPaEfAXpbR/PNwUbCL3/gmfq7tsWVDPVaUuCBiU0RptFfE82yBVwF2iHQgC39hSreQN3lz1RJ7HIwKJ0xICJ+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qa+dESB4D6xdM40wkd9K+AwGADQI7f14+iLRxgEaIAOOkHSSH6q8pgDhH61baQjggIIKlKLUqyINTnAjwsJWBVTFjdQnToCQrMSowG8/stvn3JbttCv6REW1iFnYBmDOB5EKPKo2xsTVmM8x/AKPBGce5ztUz2hNaliNcTs8w8Y=
Received: by 10.82.134.12 with SMTP id h12mr877106bud.1185977585159;
        Wed, 01 Aug 2007 07:13:05 -0700 (PDT)
Received: by 10.82.148.14 with HTTP; Wed, 1 Aug 2007 07:13:05 -0700 (PDT)
Message-ID: <40378e40708010713p3d866a9dva7d69132e61497d6@mail.gmail.com>
Date:	Wed, 1 Aug 2007 16:13:05 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: cacheops.h & r4kcache.h
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070801140114.GA23858@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <40378e40708010618r7a93e58br206e7c47e685a05e@mail.gmail.com>
	 <20070801140114.GA23858@linux-mips.org>
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

On 8/1/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Aug 01, 2007 at 03:18:00PM +0200, Mohamed Bamakhrama wrote:
>
> > In those two header files, flush & invalidate operations were
> > implemented. Nevertheless, the MIPS32 core supports cache locking as
> > well. Is there any implementations for Fetch&Lock instructions within
> > the kernel?
>
> No.  The primary use for cache locking seems to be the rather extreme
> realtime requirements, a league where Linux isn't playing quite yet.
> For a more general purpose OS locking has a good chance of doing more
> harm than help.
>
>   Ralf
>

I agree with you that it fits more to real-time systems. My point was
that such a functionality can be added to the list of available macros
(i.e. Fetch, invalidate) so that when the developer (of an embedded
system for example) needs it, he/she can use it directly.

Is it possible to submit a patch which adds this functionality?

Regards,

--
Mohamed
