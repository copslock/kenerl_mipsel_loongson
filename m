Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 11:27:04 +0000 (GMT)
Received: from wx-out-0506.google.com ([66.249.82.227]:62148 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038488AbXBVL1A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Feb 2007 11:27:00 +0000
Received: by wx-out-0506.google.com with SMTP id t14so141322wxc
        for <linux-mips@linux-mips.org>; Thu, 22 Feb 2007 03:25:57 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WDw09ozSkhX2iVKdcAWaBRh9+QqCxDxduTtXkfUd4VQEC3iYgvcg/5RdPTkvpLMlhzc7SAE9u4cTfzk6/L+5wnLRNk+vIZK/qxa7pTlToIg8gZlGzZcfX1PSD2qcPYbVVH3Wo4cUXaRFmQS0AOlbaoN/fdG+c2ND8q2sxZWQkt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EyVb8YUTIYcfxBgUHH0NSBLnrxDpcOlZandAJnTYpJ0nMYyBPg2nts9XcXyuSTPGSObsyMxX6LNriR/We71hurAzyeCoh1OW92nbw/zmiWzingrjxpXaJgnJ6nRUuu/YUdROpFs9+mPkuzOibtkFHU06IidFN4gPmuA6r6L23hQ=
Received: by 10.90.89.5 with SMTP id m5mr201339agb.1172143557378;
        Thu, 22 Feb 2007 03:25:57 -0800 (PST)
Received: by 10.90.51.4 with HTTP; Thu, 22 Feb 2007 03:25:57 -0800 (PST)
Message-ID: <f68850780702220325g5c4967a8nee36625d8d83bc04@mail.gmail.com>
Date:	Thu, 22 Feb 2007 16:55:57 +0530
From:	"Raseel Bhagat" <raseelbhagat@gmail.com>
To:	kernelnewbies <kernelnewbies@nl.linux.org>,
	newbie <linux-newbie@vger.kernel.org>, linux-mips@linux-mips.org
Subject: Re: not getting command prompt at the console
In-Reply-To: <20070222111115.GC31252@gateway.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b115cb5f0702220149wfbfc051qc8d0106b9e4ed98d@mail.gmail.com>
	 <20070222102540.GB31252@gateway.home>
	 <f68850780702220250x57f4f678re104caecfeec6ef2@mail.gmail.com>
	 <20070222111115.GC31252@gateway.home>
Return-Path: <raseelbhagat@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raseelbhagat@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 2/22/07, Erik Mouw <mouw@nl.linux.org> wrote:

> > Also , assuming you are using a serial console , check your entries in
> > the inittab file .
> > It should look  something like :
> > ttyS0::respawn:/sbin/getty ttyS0 115200 linux
>
> If the device is indeed called "ttyS0". Remember it's a MIPS board, not
> a peecee. For example, on StrongARM SA11x0 you need to use ttySA0
> instead of ttyS0.
>

Correct.  Thanks for the correction Erik.
My point being, you sould have such an entry in your inittab when
working on a serial console.
I have faced this problem before and spent hours trying to figure out
what was only a silly-mistake.
