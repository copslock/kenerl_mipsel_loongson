Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2004 10:47:17 +0100 (BST)
Received: from webmail.ict.ac.cn ([IPv6:::ffff:159.226.39.7]:39106 "HELO
	ict.ac.cn") by linux-mips.org with SMTP id <S8225005AbUICJrN>;
	Fri, 3 Sep 2004 10:47:13 +0100
Received: (qmail 25349 invoked by uid 507); 3 Sep 2004 09:33:47 -0000
Received: from unknown (HELO ict.ac.cn) (fxzhang@159.226.40.187)
  by ict.ac.cn with SMTP; 3 Sep 2004 09:33:47 -0000
Message-ID: <4138E684.2020403@ict.ac.cn>
Date: Sat, 04 Sep 2004 05:47:48 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: xuhaoz <xuhaoz@neonetech.com>
CC: linux-mips <linux-mips@linux-mips.org>
Subject: Re: 
References: <NNT0kkZIhTrBoe2U8QV00000033@nnt.neonetech.com>
In-Reply-To: <NNT0kkZIhTrBoe2U8QV00000033@nnt.neonetech.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

This is probably nothing to do with mips thus not so suitable to appear
here:)

xuhaoz wrote:

>hi:
>
>	does somebody meet a problem like this?
>
>	static void __init init_mount_tree(void)
>	{
>		mnt=do_kern_mount("rootfs",0,"rootfs",NULL);
>		if(IS_ERR(mnt))
>			panic("can't creat rootfs");
>  
>
>	}
>  
>

And I think you should really do a little more before ask for such questions
(I will attach you a copy of the famous "How To Ask Questions The Smart Way"
,hope that helps:)

You can use ctags or some other code reading tools(e.g. source insight) to
dig in the code, it is not hard to find out where are the possible
failing reasons
then you can insert printks to test your thoughts.

Maybe you can use remote debug to trace the code too.

>	when uclinux run here, it report panic, and i wonder which cause this problem?
>	would you please give a hint? any suggestion will appreciated!! 
>	thank you !!
>
>
>
>
>  
>
