Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARHwdu26499
	for linux-mips-outgoing; Tue, 27 Nov 2001 09:58:39 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARHwao26496
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 09:58:36 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fARGwFh7021779;
	Tue, 27 Nov 2001 08:58:15 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fARGwEHx021775;
	Tue, 27 Nov 2001 08:58:15 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 27 Nov 2001 08:58:14 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Florian Lohoff <flo@rfc822.org>
cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] NONCOHERENT_IO Decstation ?!
In-Reply-To: <20011127122152.F27987@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.10.10111270855180.21131-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> Without:
> 
> 
> Index: arch/mips/config.in
> ===================================================================
> RCS file: /cvs/linux/arch/mips/config.in,v
> retrieving revision 1.151
> diff -u -r1.151 config.in
> --- arch/mips/config.in	2001/11/26 12:01:08	1.151
> +++ arch/mips/config.in	2001/11/27 12:17:26
> @@ -292,6 +292,10 @@
>         define_bool CONFIG_PC_KEYB y
>  fi                             
>  
> +if [ "$CONFIG_DECSTATION" = "y" ]; then
> +       define_bool CONFIG_NONCOHERENT_IO y
> +fi
> +
>  if [ "$CONFIG_ISA" != "y" ]; then
>     define_bool CONFIG_ISA n
>     define_bool CONFIG_EISA n

We got nailed by this to. Ralph I like to suggest that we add 

set CONFIG_NONCOHERENT_IO 

to arch/mips/Config.in since most devices of this type don't support 
IO coherency. 
