Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBACD1A27028
	for linux-mips-outgoing; Mon, 10 Dec 2001 04:13:01 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBACCwo27025
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 04:12:59 -0800
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16DOMd-0006Im-00; Mon, 10 Dec 2001 12:12:51 +0100
Date: Mon, 10 Dec 2001 12:12:51 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: linux-mips@oss.sgi.com
Subject: Re: Re: XF86Config & startup log
Message-ID: <20011210121251.B24000@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Zhang Fuxin <fxzhang@ict.ac.cn>, linux-mips@oss.sgi.com
References: <200112090437.fB94bVo27119@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112090437.fB94bVo27119@oss.sgi.com>; from fxzhang@ict.ac.cn on Sun, Dec 09, 2001 at 11:35:10AM +0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Dec 09, 2001 at 11:35:10AM +0800, Zhang Fuxin wrote:
[..snip..] 
>   1,rpm -i to install it,then cd /usr/src/redhat/SPECS and rpm -bp XFree86.spec
> (you may have to resolve some dependency first),then you get a unzip tree under
> /usr/src/redhat/BUILD/XFree86-4.1.0/
It might be a better idea to try xfree86-cvs it has loadable modules
which speeds up recompiling/relinking a lot and furthermore has some of
your problems fixed.
 -- Guido
