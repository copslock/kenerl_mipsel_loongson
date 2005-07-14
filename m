Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 17:03:56 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.201]:29791 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226711AbVGNQDj> convert rfc822-to-8bit;
	Thu, 14 Jul 2005 17:03:39 +0100
Received: by wproxy.gmail.com with SMTP id 68so453484wri
        for <linux-mips@linux-mips.org>; Thu, 14 Jul 2005 09:04:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RFqsvf2gX3JGgcq07Dh/rB1B2wBZxnQKroFHHGv5B4qn2mc1VMh5p1Q/74zL7jDjJrhAJxvHMGSPeYMF9cIL7zjFqb9TfHdsw0MYfHT1VklDc2Nn+eKLjVS4S3lwUxTuuOOKZZTt7lsJk+s6OJyRczlWJiwl/ndGqWYnMExWLVg=
Received: by 10.54.106.13 with SMTP id e13mr798423wrc;
        Thu, 14 Jul 2005 09:04:16 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 14 Jul 2005 09:04:16 -0700 (PDT)
Message-ID: <2db32b7205071409044c9f9317@mail.gmail.com>
Date:	Thu, 14 Jul 2005 09:04:16 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	ppopov@embeddedalley.com
Subject: Re: What is the current USB support status on DB1550?
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <1121356192.4797.362.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b7205071408327b005e4e@mail.gmail.com>
	 <1121356192.4797.362.camel@localhost.localdomain>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Is there big difference between Au1200 and Au1550? Any constrant on Au1550 ?
Thanks


On 7/14/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> On Thu, 2005-07-14 at 08:32 -0700, rolf liu wrote:
> > Are both usb host and usb gadget support as well? And the On the Go feature?
> 
> Host only. We couldn't make gadget work due to interrupt latency
> requirements by the HW that couldn't be reliably achieved with Linux.
> But gadget does work on the Au1200.
> 
> Pete
> 
> 
>
