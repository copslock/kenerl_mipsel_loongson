Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g24Norf03248
	for linux-mips-outgoing; Mon, 4 Mar 2002 15:50:53 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g24Non903239;
	Mon, 4 Mar 2002 15:50:49 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g24MlZB10348;
	Mon, 4 Mar 2002 14:47:35 -0800
Message-ID: <3C83FA43.4090407@mvista.com>
Date: Mon, 04 Mar 2002 14:50:43 -0800
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: William Jhun <wjhun@ayrnetworks.com>, linux-mips@oss.sgi.com
Subject: Re: Compressed images?
References: <20020304120803.A1247@ayrnetworks.com> <20020304145709.A1332@oss.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Mon, Mar 04, 2002 at 12:08:03PM -0800, William Jhun wrote:
> 
> 
>>I've been looking through the recent linux-mips archives and it seems
>>there isn't a concensus about where to build compressed ((b)zImage)
>>images. We have been placing our code under arch/mips/boot/compressed,
>>though it seems that the latest oss tree doesn't have such a directory,
>>and the only reference I can find to building a compressed image is in
>>galileo-boards/ev64120/compressed/.
>>
>>Should we be placing our boot image compression stuff in our
>>platform-specific directory? Are most MIPS-based Linux platforms not
>>using compressed images?
>>
> 
> General rant, not directed to you personally.  Right now we've got more
> than half a dozen variations of code to support compressed images throughout
> the kernel.  So I'm not going to accept any new patches for compressed
> images before this mess has been cleaned.  Volunteers :-)
> 


I think I am leaning towards leaving compressed image outside kernel itself.

I don't see any technical reason why it must be inside kernel.

Then it must be the code sharing argument.  However, it seem MIPS boards are 
so much more diversified than x86 machines.  Any sharing, if there are any, is 
limited.  Also there are other way of sharing code than stacking it into 
kernle tree, I suppose.

Another aimless general rant .... :-)

Jun
