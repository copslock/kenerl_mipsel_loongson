Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2002 20:45:37 +0100 (CET)
Received: from p508B5FFC.dip.t-dialin.net ([80.139.95.252]:55204 "EHLO
	p508B5FFC.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122121AbSJaTpg>; Thu, 31 Oct 2002 20:45:36 +0100
Received: from [IPv6:::ffff:204.127.202.61] ([IPv6:::ffff:204.127.202.61]:56218
	"EHLO sccrmhc01.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S867025AbSJaTpR>; Thu, 31 Oct 2002 20:45:17 +0100
Received: from lucon.org ([12.234.88.146]) by sccrmhc01.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021031194449.FZID8743.sccrmhc01.attbi.com@lucon.org>;
          Thu, 31 Oct 2002 19:44:49 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 318F52C4EC; Thu, 31 Oct 2002 11:44:49 -0800 (PST)
Date: Thu, 31 Oct 2002 11:44:49 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
Cc: 'Ralf Baechle' <ralf@linux-mips.org>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: NFS Root broken in 2.4.18?  Anyone successfully booted?
Message-ID: <20021031114449.A20815@lucon.org>
References: <CBD6266EA291D5118144009027AA63350A68F183@xboi05.boi.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <CBD6266EA291D5118144009027AA63350A68F183@xboi05.boi.hp.com>; from roger_twede@hp.com on Thu, Oct 31, 2002 at 01:28:05PM -0500
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 31, 2002 at 01:28:05PM -0500, TWEDE,ROGER (HP-Boise,ex1) wrote:
> Ralf et al,
> 
> I found that the 2.4.18 system boots fine when booting from standard devices
> (IDE disks etc.).
> 
> Init fails to execute successfully when booting from NFS.  The NFS booting
> success appears to have died with 2.4.18.
> 
> The NFS boot completes fine in 2.4.17 but in 2.4.18 the NFS root is mounted
> and /sbin/init and the ld.so.1 are at least accessed, but the system never
> executes far enough in user space to even print a message to the console.
> 
> I've tried two different network card types just to be sure it wasn't a
> single driver issue.
> 
> Has anyone noticed this or does anyone know what changes may have caused
> this in 2.4.18? 
> I'm curious whether anyone has successfully booted 2.4.18 over NFS.
> 

Works fine with 2.4.20-pre6 in CVS.


H.J.
