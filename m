Received:  by oss.sgi.com id <S42406AbQI2PsU>;
	Fri, 29 Sep 2000 08:48:20 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:1810 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42190AbQI2PsP>;
	Fri, 29 Sep 2000 08:48:15 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0A6F57D9; Fri, 29 Sep 2000 17:48:14 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8C33B9014; Fri, 29 Sep 2000 17:24:35 +0200 (CEST)
Date:   Fri, 29 Sep 2000 17:24:35 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Re: no controlling tty on mipsel
Message-ID: <20000929172435.A5710@paradigm.rfc822.org>
References: <20000825221620.A1280@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20000825221620.A1280@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Aug 25, 2000 at 10:16:20PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Aug 25, 2000 at 10:16:20PM +0200, Florian Lohoff wrote:
> Hi,
> with the declinux root and the glibc 2.0.6-5lm (Current rpm)
> i get the following error on BOTH decstations i have up and
> running (Both R4000)
> 
> [flo@reconfig most]$ scp *.deb *.changes root@repeat.rfc822.org:/ftp.rfc822.org/packages
> You have no controlling tty.  Cannot read passphrase.
> 
> lost connection
> 
> [flo@reconfig most]$ tty
> /dev/ttyp0
> 
> Hmmm ... 
> 
> Ideas ?

/dev/tty permissions ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
