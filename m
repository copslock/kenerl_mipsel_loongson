Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5LMpc923199
	for linux-mips-outgoing; Thu, 21 Jun 2001 15:51:38 -0700
Received: from mms2.broadcom.com (mms2.broadcom.com [63.70.210.59])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5LMpbV23195
	for <linux-mips@oss.sgi.com>; Thu, 21 Jun 2001 15:51:37 -0700
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 MMS-2 SMTP Relay (MMS v4.7)); Thu, 21 Jun 2001 14:24:09 -0700
X-Server-Uuid: 2a12fa22-b688-11d4-a6a1-00508bfc9626
Received: from postal.sibyte.com (IDENT:postfix@[10.21.128.60]) by
 mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP id OAA14085 for
 <linux-mips@oss.sgi.com>; Thu, 21 Jun 2001 14:24:14 -0700 (PDT)
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158]) by
 postal.sibyte.com (Postfix) with ESMTP id AE5131595F for
 <linux-mips@oss.sgi.com>; Thu, 21 Jun 2001 14:24:14 -0700 (PDT)
Received: by plugh.sibyte.com (Postfix, from userid 61017) id DC0FC686D;
 Thu, 21 Jun 2001 13:29:49 -0700 (PDT)
From: "Justin Carlson" <carlson@sibyte.com>
Reply-to: carlson@sibyte.com
Organization: Sibyte
To: linux-mips@oss.sgi.com
Subject: Re: A confusing oops dump ...
Date: Thu, 21 Jun 2001 13:29:31 -0700
X-Mailer: KMail [version 1.0.29]
MIME-Version: 1.0
Message-ID: <01062113294906.00778@plugh.sibyte.com>
X-WSS-ID: 172CBA7328058-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 21 Jun 2001, you wrote:
> I got the following oops dump during a stress load, which I cannot make any
> sense out of it.  The most confusing part is that the status register
> indicates program was running in kernel (KSU bits) while the $epc points to a
> userland address.  How could this be ever possible at hardware level?

It's very possible at the hardware level...kernel mode enables access to
several segments; it doesn't disable mapped accesses.  I don't think it should
ever happen in linux, but there's nothing in the hardware that prevents this.

> 
> The only possible explanation is perhaps those saved registers were corrupted
> between when the exception happens and core dumps, but so unlikely .... *sigh*
> 
> Any insight?

You've got a TLBL exception, and va doesn't match epc, so
presumably the processor thinks it was a load and  not an ifetch that triggered
this.  It also follows that the processor thinks it found a valid instruction
at 0x10000.  If this is reproducable and the chip allows it, try dumping out
the icache when you hit this, see if 0x10000 really appears in there...

-Justin
