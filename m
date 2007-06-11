Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2007 15:12:48 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.178]:15772 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024020AbXFKOMq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Jun 2007 15:12:46 +0100
Received: by py-out-1112.google.com with SMTP id f31so2704173pyh
        for <linux-mips@linux-mips.org>; Mon, 11 Jun 2007 07:12:44 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I2gi6Y4krSU6T1WNRhRcdq/lNyHjdlpG9pS4dHEvDp19E20UnNkzr6ULKhqPteB/sIbI94eG6iGrzMhDY96DMA2RDdYavzydWxaM7MCtkEfCi1BBuBU33nZ1hl8ec7/w+vXlSubZ/eY/mCplzWjYMKk7E7AmwVdKDQiDJmwxHdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IStGQpUhtYKnP3G5/9WsZiPAULHuMm8/33RXFYLIKTuhXc5ryTN5TuX9FhatnpVlcXpXucfvwgN7Au0I5RZ0Ac+1UycXVKdoWoEQfruh+lLAC6Y90i+kGWHetNGs5opKfkX4ns1r6Qx0zdcv5Khiu7FWcDg3SD7knJKh6wxfeq0=
Received: by 10.65.200.8 with SMTP id c8mr4035975qbq.1181571162540;
        Mon, 11 Jun 2007 07:12:42 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Mon, 11 Jun 2007 07:12:42 -0700 (PDT)
Message-ID: <cda58cb80706110712x7b647a58l761d38e70f5769a1@mail.gmail.com>
Date:	Mon, 11 Jun 2007 16:12:42 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 2/3] Remove MIPS SEAD support
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.64N.0706111425110.6714@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11815673353523-git-send-email-fbuihuu@gmail.com>
	 <11815673362011-git-send-email-fbuihuu@gmail.com>
	 <Pine.LNX.4.64N.0706111425110.6714@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 6/11/07, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Mon, 11 Jun 2007, Franck Bui-Huu wrote:
>
> > Mips Sead support is deprecated and scheduled for removal
> > since September 2006.
>
>  Oh, is it?  The last time I tried it worked.  Have you tried it and
> failed to build?  That should be easy to fix.
>

Well I haven't tried to build it. I only took a look to the wiki and
get rid of listed deprecated boards... I thought that was an good
reason...
-- 
               Franck
