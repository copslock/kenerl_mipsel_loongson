Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 07:54:31 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:33897 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037641AbXBVHy0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Feb 2007 07:54:26 +0000
Received: by nf-out-0910.google.com with SMTP id l24so444238nfc
        for <linux-mips@linux-mips.org>; Wed, 21 Feb 2007 23:53:25 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=txr9r39RDfOq7shptOtrHZf4uNu7Qz+JeQP2a4B/XPV99fyL/iTHbolVcTEOcxiJg3t0tCwRV5H8s+mWFy/gEqFY2/lmjrppOLJMWD4qH3HwvW6gLRTq2JPUdd+WoQA013O4cNlZsvm2UMEEOarpF3vvDEGuqskbrjp2xgwAZXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T1ymqHeHL0nP/gFZgplB10uTDG0LA1DUWCE7ykKrngAneYjiRis/96EosvUm41KmqZlUB8IWcWBRrp+BurQQK2cFIWbB6t1VODY01ye0DmsjfvkB7yti/4S9MjxeLx8auKK49xSbktxYNrPyGuFckw5J+SHmEvYeFMjdg0/nfSY=
Received: by 10.82.187.16 with SMTP id k16mr65971buf.1172130805669;
        Wed, 21 Feb 2007 23:53:25 -0800 (PST)
Received: by 10.82.179.4 with HTTP; Wed, 21 Feb 2007 23:53:25 -0800 (PST)
Message-ID: <b115cb5f0702212353g4ee61a29ue0bd2636c811f297@mail.gmail.com>
Date:	Thu, 22 Feb 2007 13:23:25 +0530
From:	"Rajat Jain" <rajat.noida.india@gmail.com>
To:	"sathesh babu" <sathesh_edara2003@yahoo.co.in>
Subject: Re: unaligned access
Cc:	linux-mips@linux-mips.org
In-Reply-To: <566085.6765.qm@web7904.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <566085.6765.qm@web7904.mail.in.yahoo.com>
Return-Path: <rajat.noida.india@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rajat.noida.india@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/22/07, sathesh babu <sathesh_edara2003@yahoo.co.in> wrote:
> Hi,
>     I have ported linux-2.6.12 kernel on MIPS processor.I would like to
> print the warning messges whenenver kernel or user code  try to access
> unaligned address ( including proceor ID ).
>   Is there any configuration option  avaliable in the kernel to view
> the unaligned address?

Ummm ... not sure about MIPS, but in i386, exception 17 is raised for
every unaligned access. alignment_check() is invoked for every such
access.

Regards,

Rajat
