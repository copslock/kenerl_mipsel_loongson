Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36H4Hk01465
	for linux-mips-outgoing; Fri, 6 Apr 2001 10:04:17 -0700
Received: from pobox.sibyte.com (pobox.sibyte.com [208.12.96.20])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36H4HM01462
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 10:04:17 -0700
Received: from postal.sibyte.com (moat.sibyte.com [208.12.96.21])
	by pobox.sibyte.com (Postfix) with SMTP
	id 9A04A205FD; Fri,  6 Apr 2001 10:04:11 -0700 (PDT)
Received: from SMTP agent by mail gateway 
 Fri, 06 Apr 2001 09:56:48 -0800
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158])
	by postal.sibyte.com (Postfix) with ESMTP
	id D49C01595F; Fri,  6 Apr 2001 10:04:11 -0700 (PDT)
Received: by plugh.sibyte.com (Postfix, from userid 61017)
	id D83A4686D; Fri,  6 Apr 2001 10:04:08 -0700 (PDT)
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: Pete Popov <ppopov@pacbell.net>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: edata alignment
Date: Fri, 6 Apr 2001 10:01:25 -0700
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain
References: <3ACD42DD.A9E0A0E7@pacbell.net>
In-Reply-To: <3ACD42DD.A9E0A0E7@pacbell.net>
MIME-Version: 1.0
Message-Id: <0104061004080D.00787@plugh.sibyte.com>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 05 Apr 2001, Pete Popov wrote:
> In arch/mips/kernel/head.S, there is this code in kernel_entry:
> 
>    la      t0, _edata
>    sw      zero, (t0)
> 
> What guarantees that edata will be word aligned? I don't see a .ALIGN
> directive in the ld.script so is it safe to assume that edata will
> always be at least word aligned?  I've linked into the kernel a very
> large ramdisk, and edata ends up being an odd address, causing a cpu
> fault. 

This was fixed between revs 1.4 and 1.5 in cvs @ oss.sgi.com

-Justin
