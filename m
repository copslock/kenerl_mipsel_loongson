Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 00:35:12 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.171]:49328 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20037406AbWJJXfJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 00:35:09 +0100
Received: by ug-out-1314.google.com with SMTP id 40so13562uga
        for <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 16:35:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=koBAu5PP1cblpA0D7ZmP3CRFWYhvSTgOMTHqOR5a4feIEJA7o+95EZsI2nLJSP4t+p66Mqozrc9uvdGYYeDz//sVNiT37UxD/QF9qGmBu4tbpPjl9GpOoNk65/BDrePAfSA6tpeN6iPD+QovOXX92eiI7BBtCE0WRmfdQOzi5/o=
Received: by 10.67.117.2 with SMTP id u2mr95061ugm;
        Tue, 10 Oct 2006 16:35:08 -0700 (PDT)
Received: by 10.66.241.10 with HTTP; Tue, 10 Oct 2006 16:35:08 -0700 (PDT)
Message-ID: <816d36d30610101635o5701a4clc362a6f07ac8173d@mail.gmail.com>
Date:	Tue, 10 Oct 2006 19:35:08 -0400
From:	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
To:	ashlesha@kenati.com
Subject: Re: calibrate_delay function
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1160523270.8185.4.camel@sandbar.kenati.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1160520180.6521.29.camel@sandbar.kenati.com>
	 <452C20FC.6000705@mvista.com>
	 <1160523270.8185.4.camel@sandbar.kenati.com>
Return-Path: <mendoza.ricardo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mendoza.ricardo@gmail.com
Precedence: bulk
X-list: linux-mips

On 10/10/06, Ashlesha Shintre <ashlesha@kenati.com> wrote:
> i can see why the kernel is stuck -- its because ticks=jiffies is the command just before infinitely looping based on the condition that ticks==jiffies!
> Am I not looking in the right place?

The delay loop calibration relies on a working system timer, if you
haven't setup and started a timer for your board, the jiffies will
never be incremented ergo indefinitely looping in this place.

This information can probably be found under Porting, on the l-m.o
wiki. Check there if you have any other problems in the process of
writing your board specific code.


     Ricardo
