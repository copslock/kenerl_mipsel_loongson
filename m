Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jan 2003 05:19:02 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:22055
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225197AbTATFTB>; Mon, 20 Jan 2003 05:19:01 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18aUKp-000O2E-00; Mon, 20 Jan 2003 06:18:59 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18aUKp-0006Ff-00; Mon, 20 Jan 2003 06:18:59 +0100
Date: Mon, 20 Jan 2003 06:18:59 +0100
To: linux-mips@linux-mips.org
Cc: Karsten Merker <karsten@excalibur.cologne.de>
Subject: Re: Problems booting
Message-ID: <20030120051859.GG14931@rembrandt.csv.ica.uni-stuttgart.de>
References: <1042769475.2735.161.camel@Opus> <20030117061047.GA474@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117061047.GA474@excalibur.cologne.de>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Karsten Merker wrote:
> On Thu, Jan 16, 2003 at 09:11:14PM -0500, Justin Pauley wrote:
> 
> > Well, MOPD works now! And I installed debian linux. However, now when i
> > try to boot with:
> > boot 3/rz0/vmlinux console=ttyS0 
> > I get the following:
> > delo V0.7 Copyright....
> > extfs_open returned Unknown ext2 error(2133571404)

I believe this is fixed in my improved version of delo. If you aren't afraid
of raw source tarballs and want to try it out, it's available at
http://www.csv.ica.uni-stuttgart.de/homes/ths/linux-mips/delo/

> > Couldnt fetch config.file /etc/delo.cconf
> 
> Try just booting with "boot 3/rz0" without further parameters. Delo takes
> its parameters a bit differently than e.g. Ultrixboot and if given no
> parameters, it should use the default values from the installation process.
> If this does not help: do you have /boot and /etc on the same partition? If
> not, this might cause the problem. AFAIK delo cannot handle the config file
> on one and the kernel on another partition. Flo, Thiemo?

Yes, still true, even for my improved version of delo.


Thiemo
