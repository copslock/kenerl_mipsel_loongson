Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4VJfLnC012173
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 31 May 2002 12:41:21 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4VJfLH6012172
	for linux-mips-outgoing; Fri, 31 May 2002 12:41:21 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4VJfFnC012168
	for <linux-mips@oss.sgi.com>; Fri, 31 May 2002 12:41:15 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA02446;
	Fri, 31 May 2002 12:41:28 -0700
Message-ID: <3CF7D235.5@mvista.com>
Date: Fri, 31 May 2002 12:42:45 -0700
From: Steve Longerbeam <stevel@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>
CC: linux-mips-kernel@lists.sourceforge.net,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: [Linux-mips-kernel]TX 3912 framebuffer device
References: <Pine.LNX.4.44.0205311137230.28854-100000@www.transvirtual.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi James,

There's also a few fb drivers that Pete and I wrote that exist in
the linux-mips tree, and need porting to the new fbdev api. Are you
planning to do these also? These are au1100fb.c, epson1356fb.c, and
it8181fb.c.

Steve

James Simmons wrote:

>Can the video mode of this device be switched at run time or is it a
>static mode. I'm porting it to the new fbdev api and I want to get it
>right.
>
>   . ---
>   |o_o |
>   |:_/ |   Give Micro$oft the Bird!!!!
>  //   \ \  Use Linux!!!!
> (|     | )
> /'\_   _/`\
> \___)=(___/
>
>
>
>
>_______________________________________________________________
>
>Don't miss the 2002 Sprint PCS Application Developer's Conference
>August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
>
>_______________________________________________
>Linux-mips-kernel mailing list
>Linux-mips-kernel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-mips-kernel
>

-- 
Steve Longerbeam
MontaVista Software, Inc.
office:408-328-9008, fax:408-328-9204
http://www.mvista.com
