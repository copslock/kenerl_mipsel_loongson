Received:  by oss.sgi.com id <S42243AbQIYOVG>;
	Mon, 25 Sep 2000 07:21:06 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:11780 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42201AbQIYOU4>;
	Mon, 25 Sep 2000 07:20:56 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4477D801; Mon, 25 Sep 2000 16:27:07 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8F1DA9014; Mon, 25 Sep 2000 16:15:00 +0200 (CEST)
Date:   Mon, 25 Sep 2000 16:15:00 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-origin@oss.sgi.com
Subject: Re: libc upgrade
Message-ID: <20000925161500.A4773@paradigm.rfc822.org>
References: <20000922152604.A2627@bacchus.dhis.org> <20000925112413.B3247@paradigm.rfc822.org> <20000925132056.A7598@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20000925132056.A7598@bacchus.dhis.org>; from ralf@oss.sgi.com on Mon, Sep 25, 2000 at 01:20:56PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Sep 25, 2000 at 01:20:56PM +0200, Ralf Baechle wrote:
> On Mon, Sep 25, 2000 at 11:24:13AM +0200, Florian Lohoff wrote:
> 
> > Build fails on mipsel ...
> 
> These messages look like file corruption.  Maybe one of the `features'
> of the 2.4.0-test kernels and not libc at all?

I dont think so - I succeeded to compile ~2000 Packages of debian
on this kernel and its noticeably the first execution with the "new" ld.so

LD_LIBRARY_PATH=..:../elf:../nss ../elf/ld.so.1 ./rpcgen -c rpcsvc/bootparam.x -o xbootparam.T
/bin/sh: invalid character 45 in exportstr for full-config-sysdirs
make[1]: *** [xbootparam.stmp] Segmentation fault

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
