Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4IKVvK06510
	for linux-mips-outgoing; Fri, 18 May 2001 13:31:57 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4IKVuF06507
	for <linux-mips@oss.sgi.com>; Fri, 18 May 2001 13:31:57 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4IKVr001145;
	Fri, 18 May 2001 13:31:53 -0700
Message-ID: <3B058614.6040302@mvista.com>
Date: Fri, 18 May 2001 13:29:08 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i586; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: en
MIME-Version: 1.0
To: Wayne Gowcher <wgowcher@yahoo.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Netscape on linux-mipsel ??
References: <20010518202342.25982.qmail@web11908.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Wayne Gowcher wrote:

>Dear All,
>
>Does anyone know if Netscape or any other browser has
>been compiled to run on linux mipsel ? All I can find
>so far are "x86" source for netscape.
>
>If it has, care to tell me the links where I may get
>it ?
>
>Alternatively, if no one knows of anyone having a
>working linux mipsel Netscape binary / rpm. Anyone
>care to guess the scope of attempting to modify the
>x86 or mips-sgi-irix sources to run on mips ?
>
We're pretty close on having both, be and le mips binaries.  You'll need 
a graphics card which has frame buffer driver support so that X can run 
on top of the FBdev driver.  Check with me again "later".

Pete
