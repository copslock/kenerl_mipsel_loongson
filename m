Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9CGPBA24680
	for linux-mips-outgoing; Fri, 12 Oct 2001 09:25:11 -0700
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9CGP4D24677
	for <linux-mips@oss.sgi.com>; Fri, 12 Oct 2001 09:25:04 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 12 Oct 2001 16:26:32 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id JAA20790;
	Fri, 12 Oct 2001 09:23:36 -0700 (PDT)
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id LAA18851; Fri, 12 Oct 2001 11:23:03 -0500
Message-ID: <3BC719CD.8060303@esstech.com>
Date: Fri, 12 Oct 2001 11:26:53 -0500
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Harrell <jharrell@telogy.com>
CC: linux-mips@oss.sgi.com
Subject: Re: VisionClick debugger with Linux kernel
References: <3BC36684.6020609@esstech.com> <3BC6F26B.E386F412@telogy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks for the response.  I just found the problem last night.  Their
convert utility was screwing up on files that had module_init and
module_exit routines in them, even though it wasn't compiled as a module.
I fixed it by replacing the __init and __exit macros with nothing so
the code is placed in a normal .text segment.

Gerald


Jeff Harrell wrote:
> Gerald Champagne wrote:
> 
>     Has anyone used the Wind River VisionClick debugger with the Linux
>     kernel?
>     I'm using this debugger and works great except it thinks that the
>     symbols
>     for some files start at address zero instead of the proper offset. 
>     Has anyone
>     else seen this and were you able to get it to work?  I'm using the
>     latest tools
>     from:
> 
>     ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/RPMS/i386/toolchain-mips-20010830-1.i386.rpm
> 
> 
>     I can't find any differences between the files that work and the
>     files that
>     don't work and the symbols look correct in the System.map file.
> 
>     Yeah, I'm working with Wind River, but I haven't gotten a solution yet.
>     You know how that 8-5 centralized corporate support is though. :)
> 
>     Thanks!
> 
>     Gerald
> 
> We are using a VisionIce debugger from the linux-mips kernel, although I 
> am using the
> MontaVista Hardhat 2.0 tools.   I am able to load the symbols after they 
> have been
> generated from the Convert utility.  It seems to work fine except for 
> modules...haven't
> had much luck with that.  Had to get a patch to view TLB mapped memory 
> properly
> though.
> 
> Jeff
> 
> -- 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> \ Jeff Harrell  (jharrell@telogy.com)               \
> \ Telogy Networks                                   \
> \ Broadband Access Group                            \
> \                                                   \
> \ Work: (301) 515-6537                              \
> \ Fax:  (301) 515-6637                              \
> \~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>  
